Meteor.subscribe('chanslateMessages')
Session.set('userName', haiku())

isInputFocussed = false

pendingMessagesNotification = new Notify('Messages', {
    body: 'On Chanslate',
    permissionGranted: ->
        Session.set('haveNotificationPermission', true)
        Session.set('notificationPermissionsNeeded', false)

    permissionDenied: ->
        Session.set('haveNotificationPermission', false)
        Session.set('notificationPermissionsNeeded', false)
})

Session.set(
    'notificationPermissionsNeeded',
    pendingMessagesNotification.isSupported() and
    pendingMessagesNotification.needsPermission()
)

Session.set(
    'haveNotificationPermission',
    not pendingMessagesNotification.needsPermission()
)


Template.requestNotificationPermission.needsPermissionAndSupported = ->
    Session.get('notificationPermissionsNeeded')

Template.requestNotificationPermission.events(
    'click #request-notification-permission': (ev, template) ->
        pendingMessagesNotification.requestPermission()
)


# Template helpers
Template.showMessages.helpers({
    messages: ->
        cursor = ChanslateMessages.find({}, {sort: { at: 1 }})
        cursor.observe({ added: ->
            scrollToBottom()
            if not isInputFocussed and Session.get('haveNotificationPermission')
                pendingMessagesNotification.show()
        })
        cursor

    enumTranslations: ->
        arr = @translations
        arr.map((item,index) ->
            # Adding an `_id` to handle this issue:
            # https://github.com/meteor/meteor/issues/281
            _.extend({},
                {
                    '$index' : index
                    '$first' : index == 0
                    '$last'  : index == arr.length - 1
                },
                item
            )
        )
})

Template.postMessage.events(
    'focus input': (ev, template) ->
        isInputFocussed = true

    'blur input': (ev, template) ->
        isInputFocussed = false

    'keyup input[name="src"]': (ev, template) ->
        if ev.which == 13
            console.log('Handling source message')
            textBox = template.find('[name="src"]')
            text = textBox.value

            if text.length > 0
                Meteor.call(
                    'addSrcMessage',
                    Session.get('userName'),
                    text
                )

            textBox.value = ''
            textBox.focus()

    'keyup input[name="dst"]': (ev, template) ->
        if ev.which == 13
            console.log('Handling dst message')
            textBox = template.find('[name="dst"]')
            text = textBox.value

            if text.length > 0
                Meteor.call(
                    'addDstMessage',
                    Session.get('userName'),
                    text
                )

            textBox.value = ''
            textBox.focus()
)
