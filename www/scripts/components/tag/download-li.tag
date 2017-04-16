download-li
	div.info
		h3.title { opts.count + ':' + opts.title }
		div.load-bar
			div.load-line(style="width:{ parseFloat(opts.per) * 100 }%")

	style(scoped).
		:scope {
			display: block;
			width: 95%;
			height: 45px;
			background-color: #fff;
			margin: 10px auto;
			box-shadow: 0 0 10px #ccc;
		}
		:scope .info {
			width: 100%;
			height: 45px;
		}
		:scope .info .title {
			font-size: 12px;
			white-space: nowrap;
			padding: 5px;
			box-sizing: border-box;
			line-height: 30px;
			width: 100%;
			height: 30px;
			overflow: hidden;
		}
		:scope .info .load-bar {
			position: relative;
			width: 95%;
			height: 5px;
			background-color: #ccc;
			margin: 5px auto; 
		}
		:scope .info .load-bar .load-line {
			position: absolute;
			top: 0;
			left: 0;
			height: 5px;
			background-color: #ed588d;
		}

	script(type="coffee").
