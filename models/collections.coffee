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

UserSummary = new SimpleSchema({
    id:
        type: String
    name:
        type: String
})

@ChanslateMessages = new Meteor.Collection(
    'chanslateMessages',
    {
        schema:
            original:
                type: MessageSchema
            translations:
                type: [MessageSchema]
            engines:
                type: [String]

            userId:
                type: String
            roomId:
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


@ChanslateRooms = new Meteor.Collection(
    'chanslateRooms',
    {
        schema:
            name:
                type: String
            secret:
                type: String

            users:
                type: [UserSummary]
            createdAt:
                type: Date
            engines:
                type: [String]
            createdByUserId:
                type: String
            srcLang:
                type: String
            dstLang:
                type: String
    }
)

ChanslateRooms.allow({
    insert: false
    update: false
    remove: false
})

# The Users table is automatically created
