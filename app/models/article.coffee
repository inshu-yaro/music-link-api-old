mongoose = require 'mongoose'
Schema = mongoose.Schema

ArticleSchema = new Schema(
  title: String
  url: String
  text: String
)

ArticleSchema.virtual('date')
  .get ->
    return @_id.getTimestamp()

mongoose.model 'Article', ArticleSchema
