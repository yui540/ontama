modal-view(
	onclick="{ closeModal }"
)
	div.inner
		div.item(
			each="{ info }"
		)
			div.thumb(style="background-image:url({ thumb })")
			h2.title { title }
			p.cast { cast }
			p.date { date }
			p.count { '第' + count + '回' }
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
			background-color: #fff;
			padding-bottom: 10px;
			opacity: 0;
		}
		:scope[data-state="show"] .inner .item {
			opacity: 1;
			animation: show 0.3s ease 0s forwards;
		}
		:scope .item .thumb {
			width: 100%;
			height: 150px;
			background-size: cover;
			background-position: center;
			border-top-left-radius: 5px;
			border-top-right-radius: 5px;
		}
		:scope .item .title {
			width: 100%;
			font-size: 14px;
			padding: 5px;
			box-sizing: border-box;
		}
		:scope .item .cast {
			width: 100%;
			font-size: 12px;
			padding: 5px;
			box-sizing: border-box;
		}
		:scope .item .date {
			width: 100%;
			font-size: 10px;
			text-align: right;
			padding: 5px;
			box-sizing: border-box;
		}
		:scope .item .count {
			width: 100%;
			font-size: 10px;
			text-align: right;
			padding: 5px;
			box-sizing: border-box;
		}
		:scope .item .download {
			width: 50px;
			height: 50px;
			border-radius: 50%;
			background-color: #ed588d;
			background-image: url(../../images/download.png);
			background-size: 60%;
			background-position: center;
			background-repeat: no-repeat;
			margin: 10px auto;
			box-shadow: 0 0 5px #ccc;
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
				observer.trigger 'download-fin', params

			# error --------------------------------------------
			, =>
				observer.trigger 'download-error', params
				alert 'ダウンロードに失敗しました。'

