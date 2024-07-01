//$Id$
URI.options.contextpath = contextpath + "/signin/v2"; //No I18N
var rUriAuth = new URI(ReverseAuth);
var rUriVerify = new URI(ReverseVerify);
var h1,h2,h3,h4,qrTimer, h11;
function reverseSignin(paramObj){

	var token, wmsid, qr64, qrValidity,currentStep = 1, wmsRegistered=false, stopInterval=false;
	
	function defaultReverseCallBack(mode, data){
		switch(mode){
			case "scanReady": //No I18N
				eleClassID = data.classID
				$(eleClassID+" .qr-image").css("background-image","url('"+ qr64 +"')" )
				$(eleClassID+" .init-loader").fadeOut(200);
				$(eleClassID+" .qr-cont-wrap").addClass("active-qr");
				$(eleClassID+" .qr-refresh").removeClass("show");
				$(eleClassID+" .qr-image").removeClass("filt")
				$(eleClassID+" .qr-image").fadeIn(200);
				if(currentStep == 1){
					setTimeout(function(){
						if($(".step1-container:visible").length && h1 == undefined){
							h1 = help("help1", {  //No I18N
								msg: I18N.get("IAM.REV.HELP1.QUEST"), //No I18N
								helpTimer: 60000,
								helpCode: "q1", //No I18N
								succTxt: I18N.get("IAM.NEXT"),
								failTxt: ""
							})
							h1.initTimer();
						} else if($(".step1-container:visible").length && h1){
							h1.initTimer()
						} else if($(".rev .qrhelp-wrap:visible").length){
							h11= setTimeout(function(){
								$(".install-step .link-btn").fadeOut(100);
								$(".msg-cont").addClass("help");
								$(".msg-cont").slideDown(200);
							}, 20000)
						}
					}, 200);
				}
				break;
			case "step1Success": //No I18N
				collapseQR();
				$(".flex-container .modes-container:first-child").slideUp(500, function(){
					$(".sms-container, .totp-container, .yubikey-container").slideUp();
					$(".show-all-modes-but").slideDown();
					h1 && h1.destroyHelp();
					h11 && clearTimeout(h11);
					$(".install-step .link-btn").hide();
				});
				$(".reverse-container").slideDown(500, function(){
					currentStep = currentStep + 1;
					stepSuccess(1, 2);
					stopInterval = false;
					step2Init();
					if(h2 == undefined){
						if($("#download-lott").children().length == 0){
							lottiePlayPause("download-lott", downloadLott, "play"); //No I18N
						}
						setTimeout(function(){
							h2 = help("help2", {  //No I18N
								msg: I18N.get("IAM.REV.HELP2.QUEST"), //No I18N
								helpTimer: 60000,
								helpCode: "q2", //No I18N
								falseYes: I18N.get("IAM.REV.HELP2.FALSEYES"), //No I18N
								trueNo: I18N.get("IAM.REV.HELP2.TRUENO") //No I18N
							})
							h2.initTimer();
						}, 300);
					} else if(h2){
						h2.initTimer();
					}
					$(".rev .refresh-txt").hide();
					$(".rev .restart-txt").show();
				});
				$(".succfail-btns").fadeOut(500);
				break;
			case "step2Success":{ //No I18N
				if(currentStep == 1){
					collapseQR();
					$(".flex-container .modes-container:first-child").slideUp(500);
					$(".reverse-container").slideDown(500, function(){
						h2 && h2.destroyHelp();
						stepSuccess(1,3, setHelp);
						currentStep = 3;
						setContent()
					});
					$(".succfail-btns").fadeOut(500);
				} else if( currentStep != 3){
					h11 && clearTimeout(h11);
					h1 && h1.destroyHelp();
					stepSuccess(2,3, setHelp)
					currentStep =currentStep + 1;
					setContent()
				}else{
					setContent()
				}
				function setContent(){
				splitField.setValue("rev_split_input", ""); //No I18N
				clearError("#rev_split_input"); //No I18N
				document.querySelector("form[name=rev_form] .rev_input_cont button span").classList.remove("loader"); //No I18N
				document.querySelector("form[name=rev_form] .rev_input_cont button").removeAttribute("disabled"); //No I18N
				document.querySelector("form[name=rev_form] .rev_input_cont button").classList.remove("rev-load"); //No I18N
				$(".step"+currentStep+"-container .step"+currentStep+"-body").slideDown(200);
				$(".step"+currentStep+"-container .step"+currentStep+"-qr").slideUp(200);
					if($("#otp-lott").children().length == 0){
						lottiePlayPause("otp-lott", OTPLott, "play"); //No I18N
					}
					if(document.querySelector("form[name=rev_form] .rev_input_cont button").dataset.event != "true"){
					document.querySelector("form[name=rev_form] .rev_input_cont button").addEventListener("click", function revVerify(e){ //No I18N
						e.target.querySelector("span").classList.add("loader"); //No I18N
						e.target.setAttribute("disabled", "disabled"); //No I18N
						var code = $(".rev_input_cont input")[0].value; //No I18N
						verifyAppCode(code, e.target).then(function(){
							e.target.querySelector("span.vtxt").style.opacity="0"; //No I18N
							e.target.querySelector("span").classList.remove("loader"); //No I18N
							e.target.removeAttribute("disabled")
							e.target.querySelector("span svg").style.display="block";
							//Callback with msg "step3Success" also denotes the same
							//Success has to be handled in that Callback
						}).catch(function(resp){
							e.target.classList.remove("rev-load") //No I18N
							e.target.querySelector("span").classList.remove("loader"); //No I18N
							e.target.removeAttribute("disabled");
							if(resp.cause && resp.cause.trim() === "invalid_password_token") {
								showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), false, resp); //No I18n
							} else {
								if(!resp.localized_message){
									if(resp.errors.code == "FEE"){ //No I18N
										resp.localized_message = I18N.get("IAM.ERROR.EMPTY.FIELD")
									} else if(resp.errors.code == "IOE"){ //No I18N
										resp.localized_message = I18N.get("IAM.ERROR.VALID.OTP")
									}
								}
								classifyError(resp, "#rev_split_input"); //No I18n
							}
						})
					})
					document.querySelector("form[name=rev_form] .rev_input_cont button").dataset.event = true; //No I18N
				}
				setTimeout(function(){
					$(".rev_split_input_otp")[0].focus();
				},300)
				}
				function setHelp(){
					$(".rev_split_input_otp")[0].focus();
					if(h3 == undefined){
						setTimeout(function(){
							h3 = help("help3", {  //No I18N
								msg: I18N.get("IAM.REV.HELP3.QUEST"), //No I18N
								helpTimer: 60000,
								helpCode: "q3", //No I18N
								falseYes: I18N.get("IAM.REV.HELP3.FALSEYES"), //No I18N
								trueNo: I18N.get("IAM.REV.HELP3.TRUENO1")+" "+I18N.get("IAM.REV.HELP3.TRUENO2") //No I18N
							})
							h3.initTimer();
						}, 100);
					} else if(h3){
						h3.initTimer();
					}
				}
				break;
			}
			case "step3Success": {//No I18N
				stopInterval = false;
				collapseQR();
				if(currentStep != 3){
					$(".flex-container .modes-container:first-child").slideUp(500);
					$(".reverse-container").slideDown(500, function(){
						h2 && h2.destroyHelp()
						stepSuccess(currentStep,4, setHelp)
						currentStep = 4;
					});
					$(".succfail-btns").fadeOut(500)
				} else {
					h2 && h2.destroyHelp()
					stepSuccess(3,4, setHelp);
					currentStep = currentStep + 1;
				}
				step4Init()
				if(document.getElementById("help4").childNodes.length == 0 && h4 == undefined){
					if($("#setting-lott").children().length == 0){
						lottiePlayPause("setting-lott", settingLott, "play"); //No I18N
					}
				}
				function setHelp(){
					if(document.getElementById("help4").childNodes.length == 0 && h4 == undefined){
						setTimeout(function(){
							h4 = help("help4", {  //No I18N
								msg: I18N.get("IAM.REV.HELP4.QUEST"), //No I18N
								helpTimer: 45000,
								helpCode: "q4", //No I18N
								falseYes: I18N.get("IAM.REV.HELP4.FALSEYES"), //No I18N
								trueNo: I18N.get("IAM.REV.HELP4.TRUENO") //No I18N
							})
							h4.initTimer();
						}, 250);
					}else{
						h4.initTimer();
					}
					if(data.targetEle){
						setTimeout(function(){
							data.targetEle.querySelector("span.vtxt").style.opacity="1"; //No I18N
							data.targetEle.querySelector("span svg").style.display="none";
						}, 300);
					}
				}
				break;
			}
			case "reverseSuccess": //No I18N
				stepSuccess(4,4);
				var devData = data.mfadevice[0].devices.device[0];
				var modeData = {};
				modeData.device = devData.device_name == devData.device_info ? devData.device_name : devData.device_name + " - " +devData.device_info;
				if(devData.prefer_option === 'scanqr'){
					modeData.qr = I18N.get("IAM.SCAN.QR")
				}else if(devData.prefer_option === 'totp'){ //No I18N
					modeData.TOTP = "TOTP" //No I18N
				}else if(devData.prefer_option === 'push'){ //No I18N
					modeData.push = I18N.get("IAM.PUSH.NOTIFICATION")
				}
				if(data.mfadevice[0].is_passwordless){
					modeData.passless = I18N.get("IAM.MFA.PASSWORDLESS")
				}else{
					modeData.password = I18N.get("IAM.PASSWORD")
				}
				if(devData.bio_type == "bio"){
					modeData.bio = I18N.get("IAM.REV.BIO.ENABLED") //NO I18N
				}
				setTimeout(function(){
					showNewSuccess(modeData);
				}, 200);
				break;
			case "error": //No I18N
				classifyError(data);
				break;
			case "invalidToken": //No I18N
					if($(".qr-exp").length){
						$(".qr-exp").removeClass("active-qr");
						collapseQR();
					}
					if($(".rev .splitback:visible").length || $(".reverse-container:visible").length){
						showErrMsg(I18N.get("IAM.REV.QR.EXPIRED")+" "+I18N.get("IAM.REV.EXPIRED.CONTINUE"), false, false); //No I18N
					}
					if($(".reverse-container .back-arrow-btn:visible").length > 0){
						$(".reverse-container .back-arrow-btn").attr("data-status", "invalid")
					}
					var stepSlide;
					if(currentStep == 2){
						currentStep = 1;
						stepSlide = true;
						$(".step1-qr .cont-desc").show()
						$(".step1-qr .new-desc").hide()
					}
					if(currentStep == 1){
						h11 && clearTimeout(h11);
						$(".install-step .link-btn").hide();
						$(".rev .restart-txt").hide();
						$(".rev .refresh-txt").show();
						$(".msg-cont").slideUp(200, function(){
							$(".msg-cont").removeClass("help");
						});
						$(".warning-msg.resume-msg").slideUp(200);
					}
					if(!$(".step"+currentStep+"-qr:visible").length && $(".reverse-container:visible").length){
						$(".step"+currentStep+"-container .step"+currentStep+"-body").slideUp(200);
						$(".step"+currentStep+"-container .step"+currentStep+"-qr").slideDown(200, function(){
							$(".step"+ currentStep +"-qr .qr-image").addClass("filt")
							if(stepSlide){
								stepSuccess(2,1, function(){
									h2 && h2.destroyHelp();
								});
							}
							window["h"+currentStep] && window["h"+currentStep].destroyHelp();
							initiateProcess(currentStep);
						});
					} else {
						$(".step"+ currentStep +"-qr .qr-cont-wrap").removeClass("active-qr")
						$(".step"+ currentStep +"-qr .qr-image").addClass("filt")
						$(".step"+ currentStep +"-qr .qr-refresh").css("pointer-events", "auto")
						$(".step"+ currentStep +"-qr .icon-Reload").css("animation", "")
						$(".step"+ currentStep +"-qr .refresh-txt").show()
						$(".step"+ currentStep +"-qr .qr-refresh").addClass("show")
						if(stepSlide){
							stepSuccess(2,1);
							h2 && h2.destroyHelp();
						}
						window["h"+currentStep] && window["h"+currentStep].destroyHelp();
						if(currentStep == 1){
							$("#help1").fadeOut(200);
						}
					}
				break;	
			case "default": //No I18N
				break;
		}
	}

	var rCallBack = paramObj && paramObj.callBack ? paramObj.callBack : defaultReverseCallBack;
	
	function initiateProcess(step){
		clearTimeout(qrTimer)
		if(step == 1){
			currentStep = 1;
		}
		fetchToken().then(function (resp){
			data={}
			data.classID = ".step"+step+"-qr"; //No I18N
			rCallBack("scanReady", data) //No I18N
			window.qrTimer = setTimeout(function(){
				if(currentStep == 1 || currentStep == 2){
					rCallBack("invalidToken", data); //No I18N
				}
			}, qrValidity);
			if(wmsid != null && wmsid != undefined){
				WmsLite.setClientSRIValues(wmsSRIValues);
				WmsLite.setNoDomainChange();
				WmsLite.registerAnnon('AC', wmsid); // No I18N
				setTimeout(function(){
					if(!wmsRegistered){
						wmsid = null;
						if(currentStep == 2){
							step2Init()
						}
					}
				}, 4000)
			} else {
				if(step == 3){
					step2Init();
				}
			}
		}).catch(function (error) {
			classifyError(error);
		});	
	}
	function fetchToken(){
		if(wmsid && wmsRegistered){
			WmsLite.unregister();
		}
		stopInterval = true;
		return new Promise(function (resolve, reject) {
			var payload = ReverseAuth.create({})
			rUriAuth.POST(payload).then(function(resp){
				var rn = ReverseAuth.__zresource_name__.toLowerCase();
				token = resp[rn] && resp[rn].token;
				qr64 = resp[rn] && resp[rn].img;
				wmsid = resp[rn] && resp[rn].wmsid;
				qrValidity = resp[rn] && resp[rn].validity;
				stopInterval = false;
				resolve(resp);
			}, 
			function(resp){
				reject(resp);
			})
		});
	}
	function checkDeviceVerify(vCode){
		return new Promise(function (resolve , reject){
			if(vCode){
				var payload = ReverseVerify.create({ "token" : token, "code" : vCode }) //NO I18N
			}else{
				var payload = ReverseVerify.create({ "token" : token}) //NO I18N
			}
			rUriVerify.POST(payload).then(
				function(resp){
					resolve(resp)
				},
		 		function(resp){
					reject(resp)
				}
			);
		})
	}
	function checkConfMFA(){
		return new Promise(function (resolve , reject){
			new URI(MfaDevice, "self", "self", "mode", "").GETS() //No I18N
				.then(function(resp){
						resolve(resp._apiResponse);
					}, function(resp){
						reject(resp._apiResponse);
					}
				);
		});
	}
	function checkDeviceAuth(){
		return new Promise(function (resolve , reject){
			checkDeviceVerify().then(function(result){
				resolve(result)
			}).catch(function(result){
				reject(result)
			})
		})
	}
	var intervalCounter;
	var intervalTime = it = 3000; //in ms
	function intervalChecking(){
		intervalCounter = setInterval(function(){
			it=it+1000;
		}, 1000);
	}
	function step2Init(){
		if(!wmsid){
			if(it >= intervalTime && !stopInterval){
				clearInterval(intervalCounter)
				it=0;
				intervalChecking()
				checkDeviceAuth().then(function(resp){
					if(resp.status_code >= 200 && resp.status_code <= 299 || resp.code == "D106"){
						rCallBack();	//No success case
					}
				}).catch(function(resp){
					if(resp.status_code > 200){
						if(resp.errors[0].code){
							if(resp.errors[0].code === "IN105"){
								rCallBack("step2Success", resp); //No I18N
							}else if(resp.errors[0].code === "D102"){
								step2Init(); // device auth pending
							}else if(resp.errors[0].code === "D111"){
								rCallBack("step3Success", resp); //No I18N
							}else if(resp.errors[0].code === "IN103"){
								//invalid token , show qr to start from beginning
								rCallBack("invalidToken", resp); //No I18N
							}
						} else {
							//general error try again later || throw the receeived error 
							rCallBack("error", resp); //No I18N
						}
					}
				})
			} else if(!stopInterval){
				setTimeout(function(){step2Init()}, 300)
			}
		}
	}
	function step2Once(){
		return new Promise(function (resolve, reject){
		checkDeviceAuth().then(function(resp){
			if(resp.status_code >= 200 && resp.status_code <= 299 || resp.code == "D106"){
				reject(resp) //No success case
			}
		}).catch(function(resp){
			if(resp.errors && resp.errors[0].code){
				if(resp.errors[0].code === "IN105"){
					resolve(resp);
				}else if(resp.errors[0].code === "D102"){
					//stopInterval = true;
					reject(resp);
				}else if(resp.errors[0].code === "D111"){
					rCallBack("step3Success", resp); //No I18N
				}else if(resp.errors[0].code === "IN103"){
					rCallBack("invalidToken", resp); //No I18N
					reject(resp);
				}
			}else{
				reject(resp);
			}
		})
		})
	}
	function verifyAppCode(code, targetEle){
		return new Promise(function (resolve , reject){
			if(code == "" || code == undefined){
				result = {"errors":{"code": "FEE"}}  //FEE - Field Empty Error //No I18N
				reject(result);
				return;
			} else if(code.length != revConfigSize){
				result = {"errors":{"code": "IOE"}}  //IOE - Invalid OTP Error //No I18N
				reject(result);
				return;
			}
			checkDeviceVerify(code).then(function(resp){
				if(resp.code === "D106" || resp.status_code >= 200 && resp.status_code <= 299){
					resp.targetEle = targetEle;
					rCallBack("step3Success", resp); //No I18N
					resolve();
				}
			}).catch(function(resp){
				if(resp.errors && resp.errors[0].code && resp.errors[0].code === "IN103"){
					//invalid token , show qr to start from beginning
					rCallBack("invalidToken", resp); //No I18N
				}else{
					reject(resp);
				}
				
			});
		});
	}
	function step4Init(){
		if(!wmsid){
			if(it >= intervalTime && !stopInterval){
				clearInterval(intervalCounter)
				it=0;
				intervalChecking()
				checkConfMFA().then(function(resp){
					if(resp.status_code >= 200 && resp.status_code <= 299){
						if(resp.mfadevice && !resp.mfadevice[0].is_mfa_activated){
							step4Init();
						} else if(resp.mfadevice[0].is_mfa_activated){
							rCallBack("reverseSuccess", resp) //No I18N
						}
					}
				}).catch(function(resp){
					if(resp.status_code > 200){
						//general error try again later || throw the received error
						rCallBack("error", resp); //No I18N
					}
				})
			} else if(!stopInterval){
				setTimeout(function(){step4Init()}, 300)
			}
		}
	}
	function step4Once(){
		return new Promise(function (resolve, reject){
		checkConfMFA().then(function(resp){
			if(resp.status_code >= 200 && resp.status_code <= 299){
				if(resp.mfadevice && !resp.mfadevice[0].is_mfa_activated){
					reject(resp)
				} else if(resp.mfadevice[0].is_mfa_activated){
					rCallBack("reverseSuccess", resp) //No I18N
					resolve(resp)
				}
			}
		}).catch(function(resp){
			if(resp.status_code > 200){
				//general error try again later || throw the received error
				rCallBack("error", resp); //No I18N
			}
		})
		})
	}
	function stepSuccess(start, end, animCallBack) {
		var iter = 1;
		function successDelay(startCont, endCont, i, isEnd){
			setTimeout(function(){
				startCont.querySelector(".path").style.strokeDashoffset = "2"; //NO I18N
          		startCont.querySelector(".step-loader").classList.add("step-success-box") //NO I18N
          		startCont.querySelector(".step-loader").classList.remove("next-step") //NO I18N
          		startCont.classList.remove("current-step") //NO I18N
          		startCont.querySelector(".mode-header").removeAttribute("onclick") //NO I18N
				startCont.querySelector(".step-line").style.height = "calc(100% - 24px)"; //NO I18N
				if (isEnd) {
            		endcont.querySelector(".step-loader").classList.add("next-step") //NO I18N
            		endcont.classList.add("current-step") //NO I18N
            		endCont.querySelector(".mode-header").click(); //No I18N
					if(animCallBack){
						animCallBack();
					}
          		}
			}, i * 300);
	  	}
	  	function reverseDelay(startCont, endCont, i, isEnd){
		  setTimeout(function(){
			startCont.querySelector(".step-loader").classList.remove("next-step") //NO I18N
			startCont.classList.remove("current-step") //NO I18N
			   endCont.querySelector(".mode-header").setAttribute("onclick", "selectandslide(event)") //NO I18N
			   endCont.querySelector(".step-line").style.height = "0"; //NO I18N
			   endCont.querySelector(".path").style.strokeDashoffset = "1"; //NO I18N
			   endCont.querySelector(".step-loader").classList.remove("step-success-box") //NO I18N
			   if(isEnd){
				    endcont.querySelector(".step-loader").classList.add("next-step") //NO I18N
				    endcont.classList.add("current-step") //NO I18N
				    endCont.querySelector(".mode-header").click(); //No I18N
				    if(animCallBack){
						animCallBack();
					}
			   }
		  }, i * 200);
	  	}
      start = start === undefined ? currentStep : start;
      end = end === undefined ? currentStep + 1 : end;
      if (start != end && start < end) {
        for (s = start, e = s + 1; s <= end, e <= end; s++, e++) {
          var startcont = document.querySelector(".step" + (s) + "-container") //NO I18N
          var endcont = document.querySelector(".step" + (e) + "-container") //NO I18N
          successDelay(startcont, endcont, iter ,e == end ? true: false);
          iter++;
        }
      } else if(start > end){
		for(s = start, e = s - 1; s >= end, e >= end; s--, e-- ){
		  var startcont = document.querySelector(".step" + (s) + "-container") //NO I18N
		  var endcont = document.querySelector(".step" + (e) + "-container") //NO I18N
		  reverseDelay(startcont, endcont, iter,e == end ? true: false)
		  iter++;
		}
      } else {
		var cont =  document.querySelector(".step" + (start) + "-container") //NO I18N
		cont.querySelector(".path").style.strokeDashoffset = "2"; //NO I18N
        cont.querySelector(".step-loader").classList.add("step-success-box") //NO I18N
        cont.querySelector(".step-loader").classList.remove("next-step") //NO I18N
        cont.classList.remove("current-step") //NO I18N
        $(cont.querySelector(".mode-body")).slideUp();
        currentStep = 0;
      }
    }
	function lottiePlayPause(id, jpath){
		if(lottie){
			lottie.loadAnimation({
            	container: document.getElementById(id), 
            	renderer: "svg", // No I18N
            	loop: true,
            	autoplay: true,
            	path: jpath
        	});
		}
	} 
	function showNewSuccess(modeData){
	$(".pop-close-btn").hide();
	$(".msg-popups").prop("onkeydown","");
	$(".msg-popups").css("max-width", "500px")
	$(".msg-popups .popup-header").hide();
	$(".msg-popups .popup-body").addClass("succ-popup");
	$(".msg-popups .popup-body").html($(".new-success").html());
	if(typeof modeData === "object"){
		Object.keys(modeData).forEach(function (d){
			var t = document.querySelector(".popup-body .mode-detail").cloneNode(true); //No I18N
			t.querySelector(".mode-icon").classList.add("icon-"+d); //No I18N
			t.querySelector(".mode-text").textContent = modeData[d];
			t.style.display = "flex"
			document.querySelector(".msg-popups .popup-body .oneauth-modes").append(t); //No I18N
		})
	}
	$(".g-cancel").text(I18N.get("IAM.TFA.BANNER.REMIND.LATER"))
	$(".g-cancel").removeClass("common-btn cancel-btn")
	$(".g-cancel").addClass("link-btn")
	if(mfaData.bc_cr_time.allow_codes){
		$(".msg-popups .popup-body .generate-backup").show();
		if(mfaData.bc_cr_time.created_time_elapsed){
			$(".backup-codes-desc.old-codes").show();
			$(".backup-codes-desc.new-codes").hide();
			$("g-backup").text(I18N.get("IAM.GENERATE.BACKUP.CODES"));
		}
		if(mandatebackupconfig){
			$(".g-cancel").hide();
		}
	}else{
		$(".msg-popups .popup-body .no-backup-redirect").show();
	}
	popup_blurHandler(6);
	$(".blur").unbind();
	$(".msg-popups").slideDown(300, function(){
		$(".succ-icon .path").css("stroke-dashoffset", "2");
	});
	$(".msg-popups").focus();
}
	return{
		init: function(){
			initiateProcess(1);
		},
		getToken: function(){
			return token;
		},
		getQR64: function(){
			return qr64;
		},
		getWmsID: function(){
			return wmsid;
		},
		getCurrentStep: function(){
			return currentStep;
		},
		isWmsRegistered: function(){
			return wmsRegistered;
		},
		setWmsRegistered: function(val){
			wmsRegistered = val;
		},
		nextSuccessStep: function(step, data){
			switch(step){
				case "1":
					rCallBack("step1Success"); //No I18N
					break;
				case "2":
					if(!wmsRegistered){
						stopInterval = true;
					}
					rCallBack("step2Success", data); //No I18N
					break;
				case "3":
					rCallBack("step3Success", data) //No I18N
					break;
			}
		},
		verifyAppCode: function(code, targetEle){
			return verifyAppCode(code, targetEle);
		},
		wmsMessage: function(msg){
			switch(msg){
				case "OAInstall": //No I18N
					if(currentStep == 1){
						rCallBack("step1Success"); //No I18N
					} else if(currentStep == 2){
						data={}
						data.downloading = true;
						rCallBack("step1Success", data); //No I18N
					}
					break;
				case "CodeGen": //No I18N
					rCallBack("step2Success"); //No I18N
					break;
				case "mfaConfig": //No I18N
					if(currentStep == 4){
						step4Once().then(function(){
							//handled in callback
						}).catch(function(){
							//handled in callback
						});
					}else{
						rCallBack("step3Success"); //No I18N
					}
					break;
			}
		},
		notifyFailure: function(){
			if(currentStep == 1){
				step1question();
				'murphy' in window && sendMurphyMsg("I_rev_wms_fail_1") //No I18N
			}
			else if(currentStep == 2){
				step2Init();
				'murphy' in window && sendMurphyMsg("I_rev_wms_fail_2") //No I18N
			}
			else if(currentStep == 4){
				step4Init();
				'murphy' in window && sendMurphyMsg("I_rev_wms_fail_4") //No I18N
			}
		},
		refresh: function(e, type, step){
			initiateProcess(step);
		},
		tempStep1: function(){
			rCallBack("step1Success"); //No I18N
		},
		checkDownload: function(){
			return step2Once();
		},
		checkMFA: function(){
			return step4Once();
		},
		reset: function(){
			stopInterval = true;
			$(".step1-qr .cont-desc").hide()
			$(".step1-qr .new-desc").show()
			if(currentStep != 1){
				stepSuccess(currentStep, 1);
			}
			window["h"+currentStep] && window["h"+currentStep].destroyHelp();
			currentStep = 1;
			//help reset
		},
		stepSuccess: function(start, end, cb){
			stepSuccess(start, end, cb);
		}
	}	
}