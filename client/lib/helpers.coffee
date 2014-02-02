# Global helpers
Handlebars.registerHelper("unescape",  (html) ->
    e = document.createElement('div')
    e.innerHTML = html
    if e.childNodes.length == 0 then '' else e.childNodes[0].nodeValue
)
Handlebars.registerHelper("ago", (time) -> moment(time).fromNow())
Handlebars.registerHelper("toISO", (date) -> date.toISOString())
Handlebars.registerHelper("equals", (a, b) -> a == b)
Handlebars.registerHelper('count', (arr) -> if arr? then arr.length else 0)
Handlebars.registerHelper("username", (userId) ->
    user = Meteor.users.findOne({ _id: userId })
    if user? then user.username else ('No userId: ' + userId)
)

# Hack (?) to get time to update every 30 seconds.
updateTime = -> $('time.js-auto-update').each((idx, elem) ->
    $elem = $(elem)
    msgTime = $elem.attr('datetime')
    $elem.text(moment(msgTime).fromNow())
)
Meteor.setInterval(updateTime, 30000)

###
# Set a color based on handle
# @param handle
# @returns string
###
colorHandle = (handle) ->
    sumi = 0
    sumi += handle.charCodeAt(i) for i in [0 .. (handle.length - 1)]
    hue = sumi % 360
    'hsl('+hue+',46%,75%)'

Handlebars.registerHelper('colorize', -> colorHandle(this["userId"]))

@scrollToBottom = _.debounce(
    ->
        console.log('Debouncing')
        $('html, body').animate({ scrollTop: 99999 }, "slow")
    ,
    100
)

# thanks random SO answer.
# https://github.com/Pent/chatworks/blob/47953dc2ca1087753943c63fb4d2d3ec59befcb2/server/server.js
@haiku = ->
    adjs = ["autumn", "hidden", "bitter", "misty", "silent", "empty", "dry",
        "dark", "summer", "icy", "delicate", "quiet", "white", "cool",
        "spring", "winter", "patient", "twilight", "dawn", "crimson", "wispy",
        "weathered", "blue", "billowing", "broken", "cold", "damp", "falling",
        "frosty", "green", "long", "late", "lingering", "bold", "little",
        "morning", "muddy", "old", "red", "rough", "still", "small",
        "sparkling", "throbbing", "shy", "wandering", "withered", "wild",
        "black", "young", "holy", "solitary", "fragrant", "aged", "snowy",
        "proud", "floral", "restless", "divine", "polished", "ancient",
        "purple", "lively", "nameless"]

    nouns = ["waterfall", "river", "breeze", "moon", "rain", "wind", "sea",
        "morning", "snow", "lake", "sunset", "pine", "shadow", "leaf", "dawn",
        "glitter", "forest", "hill", "cloud", "meadow", "sun", "glade", "bird",
        "brook", "butterfly", "bush", "dew", "dust", "field", "fire", "flower",
        "firefly", "feather", "grass", "haze", "mountain", "night", "pond",
        "darkness", "snowflake", "silence", "sound", "sky", "shape", "surf",
        "thunder", "violet", "water", "wildflower", "wave", "water",
        "resonance", "sun", "wood", "dream", "cherry", "tree", "fog", "frost",
        "voice", "paper", "frog", "smoke", "star"]

    return adjs[Math.floor(Math.random()*(adjs.length-1))] +
        "" + nouns[Math.floor(Math.random()*(nouns.length-1))]+
        Math.floor(Math.random()*999)



