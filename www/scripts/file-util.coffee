module.exports =
	##
	# ファイルのダウンロード
	# @param paramsl     : パラメータ
	# @param fn_progress : コールバック（進捗）
	# @param fn_success  : コールバック（終了）
	# @param fn_error    : コールバック（エラー）
	## 
	download: (params, fn_progress, fn_success, fn_error) ->
		file_transfer = new FileTransfer()
		url    = encodeURI params.url
		f_path = root + '音泉卵/' + params.title + '/' + params.count + '/' + params.name

		# progress ------------------------------------------
		file_transfer.onprogress = (e) =>
			fn_progress e.loaded / e.total

		# download ------------------------------------------
		file_transfer.download url, f_path, (_file) =>
			fn_success _file
		, (err) =>
			fn_error()

