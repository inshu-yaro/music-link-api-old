mongoose = require 'mongoose'
User  = mongoose.model 'User'
Music     = mongoose.model 'Music'
PlayHistory = mongoose.model 'PlayHistory'
Chat = mongoose.model 'Chat'
crypto = require 'crypto'
merge = require 'merge'

withMusic = (musicName,artist,handler) ->
    Music.findOne {name:musicName}, (err,results)->
        if(err) then throw new Error(err)
        console.log results  
        if(results)
            console.log "aaa"
            handler(results._id)
        else
            console.log "bbb"
            music = new Music(
                name:musicName
                artist:artist
                )
            music.save (err,m)->
                if(err) then throw new Error(err)
                handler(m.id)

withUser = (tokenId, handler) ->
    User.findOne {token:tokenId}, (err, result) ->
        if(err) then throw new Error(err)
        handler(result)

updateDate = (token,date)->
    User.update {token:token},{$set:{
        lastlogin_date:date
    }}, (err)->
        if(err) then throw new Error(err)

withMatch = (user,handler) ->
    User.findOne {gender:user.targetGender,age:{$gte:user.maxTargetAge,$lte:user.minTargetAge}},(err,result)->
        if(err) then throw new Error(err)
        handler (result)

exports.play = (req,res) ->
    token = req.body.token
    withUser token, (user) ->
        withMusic req.body.music, req.body.artist,(musicId) ->
            date = Date.now()
            updateDate(token,date)
            console.log user
            console.log musicId
            PlayHistory.findOne {music:musicId,user:user._id},(err,result)->
                if(err) then throw new Error(err)
                if (result)
                    cnt = result.count + 1
                    result.count = cnt
                    result.last_play = date
                    result.save (err)->
                        if(err) then throw new Error(err)
                else
                    play = new PlayHistory({
                        music:musicId
                        user:user._id
                        last_play:date
                        count:1
                        })
                    play.save (err)->
                        if(err) then throw new Error(err)
        withMatch user,(u2)->
            if u2
                chat = new Chat({u1:user._id,u2:u2._id,last_msg:Date.now(),token:u2.token})
                chat.save (err)->
                    if(err) then throw new Error(err)
                    res.json(u2)
            else
                console.log "no match"
