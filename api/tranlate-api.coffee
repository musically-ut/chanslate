url = 'https://www.googleapis.com/language/translate/v2'

srcLang = 'en'
dstLang = 'de'

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


translateAndPopulate = (msg, sourceLang, targetLang, _id, key) ->
    modifier = {}
    try
        translatedMsg = translate(msg, sourceLang, targetLang)
        modifier[ key ] = translatedMsg
        ChanslateMessages.update({ _id: _id }, {
            $set: modifier
        })
    catch error
        console.error('Could not translate: ', error)
        modifier[ key ] = 'Could not translate.'
        ChanslateMessages.update({ _id: _id }, {
            $set: modifier
        })


Meteor.startup ->
    Meteor.methods(
        addSrcMessage: (userName, msg) ->
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
                translateAndPopulate(msg, srcLang, dstLang, _id, 'dst.text')

        addDstMessage: (userName, msg) ->
            console.log('Adding dst message:', msg, ' ~ ', userName)

            checkParams(userName, msg)
            msg = truncMessage(msg)

            if not this.isSimulation
                this.unblock()
                _id = ChanslateMessages.insert(
                    createMessage(userName, null, msg)
                )
                translateAndPopulate(msg, dstLang, srcLang, _id, 'src.text')

    )


