top.API  = 'https://onsen-downloader.herokuapp.com/'
top.LIST = null

# module
top.onsen_api = require './onsen-api'
top.riot      = require 'riot'
top.observer  = riot.observable()

# components
require './components/js/main-content'
require './components/js/menu-bar'
require './components/js/audio-box'
require './components/js/storage-btn'

document.addEventListener 'deviceready', ->
	riot.mount '*'