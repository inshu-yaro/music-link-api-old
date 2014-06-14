module.exports = (app) ->
	home = require '../app/controllers/home'
	app.get '/', home.index
