isInputFocussed = false

Meteor.startup ->
    setUpNotification(getLastMessageTime())

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
                    makeNotification(body).show()
        })
        cursor

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
})


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

Template.postMessage.events(
    'focus input': (ev, template) ->
        isInputFocussed = true

    'blur input': (ev, template) ->
        Session.set(
            'pendingMessagesNotificationBody',
            createNotificationBody(getLastMessageTime())
        )
        isInputFocussed = false

    'click input[name="google"]':  ->
        toggleEngine('google')

    'click input[name="bing"]': ->
        toggleEngine('bing')


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
