mongoose = require 'mongoose'
Schema = mongoose.Schema

MessageSchema = new Schema(
    user1:{
      type: Schema.Types.ObjectId
      ref: 'User'     
    }
    user2:{
      type: Schema.Types.ObjectId
      ref: 'User'     
    }
    text:String
    timestamp:Date
  )


mongoose.model 'Message', MessageSchema