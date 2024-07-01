<div id="captchaTemplate" class="hide" style="display:none;">
	<form  name="captchaForm" class="captchaForm" novalidate>
		<p class="captcha-desc"><@i18n key="IAM.PHONENUMBERS.CAPTCHA.DESC" /></p>
		<div class="field noindent" id="captcha_container" style="display:block">
			<div class="box_blur hide"></div>
			<div class="c-loader hide"></div>
			<div id="captcha_img" name="captcha">
				<img src="" alt="captcha" id="hip">
			</div>
			<span class="reloadcaptcha" id="reload">
				<svg version="1.1" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 1024 1024">
					<path fill="#000" d="M494.714 56.581c151.935 0 290.833 75.113 374.799 196.76l12.87-122.475c3.688-35.084 34.614-60.714 69.56-58.079l1.946 0.175c35.084 3.688 60.714 34.614 58.079 69.56l-0.175 1.946-28.852 274.513c-3.688 35.084-34.614 60.714-69.56 58.079l-1.946-0.175-274.513-28.852c-35.735-3.755-61.659-35.769-57.902-71.504 3.688-35.084 34.614-60.714 69.56-58.079l1.946 0.175 114.199 12.001c-59.764-88.932-160.063-143.924-270.004-143.924-179.59 0-325.184 145.637-325.184 325.3s145.594 325.3 325.184 325.3c117.174 0 223.414-62.459 281.301-161.974 18.067-31.059 57.893-41.59 88.95-23.524s41.59 57.893 23.524 88.95c-80.952 139.165-229.786 226.668-393.775 226.668-251.462 0-455.305-203.902-455.305-455.419s203.843-455.419 455.305-455.419z"></path>
				</svg>
			</span>
			<input id="captcha" placeholder="<@i18n key="IAM.NEW.SIGNIN.ENTER.CAPTCHA"/>" type="text" name="captcha" class="textbox" required autocapitalize="off" autocomplete="off" autocorrect="off" maxlength="8">
			<div class="captcha_field_error"></div>
		</div>
		<button tabindex="0" class="primary_btn_check" id="next_action"><span><@i18n key="IAM.NEXT" /></span></button>
		<button type="button" class="primary_btn_check high_cancel hide"  style="display:none;" id="back_action" type="button" tabindex="0"><span><@i18n key="IAM.BACK" /></span></button>
	</form>
</div>
<style>
#captcha_container {
    display: none;
    border: 1px solid #DDDDDD;
    width: 250px;
    padding: 12px;
    box-sizing: border-box;
    margin-top: 8px;
    border-radius: 4px;
    max-width:240px;
    position:relative;
}

#captcha{
	width:100%;
	margin-top:10px;
}
#captcha.errorborder{
	border:2px solid #ff8484;
}

.captcha-desc {
    font-size: 14px;
    margin: 0px 0px 15px 0px;
}

#captcha_img img {
    height: 50px;
    max-width:150px;
    width: calc(100% - 50px);
    box-sizing: border-box;
    margin: 0px;
}

#reload{
	position:absolute;
	top:20px;
	right:20px;
	width:36px;
	height:36px;
	border-radius:50%;
	background-color:#F7F7F7;
	cursor:pointer;
}

#reload svg {
    position: absolute;
    text-align: center;
    top: 11px;
    opacity: 0.5;
    left: 10px;
}

#reload svg:hover {
	opacity: 0.8;
}

.errorborder{
	border:2px solid #ff8484;
}

.force_errorborder{
	border:2px solid #ff8484 !important;
}

.captcha_field_error
{
	font-size: 14px;
}

.margin_captcha_field_error{
	margin-top:10px;
}

.errorlabel {
    color: #E92B2B;
}

.reload_anim {
    animation: spin 0.5s linear infinite, load 0.5s linear infinite;
}
.c-loader {
	border: 3px solid transparent;
	border-radius: 50%;
	border-top: 3px solid #10BC83;
	border-right: 3px solid #10BC83;
	border-bottom: 3px solid #10BC83;
	width: 26px;
	height: 26px;
	-webkit-animation: spin 1s linear infinite, load 1s linear infinite;
	animation: spin 1s linear infinite, load 1s linear infinite;
	z-index: 4;
	position: absolute;
	top: 0px;
	left: 0px;
	bottom: 0px;
	right: 0px;
	margin: auto;
	box-sizing:border-box;
	display: none;
}

