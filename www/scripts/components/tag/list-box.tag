list-box(
	style="width:{ opts.width }px;height:{ height }px"
)
	div.close(
		onclick="{ onClose }"
	): div.box: div.icon
	div.inner(
		style="width:{ width }px;height:{ height }px"
	)
		download-li(
			each="{ loads }"
			thumb="{ thumb }"
			title="{ title }"
			count="{ count }"
			url="{ url }"
			per="{ per }"
		)

	style(scoped).
		:scope {
			position: fixed;
			display: none;
			top: 0;
			right: 0;
			z-index: 10;
		}
		:scope[data-state="show"] {
			display: block;
		}
		:scope[data-state="hidden"] {
			display: none;
		}
		:scope .close {
			position: absolute;
			left: 0;
			width: 70px;
			height: 100%;
			display: table;
			background-color: #409388;
		}
		:scope .close .box {
			display: table-cell;
			vertical-align: middle;
		}
		:scope .close .box .icon {
			position: relative;
			width: 50px;
			height: 50px;
			margin: 0 auto;
		}
		:scope .close .box .icon:before,
		:scope .close .box .icon:after {
			position: absolute;
			top: 24.5px;
			content: "";
			display: block;
			width: 100%;
			height: 1px;
			background-color: #fff;
		}
		:scope .close .box .icon:before {
			transform: rotate(45deg);
		}
		:scope .close .box .icon:after {
			transform: rotate(-45deg);
		}
		:scope .inner {
			position: absolute;
			top: 0;
			left: 70px;
			background-color: #eee;
			overflow: auto;
		}

	script(type="coffee").
		
		# mount -------------------------------------------
		@on 'mount', ->
			@loads  = []
			@width  = parseInt(opts.width) - 70
			@height = parseInt(opts.height)

			@update()

		# open list ---------------------------------------
		observer.on 'open-list', =>
			@root.setAttribute 'data-state', 'show'

		# download start ----------------------------------
		observer.on 'download-start', (params) =>
			@loads.push params
			@update()

		# download start ----------------------------------
		observer.on 'download-progress', (params) =>
			for li, i in @loads
				if params.id is li.id
					@loads[i].per = params.per

			@update()

		# download start ----------------------------------
		observer.on 'download-fin', (params) =>
			for li, i in @loads
				if params.id is li.id
					@loads.splice i, 1

			@update()

		# close list --------------------------------------
		@onClose = ->
			@root.setAttribute 'data-state', 'hidden'

