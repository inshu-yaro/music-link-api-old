mongoose = require 'mongoose'
Schema = mongoose.Schema

UserSchema = new Schema(
  token:String
  name: String
  age: Number
  sex:String
  id:String
  target_sex:String
  target_age_s:Number
  target_age_e:Number
  register_date:Date
  lastlogin_date:Date
  mail:String
)

UserSchema.pre 'save',(next)->
  if !@register_date
    console.log  "aaa"
    @register_date = new Date()
    @lastlogin_date = new Date()
    @target_age_e = @age + 5
    @target_age_s = @age - 5
  if @sex == "male"
    @target_sex = "female"
  else
    @target_sex = "male"
  next()


mongoose.model 'User', UserSchema