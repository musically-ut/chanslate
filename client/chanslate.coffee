# thanks random SO answer.
# https://github.com/Pent/chatworks/blob/47953dc2ca1087753943c63fb4d2d3ec59befcb2/server/server.js
haiku = ->
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


Meteor.subscribe('chanslateMessages')
Session.set('userName', haiku())

Template.showMessages.helpers({
    messages: ->
        ChanslateMessages.find({}, {
            sort:
                at: 1
        })
})

Template.addMessage.events(

    'keyup input[name="src"]': (ev, template) ->
        if ev.which == 13
            console.log('Handling source message')
            textBox = template.find('[name="src"]')
            text = textBox.value

            if text.length > 0
                Meteor.call(
                    'addSrcMessage',
                    Session.get('userName'),
                    text
                )

            textBox.value = ''
            textBox.focus()

    'keyup input[name="dst"]': (ev, template) ->

        if ev.which == 13
            console.log('Handling dst message')
            textBox = template.find('[name="dst"]')
            text = textBox.value

            if text.length > 0
                Meteor.call(
                    'addDstMessage',
                    Session.get('userName'),
                    text
                )

            textBox.value = ''
            textBox.focus()
)
