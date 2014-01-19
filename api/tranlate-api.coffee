srcLang = 'en'
dstLang = 'de'

Meteor.startup ->
    Meteor.methods(
        addSrcMessage: (userName, msg) ->
            console.log('Adding src message:', msg, ' ~ ', userName)

            if not this.isSimulation
                this.unblock()

                checkTranslationParams(userName, msg)
                msg = truncMessage(msg)
                _id = ChanslateMessages.insert(
                    createChanslateMsgDoc(userName, msg, srcLang)
                )
                translateAndPopulate(msg, srcLang, dstLang, _id)

        addDstMessage: (userName, msg) ->
            console.log('Adding dst message:', msg, ' ~ ', userName)

            if not this.isSimulation
                this.unblock()

                checkTranslationParams(userName, msg)
                msg = truncMessage(msg)
                _id = ChanslateMessages.insert(
                    createChanslateMsgDoc(userName, msg, dstLang)
                )
                translateAndPopulate(msg, dstLang, srcLang, _id)
    )
