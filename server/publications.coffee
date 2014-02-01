## The rooms visible to the current user
userRooms = (userId) ->
    check(userId, String)
    ChanslateRooms.find({
        users:
            $elemMatch:
                id: userId
    })


# TODO (UU): This is NOT reactive by default
Meteor.publish('chanslateRoomAndMessages', (roomId) ->
    check(roomId, String)

    if not @userId?
        return

    roomIds = userRooms(@userId).fetch().map((e) -> e._id)
    if _.indexOf(roomIds, roomId) == -1
        console.error('Tried to access an illegal room')
        return

    # Serve only the last 200 messages
    count = ChanslateMessages.find().count()
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
        return

    userRooms(@userId)
)

# TODO (UU): This is NOT reactive by default
Meteor.publish('chanslateUsers', ->
    if not @userId?
        return

    rooms = userRooms(@userId).fetch()
    friendIds = _.flatten(rooms.map(room -> room.users))
    Meteor.users.find(
        {
            _id:
                $in: friendIds
        }, {
            fields:
                username: 1
                profile:  0
        })
)
