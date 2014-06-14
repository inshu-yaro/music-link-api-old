mongoose = require 'mongoose'
Article  = mongoose.model 'Article'

exports.index = (req, res) ->
  Article.find (err, articles) ->
    if(err) then throw new Error(err)
    res.render 'home/index',
      title: 'Generator-Express MVC'
      articles: articles
