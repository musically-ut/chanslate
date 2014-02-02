Meteor.methods(
    addRoom: (roomName, roomSecret, srcLang, dstLang) ->
        check(roomName, String)

        # Should check quality of secret here
        check(roomSecret, String)

        # Should have stricter checks for language codes
        check(srcLang, String)
        check(dstLang, String)

        user = Meteor.user()

        if not user?
            throw Meteor.error('Cannot create room: No user is signed in.')

        if not @isSimulation
            ChanslateRooms.insert({
                createdAt       : new Date
                name            : roomName
                secret          : roomSecret
                users           : [{
                                      id   : user._id
                                      name : user.username
                                  }]
                engines         : [ 'google', 'bing' ]
                createdByUserId : user._id
                srcLang         : srcLang
                dstLang         : dstLang
            })


    # Check if the currently logged in user has the correct secret.
    # If yes, then add him to the group. Otherwise, throw an error (do not
    # differentiate between missing room and incorrect secret.)
    verifyAndAddUser: (roomId, roomSecret) ->
        check(roomId     , String)
        check(roomSecret , String)

        user = Meteor.user()

        if not user?
            throw Meteor.error('No user logged in. Cannot add nobody to room.')

        console.log('Trying to log in to: ', roomId)

        if not @isSimulation
            room = ChanslateRooms.findOne({ _id: roomId })

            if room?
                if room.secret == roomSecret
                    console.log('Yay! Correct secret!')
                    existingUserIds = room.users.map((user) -> user.id)

                    if existingUserIds.indexOf(user._id) == -1
                        ChanslateRooms.update({ _id: roomId }, {
                            $push:
                                users:
                                    id   : user._id
                                    name : user.username
                        })
                    else
                        console.log('User already existed.')
                else
                    console.log('Incorrect secret supplied.')
                    throw Meteor.Error('Access denied')
            else
                console.log('RoomId: ', roomId, ' does not exist.')
                throw Meteor.Error('Access denied')

)
