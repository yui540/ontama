menu-bar(style="width:{ opts.width }px")
	section.nav(
			style="width:{ width }px;background-image:url(../../images/menu/{ name }.png)"
			each="{ list }"
			data-num="{ num }"
			onclick="{ clickWeek }"
		)
	
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
			background-size: auto 40%;
			background-repeat: no-repeat;
			background-position: center;
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
				{ num  : 0, name : "mon", width : w }
				{ num  : 1, name : "tue", width : w }
				{ num  : 2, name : "wed", width : w }
				{ num  : 3, name : "thu", width : w }
				{ num  : 4, name : "fri", width : w }
				{ num  : 5, name : "sat", width : w }
			]

			# 更新
			@update()

			# 選択の変更
			@unselect()
			@select onsen_api.today()


