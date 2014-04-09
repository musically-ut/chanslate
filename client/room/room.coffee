isInputFocussed = false

Meteor.startup ->
    setUpNotification(getLastMessageTime())

#######################################
# Notification Permission template
#######################################


Template
    .requestNotificationPermission
    .needsPermissionAndSupported = ->
        Session.get('notificationPermissionsNeeded')

Template.requestNotificationPermission.events(
    'click #request-notification-permission': (ev, template) ->
        body = Session.get('pendingMessagesNotificationBody')
        Session.set('notificationPermissionsNeeded', false)
        Session.set('haveNotificationPermission', true)
        makeNotification(body).requestPermission()
)

currentNotification = null

#######################################
# ShowMessage template
#######################################

# Template helpers
Template.showMessages.helpers({
    messages: ->
        cursor = ChanslateMessages.find({}, {sort: { at: 1 }})
        cursor.observe({
            # Avoids scrolling to the bottom immediately after site loads and
            # the associated notifications.
            _suppress_initial: true
            added: ->
                scrollToBottom()
                havePermission = Session.get('haveNotificationPermission')
                if not isInputFocussed and havePermission
                    body = Session.get('pendingMessagesNotificationBody')
                    currentNotification = makeNotification(body)
                    currentNotification.show()
        })
        cursor

    messageSenderClass: ->
        if Meteor.user() && Meteor.user()._id == @userId
            "self"
        else
            "other"

    hasFirstTranslation: ->
        @translations.length > 0

    getFirstTranslation: ->
        arr = @translations
        if arr.length > 0
            arr[0]
        else
            undefined

    enumTranslations: ->
        arr = @translations
        arr.map((item,index) ->
            _.extend({},
                {
                    '$index'        : index
                    '$indexBaseOne' : index + 1
                    '$first'        : index == 0
                    '$last'         : index == arr.length - 1
                },
                item
            )
        )

    createdByGoogle: ->
        firstTranslation = @translations[0]
        firstTranslation? and firstTranslation.createdBy == 'google'

    createdByBing: ->
        firstTranslation = @translations[0]
        firstTranslation? and firstTranslation.createdBy == 'bing'

})

#######################################
# Avatar template
#######################################

Template.avatar.gravatarLink = ->
    user = Meteor.users && Meteor.users.findOne({ _id: @createdBy })

    # Eventually, move to using user e-mail here instead of username
    username = if user? then user.username else @createdBy
    hash = hex_md5(username)
    '//www.gravatar.com/avatar/' + hash + '?d=wavatar'

#######################################
# PostMessage template
#######################################

toggleEngine = (engineName) ->
    engines = Session.get('engines')
    if engineName in engines
        engines.splice(engines.indexOf(engineName), 1)
    else
        engines.push(engineName)
    Session.set('engines', engines)


Template.postMessage.bingChecked = ->
    if 'bing' in Session.get('engines') then 'checked' else ''

Template.postMessage.googleChecked =  ->
    if 'google' in Session.get('engines') then 'checked' else ''


Template.postMessage.srcLang = -> Session.get('currentRoom').srcLang
Template.postMessage.dstLang = -> Session.get('currentRoom').dstLang

# Should listen to `transitionend` event on the <input> elements, but browser
# support for it is pretty flaky. Hence, using this hack to allow SemanticUI
# transitions to take place.
transitionTime = 250
Template.postMessage.events(
    'focus input': (ev, template) ->
        # If the user focusses the input box, close the notifications
        if currentNotification?
            currentNotification.close()
            currentNotification = null

        isInputFocussed = true

    'blur input': (ev, template) ->
        Session.set(
            'pendingMessagesNotificationBody',
            createNotificationBody(getLastMessageTime())
        )
        isInputFocussed = false

    'click input[name="google"]':  ->
        Meteor.setTimeout(
            -> toggleEngine('google'),
            transitionTime
        )

    'click input[name="bing"]': ->
        Meteor.setTimeout(
            -> toggleEngine('bing'),
            transitionTime
        )

    'keyup input[name="src"]': (ev, template) ->
        if ev.which == 13
            console.log('Handling source message')
            textBox = template.find('[name="src"]')
            text = textBox.value

            currentRoom = Session.get('currentRoom')

            if not currentRoom?
                alert('Not inside a room?')
                return

            if not Meteor.user()?
                alert('User not logged in?')
                return

            if text.length > 0
                Meteor.call(
                    'addSrcMessage',
                    Meteor.user()._id,
                    currentRoom._id
                    text,
                    Session.get('engines'),
                    currentRoom.srcLang
                    currentRoom.dstLang
                )

            textBox.value = ''
            textBox.focus()

    'keyup input[name="dst"]': (ev, template) ->
        if ev.which == 13
            console.log('Handling dst message')
            textBox = template.find('[name="dst"]')
            text = textBox.value

            currentRoom = Session.get('currentRoom')

            if not currentRoom?
                alert('Not inside a room?')
                return

            if not Meteor.user()?
                alert('User not logged in?')
                return

            if text.length > 0
                Meteor.call(
                    'addDstMessage',
                    Meteor.user()._id,
                    currentRoom._id
                    text,
                    Session.get('engines'),
                    currentRoom.srcLang,
                    currentRoom.dstLang
                )

            textBox.value = ''
            textBox.focus()
)
