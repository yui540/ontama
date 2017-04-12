file_transfer = null
document.addEventListener 'deviceready', ->
	file_transfer = new FileTransfer()

module.exports =
	##
	# ファイルのダウンロード
	# @param url : URL
	# @param fn_progress : コールバック（進捗）
	# @param fn_success  : コールバック（終了）
	# @param fn_error    : コールバック（エラー）
	## 
	download: (url, fn_progress, fn_success, fn_error) ->
		url    = encodeURI url
		f_name = url.split '/'
		f_name = f_name[f_name.length - 1]
		f_path = root + f_name
		console.log f_path

		# progress ------------------------------------------
		file_transfer.onprogress = (e) =>
			fn_progress e.loaded / e.total

		# download ------------------------------------------
		file_transfer.download url, f_path, (_file) =>
			fn_success _file
		, (err) =>
			console.log err
			fn_error()

	##
	# localStorageへの書き込み
	# @param info : 情報
	##
	localWrite: (info) ->
		json = localStorage['playlist']
		if json is undefined
			json = '[]'

		json = JSON.parse json
		json.push info
		json = JSON.stringify json

		localStorage['playlist'] = json

	##
	# localStorageの読み込み
	##
	localRead: ->
		json = JSON.parse localStorage['playlist']
		return json

	##
	# 重複のチェック
	# @param f_path : ファイルパス
	##
	check: (url) ->
		json = localStorage['playlist']
		if json is undefined
			json = '[]'
		json = JSON.parse json

		for li in json
			if url is li.url
				return false

		return true

