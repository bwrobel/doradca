"use strict"
path = require("path")
lrSnippet = require("grunt-contrib-livereload/lib/utils").livereloadSnippet
folderMount = folderMount = (connect, dir) ->
  connect['static'] path.resolve(dir)

module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    concat:
      options:
        separator: ";"

      dist:
        src: ["src/**/*.js"]
        dest: "dist/<%= pkg.name %>.js"

    compass:
      dist:
        options:
          sassDir: '../sass'
          cssDir: '../css'
          config: '../config.rb'

    connect:
      livereload:
        options:
          port: 3000
          middleware: (connect, options) ->
            [lrSnippet, folderMount(connect, '../')]

    regarde:
      css:
        files: ['../sass/*', '../css/*']
        tasks: ['compass', 'livereload']

      html:
        files: ['../index.html']
        tasks: ['livereload']

      js:
        files: ['../js/*']
        tasks: ['livereload']


  grunt.loadNpmTasks "grunt-contrib-compass"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-contrib-livereload"
  grunt.loadNpmTasks "grunt-regarde"


  grunt.registerTask "css", [ "compass" ]
  grunt.registerTask "watch", [ "regarde" ]
  grunt.registerTask "server", [ "connect" ]

  grunt.registerTask "default", [ "livereload-start" , "connect", "regarde" ]