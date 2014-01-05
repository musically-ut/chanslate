Session.set('str', 'Hello world');

Template.hello.greeting = -> Session.get('str');

Template.hello.events(
  'click input' : ->
      # template data, if any, is available in 'this'
      if typeof console isnt 'undefined'
          console.log("You pressed the button")
          Meteor.call(
              'translate',
              Session.get('str'), 
              'en',
              'de',
              (err, t) ->
                  console.log('translated text = ', t);
                  if err instanceof Error
                      console.error(err)
                  else
                      Session.set('str', t)
          )
);

