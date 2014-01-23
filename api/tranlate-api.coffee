srcLang = 'en'
dstLang = 'de'

@getLastMessageTime = ->
    lastMessage = ChanslateMessages.findOne({}, {
        sort:
            at: -1
    })
    if lastMessage? then lastMessage.at else new Date(0)

Meteor.startup ->
    Meteor.methods(
        addSrcMessage: (userName, msg, engines) ->
            console.log('Adding src message:', msg, ' ~ ', userName)

            if not this.isSimulation
                this.unblock()
                _id = ChanslateMessages.insert(
                    createChanslateMsgDoc(
                        userName,
                        msg,
                        srcLang,
                        engines,
                        getLastMessageTime()
                    )
                )
                translateAndPopulate(msg, srcLang, dstLang, engines, _id)

        addDstMessage: (userName, msg, engines) ->
            console.log('Adding dst message:', msg, ' ~ ', userName)

            if not this.isSimulation
                this.unblock()
                _id = ChanslateMessages.insert(
                    createChanslateMsgDoc(
                        userName,
                        msg,
                        dstLang,
                        engines,
                        getLastMessageTime()
                    )
                )
                translateAndPopulate(msg, dstLang, srcLang, engines, _id)
    )
