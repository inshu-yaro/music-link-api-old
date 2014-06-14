express  = require 'express'
mongoose = require 'mongoose'
fs       = require 'fs'
config   = require './config/config'
bodyParser = require 'body-parser'

mongoose.connect config.db
db = mongoose.connection
db.on 'error', ->
  throw new Error('unable to connect to database at ' + config.db)

modelsPath = __dirname + '/app/models'
fs.readdirSync(modelsPath).forEach (file) ->
  if file.indexOf('.js') >= 0
    require modelsPath + '/' + file

app = express()
app.use bodyParser.json()

require('./config/express')(app, config)
require('./config/routes')(app)

app.listen config.port
