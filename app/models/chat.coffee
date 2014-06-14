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
  messages:[{
  	text:String
  	timestamp:Date
  	}]
  )


mongoose.model 'Chat', ChatSchema