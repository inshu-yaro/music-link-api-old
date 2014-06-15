mongoose = require 'mongoose'
Schema = mongoose.Schema

MessageSchema = new Schema(
  	user:{
      type: Schema.Types.ObjectId
      ref: 'User'  		
  	}
  	text:String
  	timestamp:Date
  )


mongoose.model 'Message', MessageSchema