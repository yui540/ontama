modal-view(
	onclick="{ closeModal }"
)
	div.inner
		div.item(
			each="{ info }"
		)
			h2.title { title }
			h1.msg(data-type="{ ext }")
			div.download(
				data-url="{ url }"
				onclick="{ download }"
			)

	style(scoped).
		:scope {
			position: fixed;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
			background-color: rgba(255,255,255,0.6);
			display: none;
			z-index: 8;
		}
		:scope[data-state="show"] {
			display: table;
		}
		:scope[data-state="hidden"] {
			display: none;
		}
		:scope .inner {	
			display: table-cell;
			vertical-align: middle;
		}
		:scope .inner .item {
			width: 70%;
			margin: 0 auto;
			border-radius: 5px;
			box-shadow: 0 0 10px #ccc;
			background-color: #409388;
			padding-bottom: 10px;
			opacity: 0;
		}
		:scope[data-state="show"] .inner .item {
			opacity: 1;
			animation: show 0.3s ease 0s forwards;
		}
		:scope .item .title {
			width: 100%;
			font-size: 14px;
			text-align: center;
			color: #fff;
			padding: 10px 0;
			box-sizing: border-box;
		}
		:scope .item .msg {
			width: 100%;
			height: 90px;
			background-position: center;
			background-size: auto 60%;
			background-repeat: no-repeat;
			background-color: #347B71;
		}
		:scope .item .msg[data-type="mp3"] {
			background-image: url(../../images/mp3.png);
		}
		:scope .item .msg[data-type="mp4"] {
			background-image: url(../../images/mp4.png);
		}
		:scope .item .download {
			width: 40px;
			height: 40px;
			border-radius: 50%;
			background-color: #ed588d;
			background-image: url(../../images/download.png);
			background-size: 50%;
			background-position: center;
			background-repeat: no-repeat;
			margin: 0 auto;
			margin-top: 10px;
		}

		@keyframes show {
			0%   { transform: scale(0.9); }
			100% { transform: scale(1.0); }
		}

	script(type="coffee").

		##
		# 表示
		## 
		@showModal = ->
			@modal.setAttribute 'data-state', 'show'

		##
		# 非表示
		## 
		@hiddenModal = ->
			@modal.setAttribute 'data-state', 'hidden'

		# mount ----------------------------------------------
		@on 'mount', ->
			@modal = @root

		# close modal ----------------------------------------
		@closeModal = (e) ->
			cl = e.target.className
			if cl is 'inner'
				@hiddenModal()

		# open info ------------------------------------------
		observer.on 'open-info', (info) =>
			@info = info
			@update()
			@showModal()

		# download -------------------------------------------
		@download = (e) ->
			id     = Math.floor(Math.random() * 10000000)
			url    = e.target.getAttribute 'data-url'
			name   = url.split('/')
			name   = name[name.length - 1]
			params =
				id    : id
				thumb : @thumb
				title : @title
				count : '第' + @count + '回'
				url   : @url
				name  : name

			observer.trigger 'download-start', params
			@hiddenModal()

			# progress -----------------------------------------
			file_util.download params, (per) =>
				params.per = per
				observer.trigger 'download-progress', params

			# success ------------------------------------------
			, (_file) =>
				navigator.notification.alert 'ダウンロード完了', =>
					console.log params.title
				, params.title
				observer.trigger 'download-fin', params

			# error --------------------------------------------
			, =>
				observer.trigger 'download-error', params
				alert 'ダウンロードに失敗しました。'

