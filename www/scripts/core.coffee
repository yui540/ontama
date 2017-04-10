top.API      = 'https://onsen-downloader.herokuapp.com/'
top.LIST     = null
top.root_obj = null
top.root     = null

# module
top.onsen_api = require './onsen-api'
top.riot      = require 'riot'
top.observer  = riot.observable()

# components
require './components/js/main-content'
require './components/js/menu-bar'
require './components/js/audio-box'
require './components/js/storage-btn'
require './components/js/list-box'
require './components/js/modal-view'

document.addEventListener 'deviceready', ->
	top.file_util = require './file-util'
	
	# ファイル保存パスの取得
	requestFileSystem LocalFileSystem.PERSISTENT, 0, (file_system) =>
		top.root_obj = file_system.root
		top.root     = root_obj.toURL()
	, (err) =>
		alert 'ファイルアクセスに失敗しました。'

	# コンポーネントをマウント
	riot.mount '*'