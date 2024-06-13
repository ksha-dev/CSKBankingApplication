<style>
	 .load-bg{
	 	background-color: #FFFFFF;
	 	width: 100%;
		height: 100%;
		position: absolute;
		z-index: 100;
		opacity: 1;
		transition: opacity .2s linear;
		top: 0;
		left: 0;
	 }
	 .load-fade{
		opacity: 0;
	 }
	 .basic-box-s {
		display: block;
		position: absolute;
	    top: 0px;
	    left: 0px;
	    right: 0px;
	    bottom: 0px;
	    width: 50px;
	    height: 50px;
	    margin: auto;
     }
      .box-anim {
        animation: load-anim 2s cubic-bezier(0.83, -0.01, 0.22, 1) infinite;
      }
       @keyframes load-anim {
        0% {
          transform: rotate(0deg);
        }
        10% {
          transform: rotate(-30deg);
        }
        50%{
            transform: rotate(180deg);
        }
        60%{
            transform: rotate(165deg);
        }
        100% {
          transform: rotate(360deg);
        }
      }
       .path {
        stroke-dasharray: 150px;
        stroke-dashoffset: 150px;
        stroke-linecap: round;
      }
      .path1-anim {
        animation: stroke-anim1 4s cubic-bezier(0.83, -0.01, 0.22, 1) infinite;
      }
      .path2-anim {
        animation: stroke-anim2 4s cubic-bezier(0.83, -0.01, 0.22, 1) infinite;
      }
      .path3-anim {
        animation: stroke-anim3 4s cubic-bezier(0.83, -0.01, 0.22, 1) infinite;
      }
      .path4-anim {
        animation: stroke-anim4 4s cubic-bezier(0.83, -0.01, 0.22, 1) infinite;
      }
       @keyframes stroke-anim1 {
        0% {
          stroke-opacity: 1;
          stroke-dashoffset: 150px;
        }
        3% {
          stroke-dashoffset: 150px;
        }
        21%,
        25% {
          stroke-dashoffset: 0;
        }
        50% {
          stroke-opacity: 1;
        }
        100% {
          stroke-dashoffset: 0px;
          stroke-opacity: 0;
        }
      }
      @keyframes stroke-anim2 {
        0% {
          stroke-dashoffset: 150px;
        }
        25% {
          stroke-opacity: 1;
          stroke-dashoffset: 150px;
        }
        28% {
          stroke-dashoffset: 150px;
        }
        46%,
        50% {
          stroke-dashoffset: 0px;
        }
        75% {
          stroke-dashoffset: 0px;
          stroke-opacity: 1;
        }
        100% {
          stroke-dashoffset: 0px;
          stroke-opacity: 0;
        }
      }
      @keyframes stroke-anim3 {
        0% {
          stroke-opacity: 0;
          stroke-dashoffset: 150px;
        }
        49% {
          stroke-opacity: 0;
        }
        50% {
          stroke-opacity: 1;
          stroke-dashoffset: 150px;
        }
        53% {
          stroke-dashoffset: 150px;
        }
        71%,
        75% {
          stroke-dashoffset: 0;
        }
        100% {
          stroke-dashoffset: 0;
          stroke-opacity: 1;
        }
      }
      @keyframes stroke-anim4 {
        0% {
          stroke-dashoffset: 150px;
          stroke-opacity: 0;
        }
        74% {
          stroke-opacity: 1;
        }
        75% {
          stroke-opacity: 1;
          stroke-dashoffset: 150px;
        }
        78% {
          stroke-dashoffset: 150px;
        }
        96%,
        100% {
          stroke-dashoffset: 0;
        }
      }
</style>

		<div class="load-bg fade">
		<div class="basic-box-s box-anim">
        <svg width="50" height="50" style="shape-rendering: geometricPrecision;" class="line_loader">
          <rect
            x="5"
            y="5"
            rx="6"
            ry="6"
            width="40"
            height="40"
            class="path"
            style="stroke: rgb(246, 177, 27); stroke-width: 5.4; stroke-opacity: 1; fill: transparent; stroke-dasharray: 384px; stroke-dashoffset: 0px"
          />
          <rect
            x="5"
            y="5"
            rx="6"
            ry="6"
            width="40"
            height="40"
            class="path path1 path1-anim"
            style="stroke: rgb(226, 39, 40); stroke-width: 5; stroke-opacity: 1; fill: transparent"
          />
          <rect
            x="5"
            y="5"
            rx="6"
            ry="6"
            width="40"
            height="40"
            class="path path2 path2-anim"
            style="stroke: rgb(4, 152, 73); stroke-width: 5; stroke-opacity: 1; fill: transparent"
          />
          <rect
            x="5"
            y="5"
            rx="6"
            ry="6"
            width="40"
            height="40"
            class="path path3 path3-anim"
            style="stroke: rgb(34, 110, 179); stroke-width: 5; stroke-opacity: 1; fill: transparent"
          />
          <rect
            x="5"
            y="5"
            rx="6"
            ry="6"
            width="40"
            height="40"
            class="path path4 path4-anim"
            style="stroke: rgb(246, 177, 27); stroke-width: 5.4; stroke-opacity: 1; fill: transparent"
          />
        </svg>
      </div>
      </div>