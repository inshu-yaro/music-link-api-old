mongoose = require 'mongoose'
User  = mongoose.model 'User'
Chat = mongoose.model 'Chat'
Message = mongoose.model 'Message'


getMsg = (u1,u2,handler)->
    Chat.find {u1:user1,u2:user2},(err,results) ->
    if(err) then throw new Error(err)
    Message.in results.messages, (err,result)->
        if(err) then throw new Error(err)
        handler(result)

exports.getMessages = (req,res) ->
    user1 = req.params.user1
    user2 = req.params.user2
    getMsg user1,user2,res.json

exports.postMessage = (req,res) ->
    user1 =req.body.u1
    user2 =req.body.u2  
    msg = new Message({
        timestamp: Date.now()
        user1:req.body.u1
        user2:req.body.u2
        text:req.body.text      
        })
    user.save (err)->
       if(err) then throw new Error(err)
    getMsg user1,user2,res.json