.box_blur {
	background-color: #fff;
    opacity: 0.95;
    position: absolute;
    top: 0px;
    bottom: 0px;
    width: 100%;
    z-index: 4;
    display: none;
    left: 0px;
    right: 0px;
}

#common_popup #pop_action form.captchaForm {
    margin-top: -15px;
}
</style>
<script type="text/javascript">
	function captchaWrapper(payload) {
		  if(typeof ZResource !== 'undefined' && typeof Captcha === 'undefined'){ //No I18N
			  Captcha = ZResource.extendClass({
				  resourceName: "Captcha",//No I18N
				  identifier: "digest",	//No I18N 
				  attrs : ["digest","usecase"] // No i18N
			  });
		  }
		  return  {
			  isZresource : (typeof ZResource != 'undefined'), //No I18N
			  getCaptcha: function(digest){
				  if(this.isZresource) {
					  return Captcha.GET(digest)
				  } else {
					  var deferred = $.Deferred();
					  payload('/webclient/v1/captcha/'+digest, undefined, true, function(respStr) { //No I18N
						 try {
							var resp = JSON.parse(respStr);
							deferred.resolve(resp.captcha);
						  } catch(e) {
							deferred.reject(respStr || e);
						  }
					  }, "GET"); //No I18N
					  return deferred.promise();
				  }
			  },
			  reloadCaptcha: function(params) {
				  if(this.isZresource) {
					  return Captcha.create(params).POST();
				  } else {
					  var deferred = $.Deferred();
					  payload('/webclient/v1/captcha', JSON.stringify({ captcha: params }), true, function(respStr) { //No I18N
						 try {
							var resp = JSON.parse(respStr);
							deferred.resolve(resp);
						  } catch(e) {
							deferred.reject(respStr || e);
						  }
					  });
					  return deferred.promise();
				  }
			  },
			  POST: function(url, params) {
				  var deferred = $.Deferred();
				  var key = Object.keys(params)[0];
				  var data = {};
				  data[key] = Object.assign({},params[key], {
					  cdigest: payload.cdigest,
					  captcha: payload.captcha
				  })
				  payload(url, JSON.stringify(data), true, function(respStr) {
					 try {
						var resp = JSON.parse(respStr);
						if(resp.status_code >= 200 && resp.status_code <= 299){
				  			deferred.resolve(respStr);
						} else {
							deferred.reject(resp);
						}
					  } catch(e) {
						  deferred.reject(respStr || e);
					  }
				  })
				  return deferred.promise();
			  }
		  }
	}
	function handleCaptcha(data, config){
		function initiate(selector, payload, args, callbacks) {
			var q = $.Deferred();
			function errMsg() {
				var captchaContainer = $(selector+" .captchaForm #captcha"); //No I18N
				var errContainer = $(selector+" .captchaForm #captcha_container .captcha_field_error"); //No I18N
				var errClass = "errorlabel margin_captcha_field_error"; //No I18N
				var errBorder = "errorborder"; //No I18N
				return  {
					show: function(message){
						captchaContainer.addClass(errBorder);
						errContainer.addClass(errClass).html(message).slideDown(200);
					},
					hide: function(){
						captchaContainer.removeClass(errBorder);
					 	errContainer.removeClass(errClass).slideUp(100);
					 	errContainer.text("");
					}
				}
			}
			
			
			function showCatchaImg(digest) {
				loading(true);
				data.cdigest = digest;
				var imgDom = $(selector+" .captchaForm #captcha_img img" )[0]; //No I18N
				captchaWrapper(payload).getCaptcha(digest).then(function(cr) {
					if(cr.status == "success" && (cr.image_bytes!='' && cr.image_bytes != null )){ //No I18N
						imgDom.src = cr.image_bytes;
					} else {
						imgDom.src = "${SCL.getStaticFilePath("/v2/components/images/hiperror.gif")}"; //No I18N
					}
				});
			}
			
			function reloadCaptcha() {
				var loadClass = "reload_anim"; //No I18N
				var $reload = $(selector+" .captchaForm #reload" ); //No I18N
				$reload.addClass(loadClass);
				captchaWrapper(payload).reloadCaptcha({
					digest: data.cdigest,
					usecase:"sms" //No I18N
				}).then(function(reloadData){		
					showCatchaImg(reloadData.digest)
				});
				setTimeout(function(){
					$reload.removeClass(loadClass);
				},500);
			}
			
			function submit(e) {
				e.preventDefault();
				e.stopPropagation();
				var captchavalue = $(selector+" .captchaForm #captcha" ).val();  //No I18N
				if(!captchavalue) {		
					errMsg().show("<@i18n key="IAM.SIGNIN.ERROR.CAPTCHA.REQUIRED" />");
					return false;
				} else if(!(/^[a-zA-Z0-9]*$/.test( captchavalue )) || captchavalue.length<6){
					errMsg().show("<@i18n key="IAM.SIGNIN.ERROR.CAPTCHA.INVALID" />");
					return false;
				}
				payload.cdigest = data.cdigest;
				payload.captcha = captchavalue;
				var initiator = (captchaWrapper().isZresource ? payload : captchaWrapper(payload));
				var submitBtn = $(selector+" .captchaForm #next_action");
				submitBtn.prop("disabled", true);
				initiator.POST.apply(initiator, args).then(function(resp) {
					destroy();
					q.resolve(resp);
					submitBtn.removeAttr("disabled");
				}, function(r) {
					submitBtn.removeAttr("disabled");
					if(r.errors && r.errors[0] &&  r.errors[0].code == "IN107"){  //No I18N
						errMsg().show(r.localized_message);
						reloadCaptcha();
					} else if(r.cause && r.cause.trim() === "invalid_password_token") { //No I18N
						initCallbacks('relogin', r); //No I18N
					} else {
						destroy();
						q.reject(r);
					}
				});
			}
			
			function loading(show) {
				if(show){
					$(selector+" .captchaForm #captcha_container .c-loader").show().css("z-index",'5');  //No I18N
					$(selector+" .captchaForm #captcha_container .box_blur").show();  //No I18N
					$(selector+" .captchaForm #captcha_container").show();  //No I18N
				} else {
					$(selector+" .captchaForm #captcha_container .box_blur").hide();  //No I18N
					$(selector+" .captchaForm #captcha_container .c-loader").hide();  //No I18N
				}
			}
			
			function initCallbacks(mode, i) {
				if(callbacks && callbacks[mode]){
					callbacks[mode](i);
				}	
			}
			
			function destroy(){
				initCallbacks('beforeDestroy');//No I18N
				$(selector).html('');
				initCallbacks('afterDestroy');//No I18N
			}
			initCallbacks('beforeInit');//No I18N
			$(selector).html($('#captchaTemplate').html());  //No I18N
			showCatchaImg(data.cdigest);
			$(selector+" .captchaForm #hip" ).on("load", function() { //No I18N
				loading(false);
			});
			$(selector+" .captchaForm #reload" ).on( "click", reloadCaptcha); //No I18N
			$(selector+" .captchaForm #captcha_container" ).on("keydown", errMsg().hide); //No I18N
			$(selector+" .captchaForm" ).on( "submit", submit); //No I18N
			if(this.backBtn) {
				$(selector+" .captchaForm #back_action" ).show(); //No I18N
				$(selector+" .captchaForm #back_action" ).on("click", function() { //No I18N
					destroy();
					q.reject();
				})
			}
			initCallbacks('afterInit');//No I18N
			return q.promise();
		}
		function getConfig(prop, defaultVal) {
			return (config && config[prop]) || defaultVal;
		}
		return {
			backBtn: getConfig("backBtn", false), //No I18N
			anim: getConfig("anim", false), //No I18N
			errCode: getConfig("errCode", "IN108"), //No I18N
			callbacks:  getConfig("callbacks", {}), //No I18N
			init: function(selector, payload, args) {
				if(data && this.isRequired()) {
					return initiate.call(this,selector, payload, args, this.callbacks);
				}
			},
			isRequired: function (r) {
				r = data || r;
				return (r.errors && r.errors[0] && r.errors[0].code) === this.errCode;
			}
		}
	}
</script>