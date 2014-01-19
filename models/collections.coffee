MessageSchema = new SimpleSchema({
    lang:
        type: String
    text:
        type: String
    createdBy:
        type: String
    error:
        type: Boolean
})

@ChanslateMessages = new Meteor.Collection2(
    'chanslateMessages',
    {
        schema:
            original:
                type: MessageSchema
            translations:
                type: [MessageSchema]

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
