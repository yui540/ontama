gulp       = require 'gulp'
uglify     = require 'gulp-uglify'
riot       = require 'gulp-riot'
jade       = require 'gulp-jade'
coffee     = require 'gulp-coffee'
browserify = require 'browserify'
source     = require 'vinyl-source-stream'
plumber    = require 'gulp-plumber'

# Jade
gulp.task 'jade', ->
	gulp.src 'www/views/jade/*.jade'
		.pipe plumber()
		.pipe jade()
		.pipe gulp.dest 'www/views/html'

# Riot
gulp.task 'riot', ['jade'], ->
	gulp.src 'www/scripts/components/tag/*.tag'
		.pipe plumber()
		.pipe riot
			compact  : true
			type     : 'coffee'
			template : 'jade'
		.pipe gulp.dest 'www/scripts/components/js'

# CoffeeScript
gulp.task 'coffee', ['riot'], ->
	gulp.src 'www/scripts/*.coffee'
		.pipe plumber()
		.pipe coffee()
		.pipe gulp.dest 'www/scripts'

# Browserify
gulp.task 'browserify', ['coffee'], ->
	browserify 'www/scripts/core.js'
		.bundle()
		.pipe source 'core.min.js'
		.pipe gulp.dest 'www/scripts'

# Ugligy
gulp.task 'uglify', ['browserify'], ->
	gulp.src 'www/scripts/core.min.js'
		.pipe plumber()
		.pipe uglify()
		.pipe gulp.dest 'www/scripts'

# Default 
gulp.task 'default', ['jade', 'riot', 'coffee', 'browserify', 'uglify']

# Watch
gulp.task 'watch', ->
	gulp.watch [
		'www/views/jade/*.jade'
		'www/scripts/components/tag/*.tag'
		'www/scripts/*.coffee'
	], ['jade', 'riot', 'coffee'] 


