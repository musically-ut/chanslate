xmldom = Npm.require('xmldom')
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


translateUsingGoogle = (text, source, target) ->
    check(text   , String)
    check(source , String)
    check(target , String)

    console.log('Translating using Google ... ')

    if Meteor.settings.GOOGLE_TRANSLATE_API?
        res = HTTP.call(
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
            }
        )

        console.log('Google translate API response:')
        console.log(JSON.stringify(res, null, 2))
        res.data.data.translations[0].translatedText
    else
        console.error('Proper settings not provided!')
        'No translate from Google available'

translateUsingBing = (text, source, target) ->

    check(text   , String)
    check(source , String)
    check(target , String)

    console.log('Translating using Bing ... ')

    if @BingAccessTokenManager?
        token = BingAccessTokenManager.getToken()
        res = HTTP.call(
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
            }
        )

        console.log('Bing translate API response:')
        console.log(JSON.stringify(res, null, 2))

        # Data format:
        #  {
        #  ...
        #  "content":
        #  '<string xmlns=
        #      "http://schemas.microsoft.com/2003/10/Serialization/">
        #      Versuch das mal.
        #  </string>'
        #  }
        content = (new xmldom.DOMParser()).parseFromString(res.content)
        content.firstChild.firstChild.data
    else
        console.error('Could not locate BingAccessTokenManager')
        'No translate from Bing available'

_tryTranslation = (methodFunc, methodName, msg, sourceLang, targetLang, _id) ->
    modifier = {}

    try
        translatedMsg = methodFunc(msg, sourceLang, targetLang)
        modifier.translations =
            createMessage(targetLang , translatedMsg, methodName, false)

        ChanslateMessages.update({ _id: _id }, {
            $push: modifier
        })

    catch error
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



################################################################
### Exported methods and values
################################################################

@translateAndPopulate = (msg, sourceLang, targetLang, _id) ->
    # TODO (UU): These calls should be made in parallel
    # But doing that for some reason blows the stack.
    _tryTranslation(
        translateUsingGoogle,
        'google',
        msg,
        sourceLang,
        targetLang,
        _id
    )

    _tryTranslation(
        translateUsingBing,
        'bing',
        msg,
        sourceLang,
        targetLang,
        _id
    )

    # setTimeout(
    #     () -> _tryTranslation(
    #         translateUsingGoogle,
    #         'google',
    #         msg,
    #         sourceLang,
    #         targetLang,
    #         _id
    #     ),
    #     0
    # )

    # setTimeout(
    #     () -> _tryTranslation(
    #         translateUsingBing,
    #         'bing',
    #         msg,
    #         sourceLang,
    #         targetLang,
    #         _id
    #     ),
    #     0
    # )



@createChanslateMsgDoc = (userName, origMsg, origLang) ->
    {
        userName     : userName
        at           : new Date()
        original     : createMessage(origLang, origMsg, userName, false)
        translations : []
    }

@checkTranslationParams = (userName, msg) ->
    check(userName , String)
    check(msg      , String)


@truncMessage = (msg, limit) -> msg.substr(0, limit)

