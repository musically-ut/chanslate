xmldom = Meteor.npmRequire('xmldom')
xmlSerializer = (new xmldom.XMLSerializer()).serializeToString

googla_url = 'https://www.googleapis.com/language/translate/v2'
bing_url   = 'https://api.microsofttranslator.com/v2/Http.svc/Translate'


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


translateUsingGoogle = (text, source, target, cb) ->
    check(text   , String)
    check(source , String)
    check(target , String)

    console.log('Translating using Google ... ')

    if Meteor.settings.GOOGLE_TRANSLATE_API?
        HTTP.call(
            "POST",
            googla_url,
            {
                params:
                    source : source
                    target : target
                    # TODO: Move `key` to headers
                    key    : Meteor.settings.GOOGLE_TRANSLATE_API
                    q      : text
                headers:
                    'X-HTTP-Method-Override': 'GET'
            },
            (err, res) ->
                translatedMsg = 'Google translation failed.'
                if not err
                    try
                        translatedMsg = res.data.data
                                           .translations[0].translatedText
                    catch exept
                        console.error(
                            'Google translation failed with exception:',
                            except
                        )
                else
                    console.log('Google translate API response:')
                    console.log(JSON.stringify(res, null, 2))

                cb(err, translatedMsg)
        )
    else
        console.error('Proper settings for Google API not provided!')
        cb(null, 'No translation from Google available')

translateUsingBing = (text, source, target, cb) ->

    check(text   , String)
    check(source , String)
    check(target , String)

    console.log('Translating using Bing ... ')

    if @BingAccessTokenManager?
        token = BingAccessTokenManager.getToken()
        HTTP.call(
            "GET",
            bing_url,
            {
                params:
                    'app_id'      : ''
                    'text'        : text
                    'from'        : source
                    'to'          : target
                    'contentType' : 'text/plain'

                headers:
                    'Authorization': 'Bearer ' + token
            },
            (err, res) ->
                translatedMsg = 'Bing translation failed.'
                if not err
                    # Data format:
                    #  {
                    #  ...
                    #  "content":
                    #  '<string xmlns=
                    #     "http://schemas.microsoft.com/2003/10/Serialization/">
                    #      Versuch das mal.
                    #  </string>'
                    #  }
                    try
                        content = (new xmldom.DOMParser())
                                        .parseFromString(res.content)
                        translatedMsg = content.firstChild.firstChild.data
                    catch except
                        console.error(
                            'Bing translation failed with exception:',
                            except
                        )
                else
                    console.log('Bing translate API response:')
                    console.log(JSON.stringify(res, null, 2))

                cb(err, translatedMsg)
        )
    else
        console.error('Could not locate BingAccessTokenManager')
        cb(null, 'No translation from Bing available')


_tryTranslation = (methodFunc, methodName, msg, sourceLang, targetLang, _id) ->
    cb = (error, translatedMsg) ->
        modifier = {}
        if not error
            modifier.translations =
                createMessage(
                    targetLang,
                    translatedMsg,
                    methodName,
                    false
                )
        else
            console.error('Could not translate: ', error)
            modifier.translations =
                createMessage(
                    targetLang,
                    'Could not translate.',
                    methodName,
                    true
                )

        ChanslateMessages.update({ _id: _id }, {
            $push: modifier
        })

    methodFunc(msg, sourceLang, targetLang, cb)

truncMessage = (msg, limit) -> msg.substr(0, limit)

################################################################
### Exported methods and values
################################################################

@google = 'google'
@bing   = 'bing'

@translateAndPopulate = (msg, sourceLang, targetLang, engines, _id) ->
    if google in engines
        _tryTranslation(
            translateUsingGoogle,
            google,
            msg,
            sourceLang,
            targetLang,
            _id
        )

    if bing in engines
        _tryTranslation(
            translateUsingBing,
            bing,
            msg,
            sourceLang,
            targetLang,
            _id
        )

@createChanslateMsgDoc = (uId, roomId, msg, lang, engines, lastAt) ->
    check(uId      , String)
    check(roomId   , String)
    check(msg      , String)
    check(lang     , String)
    check(engines  , [String])
    check(lastAt   , Date)

    msg = truncMessage(msg)

    {
        original     : createMessage(lang, msg, uId, false)
        translations : []
        engines      : engines

        userId       : uId
        roomId       : roomId
        at           : new Date()
        lastAt       : lastAt
    }


