mongoose = require 'mongoose'
Schema = mongoose.Schema

UserSchema = new Schema(
  token:String
  name: String
  age: Number
  sex:String
  picture:String
  target_sex:String
  target_age_s:Number
  target_age_e:Number
  register_date:Date
  lastlogin_date:Date
  play_history:[{
    music:{
      type: Schema.Types.ObjectId
      ref: 'Music'
    }
    count:Number
    last_play:Date
  }]
)


mongoose.model 'User', UserSchema