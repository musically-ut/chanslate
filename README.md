This is the [Chanslate app](http://chanslate.in).

## Deployment

This can be deployed inside a [docker](http://docker.io) container.
The container is available on the docker index as `musicallyut/chanslate`.

Chanslate can be executed after setting the `ROOT_URL`, `MONGO_URL` and
`METEOR_SETTINGS` environment variables. Needless to say, you should have
`mongo` installed on the host machine.

Example execution:

    docker run 
           -p 3000:3000
           -e "MONGO_URL=mongodb://188.226.251.47:27017/chanslate" 
           -e "ROOT_URL=http://chanslate.in" 
           -e "METEOR_SETTINGS=$(cat settings.json)"
           musicallyut/chanslate

And Chanslate should be available at `http://localhost:3000`.

### Development on Mac OSX

If you are using docker on Mac via [`boot2docker`](https://github.com/boot2docker/boot2docker), don't forget to forward port `3000` from your VirtualBox or VMWare.

## Format of `settings.json`

Where the `settings.json` should be of the form:

    {
        "GOOGLE_TRANSLATE_API"         : "your_api_key"
      , "BING_TRANSLATE_CLIENT_SECRET" : "your_client_secret"
      , "BING_TRANSLATE_CLIENT_ID"     : "your_client_id"
    }

## Running

    meteor run --settings settings.json

## Credits

This work draws heavily (in code as well as spirit) from
[ChatWorks](http://chatworks.in/). Check out [their github page
too](https://github.com/Pent/chatworks).
