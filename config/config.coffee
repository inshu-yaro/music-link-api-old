path     = require 'path'
rootPath = path.normalize(__dirname + '/..')
env      = process.env.NODE_ENV || 'development'

config =
  development:
    root: rootPath
    app:
      name: 'music-link-api'
    port: 3000
    db: 'mongodb://localhost/music-link-api-development'

  test:
    root: rootPath
    app:
      name: 'music-link-api'
    port: 3000
    db: 'mongodb://localhost/music-link-api-test'

  production:
    root: rootPath
    app:
      name: 'music-link-api'
    port: 3000
    db: 'mongodb://localhost/music-link-api-production'

module.exports = config[env]
