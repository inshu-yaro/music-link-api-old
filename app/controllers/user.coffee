mongoose = require 'mongoose'
User  = mongoose.model 'User'

exports.findAll = (req,res) ->
    User.find {},(err,results) ->
        if(err) then throw new Error(err)
        res.json(results)

exports.findByToken = (req,res) ->
    tokenId = req.params.token
    User.find {token:tokenId}, (err, results) ->
        if(err) then throw new Error(err)
        res.json(results)

exports.addUser = (req,res) ->
    user = new User(req.body)
    user.save (err)->
        if(err) then throw new Error(err)
        res.json(user)

exports.setting = (req,res) ->
    User.update {token:req.body.token},{$set: {
        target_sex:req.body.target_sex
        target_age_s:req.body.target_age_s
        target_age_e:req.body.target_age_e
        }},(err)->
            if(err) then throw new Error(err)
            res.json(req.body)
