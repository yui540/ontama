notification
	div.notification(
		each="{ list }"
	)
		div.icon
		div.msg(style="width:{ width - 60 }px")
			div.title { title }
			div.text ダウンロード完了

	style(scoped).
		.notification {
			position: fixed;
			top: -60px;
			width: 100%;
			height: 60px;
			background-color: #fff;
			border-bottom: solid 1px #ccc;
			box-sizing: border-box;
			animation: show_alert 3s ease 0s forwards;
			z-index: 11;
		}
		.notification .icon {
			float: left;
			width: 60px;
			height: 60px;
			background-image: url(../../images/success.png);
			background-position: center;
			background-size: 60%;
			background-repeat: no-repeat;
		}
		.notification .msg {
			float: right;
			height: 60px;
		}
		.notification .msg .title,
		.notification .msg .text {
			width: 100%;
			height: 29px;
			font-size: 16px;
			line-height: 29px;
			white-space: nowrap;
			overflow: hidden;
			padding: 0 10px;
			box-sizing: border-box;
		}

		@keyframes show_alert {
			0%   { top: -60px; }
			10%  { top: 0px; }
			90%  { top: 0px; }
			100% { top: -60px; }
		}

	script(type="coffee").
		@on 'mount', ->
			@width = parseInt opts.width

		observer.on 'download-fin', (params) =>
			@list = []
			@list.push 
				title : params.title
				width : @width
			@update()
