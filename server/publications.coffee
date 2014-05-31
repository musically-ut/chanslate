## The rooms visible to the current user
userRooms = (userId) ->
    check(userId, String)
    ChanslateRooms.find({
        users:
            $elemMatch:
                id: userId
    })


# On returning `undefined` from publications, the subscriptions never become
# ready?
Meteor.publish('chanslateRoomAndMessages', (roomId) ->
    check(roomId, String)

    if not @userId?
        return []

    roomIds = userRooms(@userId).fetch().map((e) -> e._id)
    if _.indexOf(roomIds, roomId) == -1
        console.error('Tried to access the room with id: ',
            roomId, ' which does not yet exist for this user.')
        return []

    # Serve only the last 200 messages
    count = ChanslateMessages.find({ roomId: roomId }).count()
    skip = Math.max(0, count - 200)
    msgs = ChanslateMessages.find(
        {
            roomId: roomId
        }, {
            sort:
                at: 1
            skip: skip
        }
    )

    # Publish both the room and the messages in it
    room = ChanslateRooms.find({ _id: roomId })
    [ msgs, room ]
)

Meteor.publish('chanslateRooms', ->
    if not @userId?
        return []

    userRooms(@userId)
)

Meteor.publish('chanslateUsers', ->
    if not @userId?
        return []

    self = @
    rooms = userRooms(@userId)

    addUsersByIds = (userIds) ->
        userIds.forEach((userId) ->
            self.added(
                'users',
                userId,
                Meteor.users.findOne({ _id: userId })
            )
        )

    # If this user's rooms change, then we should update the list of users that
    # the user can see.
    roomObserverHandle = rooms.observeChanges({
        added: (id, room) ->
            console.log('Adding users: ', room.users)
            addUsersByIds(room.users.map((user) -> user.id))

        changed: (id, roomFields) ->
            if roomFields.users?
                # This DOES NOT remove the user information if the user has
                # been removed from the room. This can be done if we use
                # .observe() since the `changed` function would then get the
                # old and the new document. However, using `.observe` is more
                # computationally expensive than .observeChanges and the
                # security risk is not very great.
                console.log('Users field changed: ', roomFields.users)
                addUsersByIds(roomFields.users.map((user) -> user.id))

        removed: (id) ->
            room = ChanslateRooms.findOne({ _id: id })
            console.log('Removing users: ', room.users)
            room.users.map((user) -> self.removed('users', user.id))
    })

    # Stop observing the rooms when the client stops this subscription
    @.onStop(() ->
        console.log('Stopping roomObserverHandle')
        roomObserverHandle.stop()
    )

    friendIds =
      _.flatten(rooms.fetch().map((room) -> room.users.map((user) -> user.id)))

    # Excluding `profile` and including `username` field caused problems with
    # Meteor.
    Meteor.users.find({
        _id:
            $in: _.uniq(friendIds)
    })
)
