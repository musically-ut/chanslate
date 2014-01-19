This is the Chanslate app.

## Dependencies

To install all the necessary dependencies:

    meteor add http coffeescript less

    # Atmosphere packages.
    mrt add semantic-ui-less
    mrt add moment
    mrt add collection2

## Running

    meteor run --settings settings.json

The settings.json should be of the form:

    {
        "GOOGLE_TRANSLATE_API": "insert-API-key-here"
    }


## Deploying

    meteor -D chanslate.meteor.com # Clears the DB!
    meteor deploy chanslate.meteor.com --settings settings.json --i <identity-key>

See note above in **Running** section for `settings.json`.

## Credits

This work draws heavily (in code as well as spirit) from [ChatWorks](http://chatworks.in/). Check out [their github page too.](https://github.com/Pent/chatworks).
