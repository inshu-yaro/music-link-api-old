mongoose = require 'mongoose'
User  = mongoose.model 'User'
Music     = mongoose.model 'Music'

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

upadateDate = (token,date)->
    User.update {token:token},{$set:{
        lastlogin_date:date
        }},(err)->
            if(err) then throw new Error(err)

exports.play = (req,res) ->
    token = req.body.token
    withUser token, (user) ->
        withMusic req.body.music, req.body.artist,(musicId) ->
            date = req.body.date
            upadateDate(token,date)
            console.log user
            console.log musicId
            user.play_history.find {music:musicId},(err,results)->
                console.log  "b"
                if(err) then throw new Error(err)
                if(results)
                    cnt = results.count + 1
                    user.play_history.update {music:musicId},{$set:{
                        count:cnt
                        last_play:date
                        }},(err)->
                            if(err) then throw new Error(err)
                else
                    user.play_history.push({
                        music:musicId
                        count:1
                        last_play:date
                        })
                    user.save (err)->
                        if(err) then throw new Error(err)
    