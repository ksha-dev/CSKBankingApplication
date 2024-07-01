<#if logout_data?has_content>
<style>
@font-face {
  font-family: 'AccountsUI';
  src:  url('${SCL.getStaticFilePath('/v2/components/images/fonts/AccountsUI.eot')}');
  src:  url('${SCL.getStaticFilePath('/v2/components/images/fonts/AccountsUI.eot')}') format('embedded-opentype'),
    url('${SCL.getStaticFilePath('/v2/components/images/fonts/AccountsUI.ttf')}') format('truetype'),
    url('${SCL.getStaticFilePath('/v2/components/images/fonts/AccountsUI.woff')}') format('woff'),
    url('${SCL.getStaticFilePath('/v2/components/images/fonts/AccountsUI.woff2')}') format('woff2'),
    url('${SCL.getStaticFilePath('/v2/components/images/fonts/AccountsUI.svg')}') format('svg');
  font-weight: normal;
  font-style: normal;
  font-display: block;
}
[class^="logout-icon-"], [class*=" logout-icon-"] {
  /* use !important to prevent issues with browser extensions that change fonts */
  font-family: 'AccountsUI' !important;
  speak: never;
  font-style: normal;
  font-weight: normal;
  font-variant: normal;
  text-transform: none;
  line-height: 1;

  /* Better Font Rendering =========== */
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
.logout-icon-datacenter:before {
  content: "\e92b";
}
.logout-wrapper {
    position: absolute;
    top: 25px;
    right: 50px;
    cursor: pointer;
    border: solid 1px #fff;
    border-radius: 8px;
    font-family: 'ZohoPuvi', 'Open Sans', sans-serif;
    font-size: 14px;
    transition: .3s width, .3s height;    
    z-index: 1;
    overflow:hidden;
}
.logout-wrapper:hover {
    border-color: #e0e0e0;
    background-color: #fbfcfc;
}
.logout-wrapper .name {
	position: absolute;
    top: 0px;
    right: 38px;
    margin: 0;
    line-height: 30px;
    display: block;
    transition: right .3s ease-out,top .3s ease-out,width .3s ease-out;
    white-space:nowrap;
}
.logout-wrapper img {
    width: 30px;
    height: 30px;
    position: absolute;
    right: 0px;
    top: 0px;
    transition: all .3s ease-out;     
    border-radius: 50%;     
}

.logout-wrapper.open .name {
    font-size: 16px;
    font-weight: 500;
    top: 116px;
    line-height: 20px;
    text-overflow: unset;
    overflow:unset;
    width:260px;
}

.logout-wrapper.open img {
    width: 80px;
    height: 80px;
    top: 20px;
}

.logout-wrapper.open {
    border-color: #e0e0e0;
    background-color: #fbfcfc;
    box-shadow: 0px 0px 6px 8px #ececec85;   
}
p.muted {
    font-size: 12px;
    line-height: 14px;
    color: #5b6367;
    margin:0px;
    padding-top: 8px;
}
p.mail_id {
	padding: 0px 16px;
	text-align: center;
	word-break: break-word;
	font-size: 14px;
	line-height: 16px;
	color: #5b6367;
}
div.dc {
    padding: 10px 25px;
    background: #ffffff;
    border-top: solid 1px #e0e0e0;
    border-radius: 0px 0px 8px 8px;
    font-size: 10px;
    color: #5b6367;
    line-height: 16px;
    white-space: nowrap;
}
div.dc span {
    font-size: 16px;
    margin-right: 6px;
    vertical-align: middle;
    line-height: 1;
}

a.err-btn {
    background-color: #EF5E57;
    cursor: pointer;
    width: fit-content;
    width: -moz-fit-content;
    width: -webkit-fit-content;
    font-weight: 500;
    color: #fff;
    padding: 10px 30px;
    border-radius: 5px;
    font-size: 12px;
    border: none;
    margin: 20px auto;
    font-family: 'ZohoPuvi', 'Open Sans', sans-serif;
    text-decoration: none;
    display: block;
}

a.err-btn:focus, a.err-btn:focus-visible {
	outline: none;
}
a.err-btn:hover {
	background-color: #DD5858;
}
.user-info {
    position: absolute;
    top: 0px;
    right: 0px;
    height: 30px;
    margin: 8px 24px;
    /* transition: all .3s; */
}

.more-info {
    position: absolute;
    visibility: hidden;
    top: 0px;
    text-align: center;
    transition: top .3s;    
    width: 100%;
    display: table;
}

.logout-wrapper.open .more-info {
    visibility: visible;
    top: 138px;
    right: 0px;
    min-width:300px;
}

.logout-wrapper.open .user-info {
    margin:0px;
    width:300px;
}

.text-ellipsis{
	width:160px;
	text-overflow:ellipsis;
	overflow:hidden;
}

.text-ellipsis-withoutWidth{
	text-overflow:ellipsis;
	overflow:hidden;
}

.logout-wrapper.open .name.white-spaces{
	white-space: break-spaces;
	text-align:center;
	transition:right .3s ease-out,top .3s ease-out;
}

.max-width{
	max-width:260px;
}

.dummy_name{
	width:260px;
	line-height:20px;
	white-space:break-spaces;
	text-align: center;
    position: absolute;
    right: 20px;
    font-size: 16px;
    font-weight: 500;
    visibility:hidden;
}

@media only screen and ( max-width : 500px ){
	.user-info{
		margin:8px 12px;
	}
	.logout-wrapper{
		top:20px;
		right:10px;
	}
	.logout-wrapper{
		position : absolute;
	}
}

</style>
<div class="logout-wrapper">
	<div class="user-info">
		<p class="name">${logout_data.displayName}</p>
		<p class="dummy_name">${logout_data.displayName}</p>
		<img onerror="this.src='${SCL.getStaticFilePath('/v2/components/images/user_2.png')}';" src="${logout_data.profilePic}" alt="User profile picture"/>
	</div>
	<div class="more-info">
		<p class="mail_id">${Encoder.encodeHTML(logout_data.email)}</p>
		<p class="muted"> <span><@i18n key="IAM.USER.ID"/> :</span> ${logout_data.zuid}</p>
		<a href="${Encoder.encodeHTMLAttribute(logout_data.logoutUrl)}" class="err-btn"><@i18n key="IAM.SIGN.OUT"/></a> 
		<#if (logout_data.showUserCurrentDC)>
			<div class="dc">
				<span class="logout-icon-datacenter"></span>
				<@i18n key="IAM.DC.LOCATION" arg0="${logout_data.currDC}"/>
			</div>
		</#if>
	</div>
</div>
<script>
	var checkIsMobile = ${is_mobile?c};
	var logWrap = document.querySelector('.logout-wrapper');
	var userWrap = document.querySelector('.logout-wrapper .user-info');
	var moreWrap = document.querySelector('.logout-wrapper .more-info');
	var nameDom = userWrap.querySelector('p');
	var imageWrap = document.querySelector('.logout-wrapper .user-info img');
	var overflow =false;
	var initialMaxWidth = 160;
	var nameWidth = tempNameWidth =  nameDom.offsetWidth;
	var nameHeight = document.getElementsByClassName("dummy_name")[0].scrollHeight;
	if(nameDom.offsetWidth > initialMaxWidth  ){
		overflow=true;
		nameDom.classList.add("text-ellipsis");
		tempNameWidth =  nameDom.offsetWidth;
	}
	moreWrap.setAttribute('style','top:80px');
	userWrap.setAttribute('style','width:'+(nameDom.offsetWidth + 38)+'px;height:'+nameDom.offsetHeight+'px');
	
	if(checkIsMobile){
		if(window.innerWidth <= 360 ){
				if(nameWidth >= 100){
					nameDom.setAttribute('style','width:110px;height:'+nameDom.offsetHeight+'px');
					nameDom.classList.add("text-ellipsis-withoutWidth");
					userWrap.setAttribute('style','width:148px;height:'+(nameDom.offsetHeight)+'px');
					logWrap.setAttribute('style','width:'+(userWrap.offsetWidth+24)+'px;height:'+(userWrap.offsetHeight+16)+'px');
				}
				else{
					nameDom.setAttribute('style','width:'+nameWidth+'px;height:'+(nameDom.offsetHeight)+'px;');
					userWrap.setAttribute('style','width:'+( nameWidth + 38)+'px;height:'+nameDom.offsetHeight+'px');
					logWrap.setAttribute('style','width:'+(userWrap.offsetWidth + 24)+'px;height:'+(userWrap.offsetHeight+16)+'px;');
				}
		}
		else{
			logWrap.setAttribute('style','width:'+(userWrap.offsetWidth + 24)+'px;height:'+(userWrap.offsetHeight+16)+'px;');	
		}
	}
	else{
		logWrap.setAttribute('style','width:'+(userWrap.offsetWidth + 40)+'px;height:'+(userWrap.offsetHeight+16)+'px');	
	}
	
	logWrap.addEventListener('click', function(event) {
		event.stopPropagation();
		if(!event.target.classList.contains('err-btn')) {
			logWrap.classList.toggle('open');
			if(logWrap.classList.contains('open')) {
				var fullWidth =300;
				nameDom.classList.remove("text-ellipsis");
				nameDom.style.width=(fullWidth-40)+'px';
				nameDom.style.right ="20px";
				nameDom.classList.add("white-spaces");
				imageWrap.style.right = ((moreWrap.offsetWidth/2) - 40) + "px";
				userWrap.setAttribute('style','width:'+fullWidth+'px;height:'+(138+(nameHeight-20))+'px');
				moreWrap.setAttribute('style','top:'+(138+(nameHeight-20))+'px;transition:all .3s ease-out');
				logWrap.setAttribute('style','width:'+fullWidth+'px;height:'+(userWrap.offsetHeight + moreWrap.offsetHeight)+'px');
			} else {
				moreWrap.setAttribute('style','top:80px;transition:none');
				closeLogout();
			}
		}
	});
	
	document.addEventListener('click', function(event) {
		if(!event.target.classList.contains('err-btn') && logWrap.classList.contains('open')) {
			moreWrap.setAttribute('style','top:80px');
			logWrap.classList.toggle('open');
			closeLogout();
		}
	})
	
	
	function closeLogout(){
		nameDom.style.right = '38px';
		imageWrap.style.right = '0px';
		if(overflow){
			nameDom.style.width = "160px";
			nameDom.classList.add("text-ellipsis");
		}
		else{
			nameDom.style.width = nameWidth + 'px';
		}
		nameDom.classList.remove("white-spaces");
		userWrap.setAttribute('style','width:'+(tempNameWidth + 38)+'px;height:'+nameDom.offsetHeight+'px');
		if(checkIsMobile){
			if(window.innerWidth <= 360 ){
				if(nameWidth >= 100){
					nameDom.setAttribute('style','width:110px;height:'+nameDom.offsetHeight+'px');
					nameDom.classList.add("text-ellipsis-withoutWidth");
					userWrap.setAttribute('style','width:148px;height:'+(nameDom.offsetHeight)+'px');
					logWrap.setAttribute('style','width:'+(userWrap.offsetWidth+24)+'px;height:'+(userWrap.offsetHeight+16)+'px');
				}
				else{
					nameDom.setAttribute('style','width:'+nameWidth+'px;height:'+(nameDom.offsetHeight)+'px;');
					userWrap.setAttribute('style','width:'+( nameWidth + 38)+'px;height:'+nameDom.offsetHeight+'px');
					logWrap.setAttribute('style','width:'+(userWrap.offsetWidth + 24)+'px;height:'+(userWrap.offsetHeight+16)+'px;');
				}
			
			}
			else{
				logWrap.setAttribute('style','width:'+(userWrap.offsetWidth + 24)+'px;height:'+(userWrap.offsetHeight+16)+'px;');	
			}
		}
		else{
			logWrap.setAttribute('style','width:'+(userWrap.offsetWidth + 40)+'px;height:'+(userWrap.offsetHeight+16)+'px');	
		}
	}
</script>
</#if>