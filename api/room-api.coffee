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
)
