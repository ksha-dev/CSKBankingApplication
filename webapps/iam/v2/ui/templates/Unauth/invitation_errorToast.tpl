	
	<style>
	
	
		.error_msg 
		{
		    cursor: pointer;
		    display: none;
		    position: fixed;
		    width: auto;
		    max-width: 400px;
		    box-sizing: border-box;
		    z-index: 100;
		    background-color: #000000E6;
		    border-radius: 7px;
		    margin: auto;
		    margin-top: 10px;
		    box-shadow: 0px 0px 10px 0px #ccc;
		    right: 0px;
		    left: 0px;
		    top: -100px;
		    transition: all .2s ease-in-out;
		    width: fit-content;
		    width: -moz-fit-content;
		    width: -webkit-fit-content;
		}
		
		
		.err_icon_aligner
		{
			display: table-cell;
		    width: 56px;
		    margin-top:5px;
		    flex-shrink: 0;
		}
		
		.err_icon_bigMSG
		{
			margin-top:9px;	
		}
		
		.error_msg_cross {
			display: inline-block;
			float: right;
			height: 24px;
		    width: 24px;
			margin: 7px 10px;
			background-color: #ff5555;
			border-radius: 50%;
			box-sizing: border-box;
			padding: 11px;
			position: relative;
		}
		
		.crossline1 {
			display: inline-block;
		    position: relative;
		    height: 10px;
		    width: 2px;
		    background-color: #fff;
		    margin: auto;
		    transform: rotate(-45deg);
		    left: 0px;
		    top: -4px;
		}
		
		.crossline2 {
			display: inline-block;
		    position: relative;
		    height: 10px;
		    width: 2px;
		    background-color: #fff;
		    margin: auto;
		    transform: rotate(45deg);
		    left: 0px;
		    top: -14px;
		}
		
		.error_msg_text 
		{
		    font-size: 13px;
		    line-height: 18px;
		    display: table-cell;
		    float: left;
		    padding: 16px 24px 16px 0px;
		    width: 100%;
		    box-sizing: border-box;
		    color: #FFFFFF;
		}
		
		@media only screen and (max-width: 419px) {
			 .error_msg 
			 {
			    right: 0px;
			    left: 0px;
			    margin-top: 0px;
			 }
		 }


	</style>
	


	<div class="error_msg " id="new_notification" onclick="Hide_Main_Notification()">
		<div style="display:flex;width: 100%;">
			<div class="err_icon_aligner">
				<div class="error_msg_cross">
					<span class='crossline1'></span>
					<span class='crossline2'></span>
				</div>
			</div>
			<div class="error_msg_text"> 
				<span id="succ_or_err_msg">&nbsp;</span>
			</div>
		</div>
	</div>
	
	
	<script>
	
		var toast_time="";


		function Hide_Main_Notification()
		{
			$(".error_msg").css("top","-100px");
		}
		
		
		
		function showErrorMessage(msg) 
		{
			if(msg!=""	&& msg!=undefined)
			{
				$(".error_msg .err_icon_aligner").removeClass("err_icon_bigMSG");
				$(".error_msg").show();
				$("#succ_or_err").html("");
				$("#succ_or_err_msg").html(msg);
				if($(".error_msg").width()>=400	&&	$(".error_msg").height()>50)
				{
					$(".error_msg .err_icon_aligner").addClass("err_icon_bigMSG");
				}
				
				
				$(".error_msg").css("top","50px");
				
		
				if(toast_time!=""){
					clearTimeout(_time);
				}
				toast_time = setTimeout(function() {
					$(".error_msg").css("top","-150px");
				}, getToastTimeDuration(msg));		
				
				$("#new_notification").click(function(){
					$(".error_msg").css("top","-100px");
					$(".error_msg").hide();
					$("#succ_or_err_msg").html("");
					$("#new_notification").attr("onclick","Hide_Main_Notification()");
					$("#new_notification").unbind();
				});
		
			}
		
		}
		
		function getToastTimeDuration(msg){
			var timing = (msg.split(" ").length) * 333.3;
			return timing > 3000 ? timing : 3000;
		}
		
	</script>