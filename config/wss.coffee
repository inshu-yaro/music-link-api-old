WebSocketServer = require('ws').Server

connections = []
users = []

module.exports = (app) ->
    wss = new WebSocketServer({server:app})
    wss.on 'connection', (ws) ->
        ws.on 'message',(message)->
            console.log message
        ws.send 'something'

