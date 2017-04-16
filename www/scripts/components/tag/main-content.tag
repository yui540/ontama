main-content(
	style="width:{ width }px;height:{ height }px"
)
	menu-bar(width="{ width }")
	audio-box(width="{ width }")
	storage-btn
	list-box(
		width="{ width }"
		height="{ height }"
	)
	modal-view

	style(scoped).
		:scope {
			display: block;
		}

	script(type="coffee").

		# mount ----------------------------------------------
		@on 'mount', ->
			@width  = screen.width
			@height = screen.height

			# 更新
			@update()