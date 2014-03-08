Session.set('showCreateRoomForm', false)
Session.set('newRoomSecret', Random.id())

Session.set('roomWithUserListOpen', null)
Session.set('roomWithConfirmationOpen'  , null)

Template.rooms.helpers(
    showCreateRoomForm: -> Session.get('showCreateRoomForm')
    getNewRoomSecret:   -> Session.get('newRoomSecret')
    srcLangInError:     -> Session.get('srcLangInError')
    dstLangInError:     -> Session.get('dstLangInError')
    roomNameInError:    -> Session.get('roomNameInError')

    showConfirmRemove: (room) ->
        Session.equals('roomWithConfirmationOpen', room._id)

    isAdmin: ->
        user = Meteor.user()
        if user? then user._id == @createdByUserId else false

    roomSecretLink:     ->
        path = Router.routes['room'].path({ _id: @_id }, {
            query:
                secret: @secret
        })

        port = window.location.port
        origin = window.location.protocol + "//" + window.location.hostname +
                 (if port then ':' + port else '')

        origin + path
)

# TODO (UU): Separate out {{room-item}} into a separate template.
Template.rooms.events(
    'click .js-delete': (ev, templ) ->
        ev.preventDefault()
        Session.set('roomWithConfirmationOpen', @_id)

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

    'click .js-verify-confirmation': (ev, tmpl) ->
        Meteor.call('deleteRoomOrMember', $(ev.target).data('room-id'));

    'click .js-cancel-confirmation': (ev, tmpl) ->
        Session.set('roomWithConfirmationOpen', null)
)

Template.rooms.rendered = ->
    $('.tooltip').popup({
        transition: 'fade up'
    })

