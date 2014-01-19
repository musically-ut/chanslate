url = 'https://www.googleapis.com/language/translate/v2'

srcLang = 'en'
dstLang = 'de'

createMessage = (lang, text, createdBy, error) ->
    check(lang      , String)
    check(text      , String)
    check(createdBy , String)
    check(error     , Boolean)
    {
        lang      : lang
        text      : text
        createdBy : createdBy
        error     : error
    }


createChanslateMsgDoc = (userName, origMsg, origLang) ->
    {
        userName     : userName
        at           : new Date()
        original     : createMessage(origLang, origMsg, userName, false)
        translations : []
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


translateAndPopulate = (msg, sourceLang, targetLang, _id) ->
    modifier = {}
    try
        translatedMsg = translate(msg, sourceLang, targetLang)
        modifier.translations =
            createMessage(targetLang , translatedMsg, 'google', false)

        ChanslateMessages.update({ _id: _id }, {
            $push: modifier
        })

    catch error
        console.error('Could not translate: ', error)
        modifier.translations =
            createMessage(
                targetLang,
                'Could not translate.',
                'google',
                true
            )

        ChanslateMessages.update({ _id: _id }, {
            $push: modifier
        })


Meteor.startup ->
    Meteor.methods(
        addSrcMessage: (userName, msg) ->
            console.log('Adding src message:', msg, ' ~ ', userName)

            checkParams(userName, msg)
            msg = truncMessage(msg)

            if not this.isSimulation
                this.unblock()
                _id = ChanslateMessages.insert(
                    createChanslateMsgDoc(userName, msg, srcLang)
                )
                translateAndPopulate(msg, srcLang, dstLang, _id)

        addDstMessage: (userName, msg) ->
            console.log('Adding dst message:', msg, ' ~ ', userName)

            checkParams(userName, msg)
            msg = truncMessage(msg)

            if not this.isSimulation
                this.unblock()
                _id = ChanslateMessages.insert(
                    createChanslateMsgDoc(userName, msg, dstLang)
                )
                translateAndPopulate(msg, dstLang, srcLang, _id)
    )


