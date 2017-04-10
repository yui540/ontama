storage-btn(
	onclick="{ onClick }"
)

	style(scoped).
		:scope {
			position: fixed;
			bottom: 20px;
			right: 20px;
			width: 65px;
			height: 65px;
			border-radius: 50%;
			background-color: #409388;
			box-shadow: 0 0 5px #4c4c4c;
			background-image: url(../../images/list.png);
			background-size: 45%;
			background-position: center;
			background-repeat: no-repeat;
			z-index: 3;
		}

	script(type="coffee").

		# click ----------------------------------------------
		@onClick = (e) ->
			observer.trigger 'open-list'