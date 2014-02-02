Session.set('showCreateRoomForm', false)
Session.set('newRoomSecret', Random.id())

Template.rooms.helpers(
    showCreateRoomForm: -> Session.get('showCreateRoomForm')
    getNewRoomSecret:   -> Session.get('newRoomSecret')
    srcLangInError:     -> Session.get('srcLangInError')
    dstLangInError:     -> Session.get('dstLangInError')
    roomNameInError:    -> Session.get('roomNameInError')
)

Template.rooms.events(
    'submit #new-room-form': (ev, templ) ->
        ev.preventDefault()


        [roomName, roomSecret, srcLang, dstLang] =
          [ templ.find('[name="room-name"]').value,
            templ.find('[name="room-secret"]').value,
            templ.find('[name="src-lang"]').value,
            templ.find('[name="dst-lang"]').value
          ]

        checkValid = (str, sessionErrState) ->
            isStrValid = str? and str.length > 0
            Session.set(sessionErrState, if isStrValid then '' else 'error')
            isStrValid

        isFormValid =
            checkValid(roomName   , 'roomNameInError')   &&
            checkValid(roomSecret , 'roomSecretInError') &&
            checkValid(srcLang    , 'srcLangInError')    &&
            checkValid(dstLang    , 'dstLangInError')

        if isFormValid
            Meteor.call(
                'addRoom',
                roomName,
                roomSecret,
                srcLang,
                dstLang
            )
            Session.set('showCreateRoomForm', false)



    'click #add-room': (ev, tmpl) ->
        Session.set('showCreateRoomForm', true)
        # Generate a new secret every time a room is created
        Session.set('newRoomSecret', Random.id())

    'click #cancel-add-room': (ev, tmpl) ->
        Session.set('showCreateRoomForm', false)
)

