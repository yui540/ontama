top.API      = 'https://onsen-downloader.herokuapp.com/'
top.LIST     = null
top.root     = null

# module
top.file_util = require './file-util'
top.onsen_api = require './onsen-api'
top.riot      = require 'riot'
top.observer  = riot.observable()

# components
require './components/js/main-content'
require './components/js/menu-bar'
require './components/js/audio-box'
require './components/js/storage-btn'
require './components/js/list-box'
require './components/js/download-li'
require './components/js/modal-view'

document.addEventListener 'deviceready', ->
	# 広告
	banner = 'ca-app-pub-4078521472076790/3428481467'
	AdMob.createBanner banner, ->
		AdMob.showBanner(AdMob.AD_POSITION.BOTTOM_CENTER)
	
	# ディレクトリ取得
	requestFileSystem LocalFileSystem.PERSISTENT, 0, (e) ->
		top.root = e.root.toURL()

	# コンポーネントをマウント
	riot.mount '*'