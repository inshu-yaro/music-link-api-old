mongoose = require 'mongoose'
Schema = mongoose.Schema

UserSchema = new Schema(
  token: String
  firstName: String
  lastName: String
  birthday: Date
  gender: String
  id: String
  targetGender: String
  minTargetAge: Number
  maxTargetAge: Number
  registerDate: Date
  lastLoginDate: Date
  email: String
)

UserSchema.methods.getAge = ->
  ageDifMs = Date.now() - @birthday.getTime()
  ageDate = new Date(ageDifMs)
  Math.abs(ageDate.getUTCFullYear() - 1970)

UserSchema.methods.fullName = ->
  @lastName + " " + @firstName

UserSchema.pre 'save',(next)->
  if !@register_date
    @birthday = if @birthday? then Date.parse(@birthday) else null
    age = @getAge()
    @registerDate = new Date()
    @lastLoginDate = new Date()
    @minTargetAge = age + 5
    @maxTargetAge = age - 5
  if @gender == "male"
    @targetGender = "female"
  else
    @targetGender = "male"
  next()


mongoose.model 'User', UserSchema
