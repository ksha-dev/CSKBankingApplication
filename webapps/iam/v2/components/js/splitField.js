//$Id$
var splitField = {
		option : {
				"splitCount" : 6,			// No I18N
				"charCountPerSplit" : 1,	// No I18N
				"separator" : "",			// No I18N
				"separateBetween" : 0,		// No I18N
				"isIpAddress" : false,		// No I18N
				"isNumeric" : false,		// No I18N
				"otpAutocomplete" : false,	// No I18N
				"customClass": "",			// No I18N
				"inputPlaceholder": "",		// No I18N
				"placeholder": ""			// No I18N
		},
		isBackSpace : false,
		arrowKeyCode	: 0,
		createElement :function(ele,option){
			if(option == undefined || option == "" || Object.keys(option).length==0){
				option = splitField.option;
			}
			option.splitCount = option.splitCount == undefined ? splitField.option.splitCount : option.splitCount;
			option.otpAutocomplete = option.otpAutocomplete == undefined ?splitField.option.otpAutocomplete :option.otpAutocomplete;
			option.separateBetween = option.separateBetween == undefined ? splitField.option.separateBetween : option.separateBetween;
			option.charCountPerSplit = option.charCountPerSplit == undefined ? splitField.option.charCountPerSplit : option.charCountPerSplit;
			option.customClass = option.customClass == undefined ? splitField.option.customClass : option.customClass;
			option.isIpAddress = option.isIpAddress == undefined ? splitField.option.isIpAddress : option.isIpAddress;
			option.separator = option.separator == undefined ? splitField.option.separator : option.separator;
			option.inputPlaceholder = option.inputPlaceholder == undefined ? splitField.option.inputPlaceholder : option.inputPlaceholder;
			option.placeholder = option.placeholder == undefined ? splitField.option.placeholder : option.placeholder;
			if(option.isIpAddress){
				option.splitCount = 4;
				option.charCountPerSplit = 3;
				option.isNumeric = true;
			}			
			document.getElementById(ele).innerHTML="";
			var full_value = document.createElement("input");
			full_value.setAttribute("type", "hidden");
			full_value.setAttribute("class", ele+"_full_value");
			full_value.setAttribute("id", ele+"_full_value");
			document.getElementById(ele).appendChild(full_value);
			if(option.placeholder.length>0){
				document.getElementById(ele).setAttribute("placeholder", option.placeholder);		//set after element content like (content:attr(placeholder);)
			}
			for(var i=0;i<option.splitCount;i++){

				var input = document.createElement("input");
				input.setAttribute("type", "tel");
				input.setAttribute("tabindex", 0);
				if(option.inputPlaceholder.length>0){
					var placeholder_text = document.createElement('span');
					placeholder_text.innerHTML = option.inputPlaceholder;
					input.placeholder=placeholder_text.textContent;
				}
				input.classList.add("splitedText");		// No I18N
				input.classList.add("empty_field");		// No I18N
				input.classList.add(ele+"_otp");		// No I18N
				input.classList.add("limit_"+option.charCountPerSplit);	// No I18N
				if(option.customClass != ""){
					input.classList.add(option.customClass);
				}
				if(option.isIpAddress){
					input.classList.add("ip_field");		// No I18N
				}
				if(option.isNumeric){
					input.classList.add("isNumeric");		// No I18N
				}

				if(option.otpAutocomplete){
					input.setAttribute("autocomplete", "one-time-code");
				}
				
				if(option.placeholder.length>0){
					input.style.opacity='0';
				}
				
				document.getElementById(ele).appendChild(input);
				if((i+1)%option.separateBetween == 0 && i != option.splitCount-1){
					var hyphen = document.createElement("span");
					hyphen.classList.add("separator_symbol");		// No I18N
					hyphen.classList.add(ele+"_split_symbol");		// No I18N
					hyphen.innerHTML = option.separator;
					document.getElementById(ele).appendChild(hyphen);
				}
			}

			
			document.querySelector("#"+ele).removeEventListener("click",function(){},true);
			document.querySelector("#"+ele).addEventListener("click",function(e){
				if(document.querySelector("#"+ele+" .empty_field") != null){
					document.querySelector("#"+ele+" .empty_field").click();
				}
				else{					
					document.querySelectorAll("#"+ele+" .valid_otp")[option.splitCount-1].click();
				}
			});
			
			for(var i=0;i<document.querySelectorAll("#"+ele+" ."+ele+"_otp").length;i++) {
				var otpEl=document.querySelectorAll("#"+ele+" ."+ele+"_otp")[i];
			 	otpEl.addEventListener("keydown", splitField.keyPressAnalysing);
			 	otpEl.addEventListener("keydown", splitField.backSpControl);
			 	otpEl.addEventListener("click",splitField.input_selecter);
			 	otpEl.addEventListener("click",function(){splitField.focusField(this,ele,option)});
			 	otpEl.addEventListener("input",splitField.OTP_count_Analysing);
			 	otpEl.addEventListener("focus",function(ele){
			 		ele.target.parentNode.classList.add("focused_input");	// No I18N
			 	});
			 	otpEl.addEventListener("focusout",function(ele){
			 		splitField.checkFieldValue();
			 		ele.target.parentNode.classList.remove("focused_input");	// No I18N
			 	});
			 	otpEl.addEventListener("paste", splitField.pasteHandling);			 	
				if(option.placeholder.length>0){
					otpEl.addEventListener("focus",function(ele){
						ele.target.parentNode.classList.add("hidePlaceHolder");	// No I18N
						 for (var i = 0; i < ele.target.parentNode.childNodes.length; i++) {
							 ele.target.parentNode.childNodes[i].style.opacity = '1';
                         }
					});
					otpEl.addEventListener("focusout",function(ele){
						if(ele.target.parentNode.querySelector("input").value.length==0){
							ele.target.parentNode.classList.remove("hidePlaceHolder");	// No I18N
							for (var i = 0; i < ele.target.parentNode.childNodes.length; i++) {
								if(ele.target.parentNode.childNodes[i].tagName == 'INPUT'){
									ele.target.parentNode.childNodes[i].style.opacity = '0';
								}
	                         }
						}
					});
				}
			}
		},
		getParent : function(el,tagName){
			 tagName = tagName.toLowerCase()
			 while (el && el.parentNode) {el = el.parentNode;if(el.tagName && el.tagName.toLowerCase() == tagName) {return el;}}
			 return null;
		},
		focusField : function(curEle,ele,option){
			if(curEle.classList && curEle.classList.contains("valid_otp")){
				curEle.focus();
				return false;
			}
			if(document.querySelectorAll("#"+ele+" .valid_otp").length>=option.splitCount && document.querySelectorAll("#"+ele+" .valid_otp").length != 0){
				document.querySelectorAll("#"+ele+" input[type=tel]")[option.splitCount-1].focus();
				return false;
			}
			document.querySelectorAll("#"+ele+" .empty_field")[0].focus()
		},
		checkFieldValue : function(){
			for(var i=0;i<document.querySelectorAll(".splitedText").length;i++){
				var ele=document.querySelectorAll(".splitedText")[i];
				ele.value != "" ?  ele.classList.add('valid_otp') :  ele.classList.remove('valid_otp'); 
				ele.value == "" ?  ele.classList.add('empty_field') :  ele.classList.remove('empty_field');
			}
		},

		setFullValue : function(ele){
			var full_value_array = [];
			ele = ele.parentNode != null ? ele : ele.target;
			var childinputs = ele.parentNode.querySelectorAll("input"); // No I18N
			var splitCount = childinputs.length;
		    for(var j=0;j<splitCount;j++){
		    	if(childinputs[j].classList.contains("ip_field")){
		    		full_value_array.push(childinputs[j].value);
		    		if(childinputs[j] != childinputs[childinputs.length-1]){
			    		if(childinputs[j].value == ""){
				    		break;
				    	}
		    			full_value_array.push(".");	
		    		}
		    	}
		    	else if(childinputs[j].value != undefined && childinputs[0] != childinputs[j]){
		    		full_value_array.push(childinputs[j].value);
		    	}
		    }
		    full_value_array=full_value_array.join("");
		    document.querySelector("#"+ele.parentNode.id+"_full_value").value = full_value_array; // No I18N
		},
		autoFillOtp : function(otp_data,eve){
			var valueTarget = eve.target ? eve.target : eve;
			if(splitField.isBackSpace){return false;}
			otp_data = otp_data.split("");
			splitCount = valueTarget.parentNode.querySelectorAll("input").length - (1); // No I18N
			charCountPerSplit = parseInt(valueTarget.className.split("limit_")[1].match(/(\d+)/)[0]);
		    var ele_length = otp_data.length < splitCount ? otp_data.length : splitCount;
		    ele_length = charCountPerSplit >1 ? otp_data.length : ele_length;
		    cur_ele = valueTarget;
		    cur_ele.value = "";
		    for(var i = 0;i < ele_length;i++){
				if(cur_ele == null){
					break;
				}

				if(charCountPerSplit > 1){
				 	if(i != 0 && i % (charCountPerSplit) == 0){
				  		cur_ele.value = cur_ele.value.slice(0,charCountPerSplit);
				  		
				  		cur_ele = cur_ele.nextElementSibling;
				  		if(cur_ele==null){break;}
				  		cur_ele.value = "";
				  	}
				  	cur_ele.value=cur_ele.value+otp_data[i];
				}
				else
				{
					cur_ele.value = otp_data[i];
					cur_ele = cur_ele.nextElementSibling;
					if(cur_ele != null && cur_ele.classList.contains("separator_symbol")){
						cur_ele = cur_ele.nextElementSibling;
				    }
				}
		    }
		    cur_ele == null  ? !valueTarget.classList.contains("ip_field") ? document.querySelectorAll("#"+ valueTarget.parentNode.id+" .splitedText")[splitCount-1].focus() : valueTarget.focus() : cur_ele.focus(); //No I18N
		   	splitField.setFullValue(valueTarget);
		    splitField.checkFieldValue();
		},
		backSpControl : function(event){ // backspace function handling then previous element selector
			if(splitField.isBackSpace) {
				if(splitField.arrowKeyCode != 0){return false}
			    var prev = this.previousElementSibling;
			    charCountPerSplit = parseInt(this.className.split("limit_")[1].match(/(\d+)/)[0]);
			    if(prev == null){return false}
			    if(prev.classList.contains("separator_symbol")){
			    	prev = prev.previousElementSibling;
			    }
				splitField.checkFieldValue();
				if(this.value != "" && charCountPerSplit <= 1){	
					this.value = "";
					this.focus();
					event.preventDefault();
					
				}
				else{
					if(charCountPerSplit > 1){
						if(this.value == ""){
							this.previousElementSibling.classList.contains("separator_symbol") ? prev.focus() : this.focus();	//No I18N
							event.preventDefault();
						}
					}
					else{
						prev.value="";
						prev.focus();
						event.preventDefault();
					}
				}
				splitField.setFullValue(this);
			}
		},
		pasteHandling : function(event,otpvalue){
			var paste = typeof otpvalue === 'undefined' ? (event.clipboardData || window.clipboardData).getData('text').split(/ /gi).join("") : otpvalue;
			var allowToPaste = true
			if(this.classList.contains("ip_field")){
				if(paste.indexOf(".") != -1){
					paste = paste.split(".");					
					for(var x in paste){if(paste[x].length>3 || paste[x].length==0){allowToPaste=false;break;}}
				}
				else{
					allowToPaste=false;
				}
				if(!allowToPaste){
					event && event.preventDefault();
					this.focus();
					return false;
				}
				paste_ele = this;
				for(var i = 0; i < paste.length; i++){
					paste_ele.value = paste[i];
					paste_ele.focus();
					paste_ele = paste_ele.nextElementSibling;
					if(paste_ele == null){break;}
					paste_ele = paste_ele.classList.contains("separator_symbol") ? paste_ele.nextElementSibling : paste_ele;	// No I18N
				}
				splitField.setFullValue(this);
			}
			else{
				if(this.classList.contains('isNumeric')){
					paste = paste.split(/[^0-9]/gi).join("");
				}
		    	if(paste == null){event && event.target.focus();event && event.preventDefault();return false}
		    	event ? splitField.autoFillOtp(paste,event) : "";
			}
			event && event.preventDefault();
		},
		OTP_count_Analysing : function(event){
			splitField.setFullValue(this);
			if(splitField.isBackSpace){return false;}
			charCountPerSplit = parseInt(this.className.split("limit_")[1].match(/(\d+)/)[0]);
			var valid_otp = this.classList.contains('isNumeric') ? this.value.split(/[^0-9]/gi).join("") : this.value;
			var nexEl = this.nextElementSibling;
			if(nexEl != null && nexEl.classList.contains("separator_symbol")){
				nexEl = nexEl.nextElementSibling;
		    }
			if(valid_otp.length<2){
			    if(nexEl && valid_otp != ""){
					this.value = valid_otp[0];
					splitField.checkFieldValue();
	  		       	if(this.classList.contains("change_otp_ele")){
	  		       		for(var i =0; i<this.parentNode.querySelectorAll("input").length-(1+document.querySelectorAll("#"+this.parentElement.id+" .separator_symbol").length);i++){
	  		       			document.getElementsByClassName("splitedText")[i].classList.remove('change_otp_ele');	// No I18N
	  		       		}
	  		       		nexEl.classList.add('change_otp_ele');	// No I18N
	  		       	}
	  		       	if(this.value.length > charCountPerSplit-1){
		  		        nexEl.focus();
		  		        nexEl.select();
						charCountPerSplit <= 1 ? nexEl.select() : "";
					}
			    }
			    else{
			    	this.value = valid_otp.slice(0,charCountPerSplit);
			    }
			}
			else
			{
				if(!splitField.isBackSpace){splitField.autoFillOtp(valid_otp,event);}
			}
			splitField.setFullValue(this);
		},
		input_selecter :function(e){
			e.stopPropagation();
			if(splitField.isBackSpace){return false;}
			if(this.value == undefined){return false}
			this.select();
			for(var i =0; i<(this.parentNode.querySelectorAll("input").length-(1));i++){
	  		   	document.getElementsByClassName("splitedText")[i].classList.remove('change_otp_ele');	// No I18N
	  		}
			if(this.value != ""){
				this.classList.add('change_otp_ele');	// No I18N
			}	
		},
		keyPressAnalysing : function(event){  //this function using for next element change
			if (event.keyCode == 13 && splitField.getParent(event.target,"for") != null){
				splitField.isBackSpace = false;
				event.stopPropagation();event.preventDefault();
				splitField.getParent(event.target,"form").requestSubmit();return false;	//No I18N
			}
			if (event.keyCode == 39 || event.keyCode == 37) {
					splitField.arrowKeyCode = event.keyCode;
			}
			else{
				splitField.arrowKeyCode = 0;
			}
			if(event.keyCode == 8 || event.keyCode == 46){
				splitField.isBackSpace = true;
			}
			else{
			 	splitField.isBackSpace = false;
			}
			var escapeNum = this.classList.contains("isNumeric") && !(48 <= event.keyCode && event.keyCode <= 57 || event.keyCode == 37 || event.keyCode == 39);	// No I18N
			if(escapeNum){return false;}
			if(splitField.isBackSpace && splitField.arrowKeyCode == 0){return false;}
			var sibs = splitField.getNextSiblings(this);
		    var nexEl = this.nextElementSibling && this.nextElementSibling.nodeName === 'INPUT' ? this.nextElementSibling : sibs[0] ? sibs[0] : this.nextElementSibling;
		    if(nexEl && this.value!= null && !this.classList.contains("change_otp_ele")){
			    splitField.checkFieldValue();
			    charCountPerSplit = parseInt(this.className.split("limit_")[1].match(/(\d+)/)[0]);
			    if(document.activeElement!=null){
					if(this.value.length != 3 && !this.classList.contains("ip_field")){
						if(this.value == document.activeElement.value && document.activeElement === this){
					    	nexEl = this;
					    }
					 }
			    }
			    if(charCountPerSplit > 1){
			  	    if(this.value.length > charCountPerSplit-1 && event.keyCode != 9){
				    	nexEl.focus();
				    	nexEl.select();
			  		}
			    }
			    else{
			    	if(event.keyCode != 9){
			         	nexEl.focus();
					    nexEl.select();
			    	}
			    }
		    }
		    if(splitField.arrowKeyCode == 37 && this.previousElementSibling && this.previousElementSibling.classList.contains('splitedText')){
		    	event.preventDefault();
		    	this.previousElementSibling.focus();
		    	this.previousElementSibling.select();
		    }
		    else if(splitField.arrowKeyCode == 39 && this.nextElementSibling && this.nextElementSibling.classList.contains('splitedText')){
		    	event.preventDefault();
		    	this.nextElementSibling.focus();
		    	this.nextElementSibling.select();
		    }
		    else if(splitField.arrowKeyCode == 37 || splitField.arrowKeyCode == 39){
		    	this.focus();
		    	this.select();
		    }
		},
		getNextSiblings: function(elem) {
    		var sibs = [];
    		while (elem = elem.nextElementSibling) {
        		if (elem.nodeName === 'INPUT') {sibs.push(elem)};
    		}
    		return sibs;
		},
		getValue : function(ele){
			return document.getElementById(ele+"_full_value").value;
		},
		setValue : function(id,val){
			var ele = document.getElementById(id).children[1];
			if(val != "" ){
				if(ele.classList.contains("ip_field")){
					if(val.indexOf(".") != -1){
						val = val.split(".");					
						for(var x in val){if(val[x].length>3 || val[x].length==0){break;}}
					}
					paste_ele = ele;
					for(var i = 0; i < val.length; i++){
						paste_ele.value = val[i];
						paste_ele.focus();
						paste_ele = paste_ele.nextElementSibling;
						if(paste_ele == null){break;}
						paste_ele = paste_ele.classList.contains("separator_symbol") ? paste_ele.nextElementSibling : paste_ele;	// No I18N
					}
					splitField.setFullValue(ele);
				} else {
					if(ele.classList.contains('isNumeric')){
						val = val.split(/[^0-9]/gi).join("");
					}
		    		splitField.autoFillOtp(val,ele);
				}
			} else {
				document.querySelectorAll("#"+ id +" input").forEach(function(eEle){ eEle.value =""; }); //No I18N
			}
		},
		disableSplitField : function (ele){
			$(ele).find("input").attr("disabled","disabled"); //No I18n
			$(ele).find("input").css({"opacity" : "0.6", "background" : "transparent"});
			$(ele).css({"pointer-events": "none", "cursor":"not-allowed"});
		}
	}