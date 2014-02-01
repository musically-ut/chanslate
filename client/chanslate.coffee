Meteor.startup ->

    ##################
    # Accounts
    ##################
    Accounts.ui.config({
        passwordSignupFields: 'USERNAME_ONLY'
    })

    ##################
    # Routing
    ##################

    # To provide our own template instead of appending route templates to body
    Router.configure(
        autoRender: false
    )

    # If the user is not signed in, render the signin template instead of the
    # actual page. However, keep the URL the same.
    mustBeSignedIn = ->
        if not Meteor.user()?
            @render('signIn')
            @stop()

    Router.before(mustBeSignedIn, {
        except: [ 'signIn' ]
    })

    Router.map( ->

        # This is the default path, redirects to `/rooms` after logging in
        @route('signIn', {
            path: '/'
            before: ->
                # If user is logged in, take him to list of rooms
                if Meteor.user()?
                    this.stop()
                    Router.go('rooms')
        })


        # The list of all rooms
        @route('rooms', {
            path: '/rooms'
            waitOn: ->
                Meteor.subscribe('chanslateRooms')
            data:
                rooms: ChanslateRooms.find({})
        })

        # Showing one particular chat room
        @route('room', {
            path: '/room/:_id'
            notFoundTemplate: 'roomNotFound'
            waitOn: ->
                # This causes both `room` and `messages` to be loaded before
                # proceeding with the rendering of the template
                Meteor.subscribe(
                    'chanslateRoomAndMessages',
                    @params._id
                )

            data: ->
                # TODO (UU): Add a `secret` query parameter to allow users to
                # be added to chat-rooms
                room = ChanslateRooms.findOne({ _id: @params._id })
                Session.set('currentRoom', room)
                Session.set('engines', room.engines)

                # If the room was a valid one, show it.
                # The user cannot distinguish between non-existent and
                # inaccessible chat rooms
                if room?
                    {
                        messages: ChanslateMessages.find({
                            roomId: @params._id
                        })
                    }
                else
                    null
        })
    )
