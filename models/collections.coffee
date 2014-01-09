@ChanslateMessages = new Meteor.Collection2(
    'chanslateMessages',
    {
        schema:
            'src.lang':
                type: String
            'src.text':
                type: String
                optional: true

            'dst.lang':
                type: String
            'dst.text':
                type: String
                optional: true

            userName:
                type: String
            at:
                type: Date
    }
)

ChanslateMessages.allow({
    insert: false
    update: false
    remove: false
})
