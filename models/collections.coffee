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
            engines:
                type: [String]

            userName:
                type: String
            at:
                type: Date
            lastAt:
                type: Date
                optional: true
    }
)

ChanslateMessages.allow({
    insert: false
    update: false
    remove: false
})
