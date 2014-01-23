isSupported = 'Notification' in this

@createNotificationBody = (lastMsgTime) ->
    {
        body : 'On Chanslate',
        tag  : lastMsgTime,
        permissionGranted: ->
            Session.set('haveNotificationPermission', true)

        permissionDenied: ->
            Session.set('haveNotificationPermission', false)
    }

@makeNotification = (notificationBody) ->
    new Notify('Messages', notificationBody)


@setUpNotification = (lastMsgTime) ->
    pendingMessagesNotificationBody =
        createNotificationBody(lastMsgTime)

    Session.set(
        'pendingMessagesNotificationBody',
        pendingMessagesNotificationBody
    )


    pendingMessagesNotification =
        makeNotification(pendingMessagesNotificationBody)

    Session.set(
        'notificationPermissionsNeeded',
        pendingMessagesNotification.isSupported() and
        pendingMessagesNotification.needsPermission()
    )

    Session.set(
        'haveNotificationPermission',
        not pendingMessagesNotification.needsPermission()
    )



