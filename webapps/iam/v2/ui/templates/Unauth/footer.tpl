<style>
#footer
{	
    width: 100%;
    height: 20px;
    font-size: 14px;
    color: #727272;
   	position:absolute;
   	left:0px;
   	right:0px;
    margin:20px auto;
    text-align:center;
    font-size: 14px;
    bottom: 0px;
}
#footer a
{
    text-decoration:none;
    color: #727272;
    font-size: 14px;
}

@media only screen and (max-width : 435px)
{
	#footer a,#footer{	
		font-size: 12px;
	}
}
</style>

<footer id="footer"> 

	<span>
		<#assign corp_link>
			<@i18n key="IAM.ZOHOCORP.LINK"/>
		</#assign>
		<@i18n key="IAM.ZOHOCORP.FOOTER" arg0="${za.copyright_year}" arg1="${corp_link}"/>
	</span>
	
</footer>

<script>
	function setFooterPosition(){
		var container = document.getElementsByClassName("container")[0];
		var top_value = window.innerHeight-60;
		if(container && (container.offsetHeight+container.offsetTop+30)<top_value){
			document.getElementById("footer").style.top = top_value+"px"; // No I18N
		}
		else{
			document.getElementById("footer").style.top = container && (container.offsetHeight+container.offsetTop+30)+"px"; // No I18N
		}
	}
	window.addEventListener("resize",function(){
		setFooterPosition();
	});
	window.addEventListener("load",function(){
		setFooterPosition();
	});
</script>