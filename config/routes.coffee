module.exports = (app) ->
	home = require '../app/controllers/home'
	user = require '../app/controllers/user'
	# music = require '../app/controllers/music'
	# chat = require '../app/controllers/chat'
	app.get '/', home.index
	app.get '/users/all',user.findAll
	app.get '/users/user/:token',user.findByToken
	app.post '/users/enroll',user.addUser
	app.put '/users/setting', user.setting
	# app.put '/users/play',user.play


