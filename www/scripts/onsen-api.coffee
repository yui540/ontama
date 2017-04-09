list = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat']

module.exports = 
	##
	# httpリクエスト
	# @param url : URL
	# @param fn  : コールバック関数
	##
	connect: (url, fn) ->
		req = new XMLHttpRequest()
		req.open 'GET', url
		req.onreadystatechange = =>
			if req.readyState is 4 and req.status is 200
				fn JSON.parse req.responseText
		req.send()

	##
	# 今日の曜日を取得
	##
	today: ->
		day  = new Date().getDay()
		day -= 1

		if day is -1
			day = 5
		else if day is 6
			day = 5

		return day

	##
	# 曜日の変換
	# @param day : 曜日
	##
	encode: (day) ->
		return list[day]

	##
	# 曜日の逆変換
	# @param day : 曜日番号
 	##
 	decode: (day) ->
 		switch day
 			when 0
 				return list[0]
 			when 1
 				return list[1]
 			when 2 
 				return list[2]
 			when 3 
 				return list[3]
 			when 4 
 				return list[4]
 			when 5
 				return list[5]
 			when 6
 				return list[5]
 			
 		