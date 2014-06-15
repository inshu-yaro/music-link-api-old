module.exports = (app) ->
    user = require '../app/controllers/user'
    music = require '../app/controllers/music'
    chat = require '../app/controllers/chat'

    app.get '/users/all',user.findAll
    app.get '/users/user/:token',user.findByToken
    app.post '/users/enroll',user.addUser
    app.put '/users/setting', user.setting
    app.post '/music/play',music.play
    app.get '/chat/:user1/:user2', chat.getMessages
    app.post '/chat/post',chat.postMessage