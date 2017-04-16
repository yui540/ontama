audio-box
	section
	section
		section.audio-li(
			onclick="{ clickAudio }"
			style="width:{ width }px;"
			each="{ data }"
			data-id="{ id }"
			data-title="{ title }"
			data-thumb="{ thumb }"
			data-cast="{ cast }"
			data-update="{ update }"
			data-count="{ count }"
			data-url="{ url }"
			data-type="{ ext }"
		)
			div.thumb(data-type="{ ext }")
			h3.title { title }
			p.cast { cast }
			p.info 
				span.date { date }
				span.count { '第' + count + '回' }

	style(scoped).
		:scope {
			display: block;
			padding-top: 60px;
			padding-bottom: 105px;
		}
		:scope:after {
			content: "";
			display: block;
			clear: both;
		}
		:scope .audio-li {
			float: left;
			margin-top: 10px;
			margin-left: 10px;
			height: 200px;
			border-radius: 3px;
			background-color: #fff;
			box-shadow: 0 0 5px #bbb;
			overflow: hidden;
			animation: scale 0.3s ease 0s forwards;
		}
		:scope .audio-li:active {
			transform: scale(0.8);
		}
		:scope .audio-li .thumb {
			width: 100%;
			height: 90px;
			background-position: center;
			background-size: auto 60%;
			background-repeat: no-repeat;
			background-color: #eee;
		}
		:scope .audio-li .thumb[data-type="mp3"] {
			background-image: url(../../images/mp3.png);
		}
		:scope .audio-li .thumb[data-type="mp4"] {
			background-image: url(../../images/mp4.png);
		}
		:scope .audio-li .title {
			font-size: 12px;
			padding: 5px;
			box-sizing: border-box;
			height: 40px;
			overflow: hidden;
		}
		:scope .audio-li .cast {
			font-size: 10px;
			padding: 5px;
			box-sizing: border-box;
			height: 40px;
			overflow: hidden;
		}
		:scope .audio-li .info {
			font-size: 10px;
			text-align: right;
			padding: 5px;
			box-sizing: border-box;
		}
		:scope .audio-li .info .date {
			padding: 5px;
			color: #fff;
			border-radius: 5px;
			background-color: #EB3867;
			margin-right: 5px;
		}
		:scope .audio-li .info .count {
			padding: 5px;
			color: #fff;
			border-radius: 5px;
			background-color: #ff8100;
		}

		:scope .loading {
			width: 100%;
			height: 200px;
			display: table;
		}
		:scope .loading .inner {
			vertical-align: middle;
			display: table-cell;
		}
		:scope .loading .inner .icon {
			width: 100px;
			height: 100px;
			border-radius: 50%;
			background-color: #fff;
			margin: 0 auto;
			animation: load 2s ease 0s infinite;
		}

		@keyframes scale {
			0%   { transform: scale(0.9); }
			100% { transform: scale(1.0); }
		}
		@keyframes load {
			0%   { transform: scale(1.0); }
			50%  { transform: scale(0.5); }
			100% { transform: scale(1.0); }
		}

	script(type="coffee").

		##
		# ロード画面表示
		##
		@loadIn = ->
			@root.children[0].innerHTML = '<div class="loading"><div class="inner"><div class="icon"></div></div></div>'

		##
		# ロード画面非表示
		##
		@loadOut = ->
			@root.children[0].innerHTML = ''

		##
		# 曜日の番組情報の取得
		# @param day : 曜日
		# @param fn  : コールバック
		##
		@getInfoList = (day, fn) ->
			@data = []
			count = 0
			list  = LIST[day]

			list.forEach (li) =>
				onsen_api.connect API + li, (json) =>
					ext = null
					url = json.moviePath.pc

					if url.match /.*\.mp3/
						ext = 'mp3'
					else 
						ext = 'mp4'

					count += 1
					@data.push 
						width  : parseInt(opts.width) / 2 - 15
						id     : li
						ext    : ext
						title  : json.title
						thumb  : 'http://www.onsen.ag' + json.thumbnailPath
						url    : url
						cast   : json.personality
						date   : json.update
						count  : json.count

					if list.length - 1 < count
						fn @data

		# mount ----------------------------------------------
		@on 'mount', ->
			@loadIn()

			# id list ------------------------------------------
			onsen_api.connect API, (json) =>
				top.LIST = json
				day = onsen_api.encode onsen_api.today()

				@getInfoList day, (json) =>
					@update()
					@loadOut()

		# change day -----------------------------------------
		observer.on 'change-day', (day) =>
			onsen_api.destroy()

			@data = []
			@update()
			@loadIn()

			day = onsen_api.encode day
			@getInfoList day, (json) =>
					@update()
					@loadOut()

		# click audio ----------------------------------------
		@clickAudio = (e) =>
			info =
				ext   : e.item.ext
				cast  : e.item.cast
				count : e.item.count
				title : e.item.title
				date  : e.item.date
				thumb : e.item.thumb
				id    : e.item.id
				url   : e.item.url

			console.log info

			observer.trigger 'open-info', [info]


