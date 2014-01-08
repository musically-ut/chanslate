url = 'https://www.googleapis.com/language/translate/v2'

Meteor.startup ->
    Meteor.methods(
        # The callback on client should be of the form 
        #   `(err, translation) -> ...`
        translate: (text, source, target) ->

            check(text   , String)
            check(source , String)
            check(target , String)

            console.log('Translating ... ');

            if not this.isSimulation
                this.unblock()

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
                    'Translation not available'
    )

