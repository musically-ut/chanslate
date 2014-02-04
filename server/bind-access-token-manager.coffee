bing_token_url   = "https://datamarket.accesscontrol.windows.net/v2/OAuth2-13"
bing_token_scope = "http://api.microsofttranslator.com"

class @BingAccessTokenManagerFactory
    constructor: (@autoUpdate, @clientId, @clientSecret) ->
        @tokenBody = null
        @tokenFetchTime = null

    _requestToken: () ->
        @tokenFetchTime = new Date()
        console.log('Initiating bing access token request.')
        res = HTTP.call(
            "POST",
            bing_token_url,
            {
                params:
                    'grant_type'    : 'client_credentials'
                    'client_id'     : @clientId
                    'client_secret' : @clientSecret
                    'scope'         : bing_token_scope
            }
        )

        console.log('Access token request succeeded.')

        @tokenBody = res.data

        if @autoUpdate
            # Request for a token before the old one expires
            console.log('Will auto update the Bing access token')
            setTimeout(
                () => @_requestToken(),
                1000 * (@tokenBody['expires_in'] - 60)
            )

    _hasTokenExpired: () ->
        if @tokenFetchTime is null or @tokenBody is null
            true
        else
            currentTime = (new Date()).valueOf()
            secsElapsed = (currentTime - @tokenFetchTime.valueOf()) / 1000
            # Keep a one minute safety margin
            secsElapsed >= @tokenBody['expires_in'] - 60

    # Throws an error if the token could not be fetched.
    getToken: () ->
        if @tokenBody is null or @_hasTokenExpired()
            @_requestToken()

        return @tokenBody['access_token']


@BingAccessTokenManager = null
setBingAccessTokenManager = (o) -> @BingAccessTokenManager = o

Meteor.startup ->
    secret = Meteor.settings.BING_TRANSLATE_CLIENT_SECRET
    id     = Meteor.settings.BING_TRANSLATE_CLIENT_ID
    if not secret? or not id?
        console.error(
            'Correct settings not provided for Bing translations')
    else
        setBingAccessTokenManager(
            new BingAccessTokenManagerFactory(false, id, secret)
        )
