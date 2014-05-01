Meteor.startup ->

    #################
    # "Friends"
    #################
    # TODO: Re-run the subscription based on updates made to @ChanslateRooms.
    Meteor.subscribe('chanslateUsers')

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
        layoutTemplate: 'masterLayout'
        loadingTemplate: 'loadingTemplate'
    )

    # If the user is not signed in, render the signin template instead of the
    # actual page. However, keep the URL the same.
    mustBeSignedIn = (pause) ->
        if not Meteor.user()?
            if Meteor.loggingIn()
                @render('signingIn')
            else
                @render('signIn')

            pause()

    Router.onBeforeAction(mustBeSignedIn, {
        except: [ 'signIn' ]
    })

    Router.map( ->
        # This is the default path, redirects to `/rooms` after logging in
        @route('signIn', {
            path: '/'
            template: 'signIn'
            onBeforeAction: ->
                # If user is logged in, take him to list of rooms
                if Meteor.user()?
                    Router.go('rooms')
        })

        # The list of all rooms
        @route('rooms', {
            path: '/rooms'
            template: 'rooms'
            waitOn: ->
                Meteor.subscribe('chanslateRooms')
            data:
                rooms: ChanslateRooms.find()
        })

        # Showing one particular chat room, or allowing access to one.
        @route('room', {
            path: '/room/:_id'
            template: 'room'
            waitOn: ->
                # This causes both `room` and `messages` to be loaded before
                # proceeding with the rendering of the template
                Meteor.subscribe(
                    'chanslateRoomAndMessages',
                    @params._id
                )

            data: ->
                room = ChanslateRooms.findOne({ _id: @params._id })

                # If the room was a valid one, show it.
                # The user cannot distinguish between non-existent and
                # inaccessible chat rooms
                if room?
                    Session.set('currentRoom', room)
                    # TODO (UU): Remove this hack (which was in place to make
                    # engines adjustable from inside the rooms). Should be
                    # replaced by a Deps.autorun call inside room.coffee
                    Session.set('engines', room.engines)

                    {
                        roomName: room.name
                        messages: ChanslateMessages.find({
                            roomId: @params._id
                        })
                    }
                else
                    null

            action: ->
                if @ready()
                    data = @data()
                    if data?
                        # Found a room, let's go to it, do not add the user
                        # again to it.
                        @render()
                    else
                        console.log('@params.secret = ', @params.secret)
                        if @params.secret?
                            # The user is trying to add himself to a room
                            console.log('Trying to add user to the chat-room')
                            Meteor.call(
                                'verifyAndAddUser',
                                @params._id,
                                @params.secret,
                                (err, result) =>
                                    if err?
                                        # The user was not granted access or
                                        # the room does not exist.
                                        @render('roomNotFound')
                                    else
                                        # Merely redirecting isn't enough
                                        # because the Subscriptions haven't
                                        # been updated yet. Doing a forced
                                        # reload. @redirect('room', { _id:
                                        # @params._id })
                                        window.location.replace(
                                            window.location.pathname
                                        )
                            )
                        else
                            @render('roomNotFound')
        })
    )
