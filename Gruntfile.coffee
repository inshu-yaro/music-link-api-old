request = require 'request'

module.exports = (grunt) ->
  require('time-grunt')(grunt)
  require('load-grunt-tasks')(grunt)

  reloadPort = 35729

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    develop:
      server:
        file: 'dist/app.js'
    watch:
      options:
        nospawn: true
        livereload: reloadPort
      js:
        files: [
          'dist/app.js'
          'dist/app/**/*.js'
          'dist/config/*.js'
        ]
        tasks: ['develop', 'delayed-livereload']
      coffee:
        files: [
          'app.coffee'
          'app/**/*.coffee'
          'config/*.coffee'
        ]
        tasks: 'coffee'
      jade:
        files: ['app/views/**/*.jade']
        tasks: ['copy:views']
        options: { livereload: reloadPort }
    coffee:
      app:
        files:
          'dist/app.js': 'app.coffee'

      settings:
        expand: true
        flatten: true
        cwd: 'config'
        src: ['*.coffee'],
        dest: 'dist/config',
        ext: '.js'

      dev:
        expand: true
        cwd: 'app'
        src: ['**/*.coffee'],
        dest: 'dist/app',
        ext: '.js'

    copy:
      public:
        files: [{
          expand: true
          src: ['public/**']
          dest: 'dist'
        }]
      views:
        files: [{
          expand: true
          src: ['app/views/**']
          dest: 'dist'
        }]

  grunt.config.requires('watch.js.files')
  files = grunt.config('watch.js.files')
  files = grunt.file.expand(files)

  grunt.registerTask 'delayed-livereload', 'Live reload after the node server has restarted.', ->
    done = this.async()
    setTimeout ->
      request.get 'http://localhost:' + reloadPort + '/changed?files=' + files.join(','), (err, res) ->
          reloaded = !err && res.statusCode == 200
          if reloaded
            grunt.log.ok 'Delayed live reload successful.'
          else
            grunt.log.error 'Unable to make a delayed live reload.'
          done reloaded
    , 500

  grunt.registerTask 'default', ['coffee', 'copy', 'develop', 'watch']
