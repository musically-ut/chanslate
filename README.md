This is the [Chanslate app](http://chanslate.in).

## Dependencies

To install all the necessary dependencies:

    meteor add http coffeescript less

    # Atmosphere packages.
    mrt add semantic-ui-less
    mrt add moment
    mrt add collection2
    mrt add npm

## Running

    meteor run --settings settings.json

The settings.json should be of the form:

    {
        "GOOGLE_TRANSLATE_API"         : "your_api_key"
      , "BING_TRANSLATE_CLIENT_SECRET" : "your_client_secret"
      , "BING_TRANSLATE_CLIENT_ID"     : "your_client_id"
    }


## Deploying

    meteor -D chanslate.meteor.com # Clears the DB!
    meteor deploy chanslate.meteor.com --settings settings.json --i <identity-key>

See note above in **Running** section for `settings.json`.

## Credits

This work draws heavily (in code as well as spirit) from
[ChatWorks](http://chatworks.in/). Check out [their github page
too](https://github.com/Pent/chatworks).
