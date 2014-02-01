Template.rooms.events(
    'click #create-room': (ev, tmpl) ->
        userId = Meteor.user()._id
        userName = Meteor.user().username
        console.log('Creating room.')

        # TODO(UU): Totally insecure
        ChanslateRooms.insert({
            createdAt       : new Date
            name            : 'Test'
            secret          : 'test-secret'
            users           : [{
                                  id   : userId
                                  name : userName
                              }]
            engines         : [ 'google', 'bing' ]
            createdByUserId : userId
            srcLang         : 'en'
            dstLang         : 'de'
        })
)
