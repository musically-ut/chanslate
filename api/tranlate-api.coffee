url = 'https://www.googleapis.com/language/translate/v2'

srcLang = 'en'
dstLang = 'de'

translate = (text, source, target) ->
    check(text   , String)
    check(source , String)
    check(target , String)

    console.log('Translating ... ')

    if Meteor.settings.GOOGLE_TRANSLATE_API?
        res = HTTP.call(
            "POST",
            url,
            {
                params:
                    source : source
                    target : target
                    # TODO: Move `key` to headers
                    key    : Meteor.settings.GOOGLE_TRANSLATE_API
                    q      : text
                headers:
                    'X-HTTP-Method-Override': 'GET'
            }
        )

        console.log(JSON.stringify(res, null, 2))
        res.data.data.translations[0].translatedText
    else
        console.error('Proper settings not provided!')
        'No translate API key available.'

createMessage = (userName, srcMsg, dstMsg) ->
    {
        userName: userName
        at: new Date()
        src:
            lang     : srcLang
            text     : srcMsg
            original : srcMsg != null
        dst:
            lang     : dstLang
            text     : dstMsg
            original : dstMsg != null
    }

checkParams = (userName, msg) ->
    check(userName , String)
    check(msg      , String)


truncMessage = (msg, limit) ->
    if msg.length > limit
        msg.substr(0, limit)
    else
        msg




Meteor.startup ->
    Meteor.methods(
        addSrcMessage: (userName, msg) ->
            # TODO (UU): This can fail.
            console.log('Adding src message:', msg, ' ~ ', userName)

            checkParams(userName, msg)
            msg = truncMessage(msg)

            if not this.isSimulation
                this.unblock()
                console.log(
                    'Inserting',
                    createMessage(userName, msg, null)
                )
                _id = ChanslateMessages.insert(
                    createMessage(userName, msg, null)
                )
                translatedMsg = translate(msg, srcLang, dstLang)
                ChanslateMessages.update({ _id: _id }, {
                    $set:
                        'dst.text': translatedMsg
                })

        addDstMessage: (userName, msg) ->
            # TODO (UU): This can fail.
            console.log('Adding dst message:', msg, ' ~ ', userName)

            checkParams(userName, msg)
            msg = truncMessage(msg)

            if not this.isSimulation
                this.unblock()
                _id = ChanslateMessages.insert(
                    createMessage(userName, null, msg)
                )
                translatedMsg = translate(msg, dstLang, srcLang)
                ChanslateMessages.update({ _id: _id }, {
                    $set:
                        'src.text': translatedMsg
                })
    )


