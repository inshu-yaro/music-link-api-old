WebSocketServer = require('ws').Server


module.exports = (app) ->
    wss = new WebSocketServer({server:app})
    wss.on 'connection', (ws) ->
        console.log  "ccc"
        ws.on 'message',(message)->
            console.log message
            
        ws.send 'something'

