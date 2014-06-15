mongoose = require 'mongoose'
Schema = mongoose.Schema

PlayHistorySchema = new Schema(
    music:{
    type: Schema.Types.ObjectId
    ref: 'Music'
    }
    user:{
    type: Schema.Types.ObjectId
    ref:'User'
    }
    count: Number
    last_play: Date
)


mongoose.model 'PlayHistory', PlayHistorySchema