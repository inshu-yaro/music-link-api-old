mongoose = require 'mongoose'
Schema = mongoose.Schema

ChatSchema = new Schema(
  u1: {
      type: Schema.Types.ObjectId
      ref: 'User'
  }
  u2: {
      type: Schema.Types.ObjectId
      ref: 'User'
  }
  last_msg:Date
  messages:[{
      type: Schema.Types.ObjectId
      ref: 'User'
  }]
  )


mongoose.model 'Chat', ChatSchema