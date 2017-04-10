list-box(
	style="width:{ opts.width }px;height:{ height }px"
)
	div.close(
		onclick="{ onClose }"
	): div.box: div.icon
	div.inner(
		style="width:{ width }px;height:{ height }px"
	)
		section.box

		section.player

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
		:scope[data-state="show"] .close {
			animation: show_close 0.5s ease 0s forwards;
		}
		:scope[data-state="hidden"] .close {
			animation: hidden_close 0.5s ease 0s forwards;
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
			background-color: #fff;
		}
		:scope[data-state="show"] .inner {
			animation: show_list 0.5s ease 0s forwards;
		}
		:scope[data-state="hidden"] .inner {
			animation: hidden_list 0.5s ease 0s forwards;
		}

		:scope .inner .box {
			width: 100%;
		}

		@keyframes show_list {
			0%   { left: 100%; }
			100% { left: 70px; }
		}
		@keyframes hidden_list {
			0%   { left: 70px; }
			100% { left: 100%; }
		}
		@keyframes show_close {
			0%   { left: -70px; }
			100% { left: 0; }
		}
		@keyframes hidden_close {
			0%   { left: 0; }
			100% { left: -70px; }
		}

	script(type="coffee").
		
		# mount -------------------------------------------
		@on 'mount', ->
			@width  = parseInt(opts.width) - 70
			@height = parseInt(opts.height)

			@update()

		# open list ---------------------------------------
		observer.on 'open-list', =>
			@root.setAttribute 'data-state', 'show'

		# close list --------------------------------------
		@onClose = ->
			@root.setAttribute 'data-state', 'hidden'

