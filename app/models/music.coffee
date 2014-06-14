mongoose = require 'mongoose'
Schema = mongoose.Schema

MusicSchema = new Schema(
  name: String
  artist: String
  # genre:String
)


mongoose.model 'Music', MusicSchema