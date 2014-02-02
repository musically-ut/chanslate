@getLastMessageTime = ->
    lastMessage = ChanslateMessages.findOne({}, {
        sort:
            at: -1
    })
    if lastMessage? then lastMessage.at else new Date(0)

Meteor.methods(
    addSrcMessage: (userId, roomId, msg, engines, srcLang, dstLang) ->
        console.log('Adding src message:', msg, ' ~ ', userId)

        if not @isSimulation
            @unblock()
            _id = ChanslateMessages.insert(
                createChanslateMsgDoc(
                    userId,
                    roomId,
                    msg,
                    srcLang,
                    engines,
                    getLastMessageTime()
                )
            )
            console.log('inserted message _id: ', _id)
            translateAndPopulate(msg, srcLang, dstLang, engines, _id)

    addDstMessage: (userId, roomId, msg, engines, srcLang, dstLang) ->
        console.log('Adding dst message:', msg, ' ~ ', userId)

        if not @isSimulation
            @unblock()
            _id = ChanslateMessages.insert(
                createChanslateMsgDoc(
                    userId,
                    roomId,
                    msg,
                    dstLang,
                    engines,
                    getLastMessageTime()
                )
            )
            translateAndPopulate(msg, dstLang, srcLang, engines, _id)
)
