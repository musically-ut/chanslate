This is the [Chanslate app](http://chanslate.in).

## Running

    meteor run --settings settings.json

Where the `settings.json` should be of the form:

    {
        "GOOGLE_TRANSLATE_API"         : "your_api_key"
      , "BING_TRANSLATE_CLIENT_SECRET" : "your_client_secret"
      , "BING_TRANSLATE_CLIENT_ID"     : "your_client_id"
    }

## Credits

This work draws heavily (in code as well as spirit) from
[ChatWorks](http://chatworks.in/). Check out [their github page
too](https://github.com/Pent/chatworks).
