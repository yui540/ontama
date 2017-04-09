menu-bar(style="width:{ opts.width }px")
	section.nav(
			style="width:{ width }px"
			each="{ list }"
			data-num="{ num }"
			onclick="{ clickWeek }"
		) { name }
	
	style(scoped).
		:scope {
			position: fixed;
			top: 0;
			left: 0;
			display: block;
			height: 60px;
			background-color: #409388;
			box-shadow: 0 0 5px #4c4c4c;
			z-index: 5;
		}
		:scope:after {
			content: "";
			display: block;
			clear: both;
		}
		:scope .nav {
			float: left;
			height: 60px;
			font-size: 16px;
			color: #ccc;
			text-align: center;
			line-height: 60px;
			transition: all 0.3s ease 0s;
		}
		:scope .nav[data-state="active"] {
			color: #fff;
			background-color: #347B71;
		}

	script(type="coffee").

		##
		# アクティブ
		# @param num : 番号
		##
		@select = (num) ->
			@root.children[num].setAttribute 'data-state', 'active'

		##
		# パッシブ
		##
		@unselect = ->
			child = @root.children
			for _child in child
				_child.setAttribute 'data-state', ''

		# click ----------------------------------------------
		@clickWeek = (e) =>
			num = parseInt e.target.getAttribute 'data-num'

			# イベント発火
			observer.trigger 'change-day', num

			# 選択の変更
			@unselect()
			@select num

		# mount ----------------------------------------------
		@on 'mount', ->
			w = parseInt(opts.width) / 6
			@list = [
				{ num  : 0, name : "月", width : w }
				{ num  : 1, name : "火", width : w }
				{ num  : 2, name : "水", width : w }
				{ num  : 3, name : "木", width : w }
				{ num  : 4, name : "金", width : w }
				{ num  : 5, name : "土日", width : w }
			]

			# 更新
			@update()

			# 選択の変更
			@unselect()
			@select onsen_api.today()


