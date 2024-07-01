// $Id: $

/**
This is our own custom select plugin, which can be used in any project although it has some tweaks and quirks related to Zoho Accounts (for example, easily usable predefined country select, 
mobile country code select)

How to get started



 */
var uvselect = {
	search_text_placeholder : (typeof iam_search_text !== 'undefined') ? iam_search_text : "Search...", //No I18n
	no_result_text_placeholder : (typeof iam_no_result_found_text !== 'undefined') ? iam_no_result_found_text : "No result found", //No I18n
	windowClickBind : false,
	windowResizeBind : false,
	windowScrollBind : false,
	windowKeyDownBind : false,
	searchIconSVG : '<svg width="100%" height="100%" viewBox="0 0 1023.013 1023.013"><path id="search" d="M443.733,0C688.8,0,887.466,198.666,887.466,443.733A441.735,441.735,0,0,1,802.06,705.511l200.957,200.963a68.267,68.267,0,0,1-95.618,97.453l-.926-.909L705.51,802.061a441.735,441.735,0,0,1-261.778,85.406C198.665,887.467,0,688.8,0,443.734S198.665,0,443.732,0Zm0,136.533c-169.662,0-307.2,137.538-307.2,307.2s137.538,307.2,307.2,307.2,307.2-137.538,307.2-307.2-137.538-307.2-307.2-307.2Z" transform="translate(0.001)"/></svg>', //No I18n
	
	initDefaultValues : function(id){
		uvselect[id].realValue = "value";
		uvselect[id].cntyCodeAttr = "data-num";
		uvselect[id].flagCodeAttr = "value";
	},
	
	//This function enables viewonly mode, user cannot interact with it
	enableViewMode : function(ids){
		var ids = ids.split(",");
		for (var i = 0; i < ids.length; i++) {
			var id = ids[i].replace("#","");
			uvselect.getSelectboxByID(id).addClass('selectbox--viewmode');	//No I18n
			uvselect[id].ViewMode = true;
		}
	},
	//This function disables viewonly mode enabled by the above method, disable the viewonly mode before the user can interact with it
	disableViewMode : function(ids){
		var ids = ids.split(",");
		for (var i = 0; i < ids.length; i++) {
			var id = ids[i].replace("#","");
			uvselect.getSelectboxByID(id).removeClass('selectbox--viewmode');	//No I18n
			uvselect[id].ViewMode = false;
		}
	},
	// generates a random ID
	idGenerator : function(){
		var S4 = function() {
	       return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
	    };
	    return (S4()+S4());
	},
	//Encode HTML characters 
	escapeHTML : function (value) 
	{
		if(value) {
			value = value.split("#").join("&#x23;");
			value = value.split("<").join("&lt;");
			value = value.split(">").join("&gt;");
			value = value.split("\"").join("&quot;");	//No I18N
			value = value.split("'").join("&#x27;");
			value = value.split("/").join("&#x2F;");
			//value = value.split("@").join("\x40");
			value = value.split("@").join("&#x40;");
			value = value.split("+").join("&#x2b;");
	    }
	    return value;
	},
	//Decode characters encoded by the above method
	decodeHTML : function (value) 
	{
		if(value) {
			value = value.split("&#x23;").join("#");
			value = value.split("&lt;").join("<");
			value = value.split("&gt;").join(">");
			value = value.split("&quot;").join("\"");	//No I18N
			value = value.split("&#x27;").join("'");
			value = value.split("&#x2F;").join("/");
			//value = value.split("@").join("\x40");
			value = value.split("&#x40;").join("@");
			value = value.split("&#x2b;").join("+");
	    }
	    return value;
	},
	decodeHTMLDefault : function (t){
		return t != "" ? $('<textarea />').html(t).text() : "";
	},
	//Get the first scrollable parent element for the given element
	getScrollParent : function(node) {
		  if (node == null) {
		    return null;
		  }
		  if (node.scrollHeight > node.clientHeight) {
		    return node;
		  } else {
		    return uvselect.getScrollParent(node.parentNode);
		  }
	},
	//Check whether the given element is in viewport of the user screen
	isElementInViewport : function(el) {
	    if (typeof jQuery === "function" && el instanceof jQuery) {
	        el = el[0];
	    }
	    var scroll_parent = window;
	    var result = uvselect.getScrollParent(el.parentNode);
	    if(result != null){
	    	scroll_parent = result;
	    }
	    var rect = el.getBoundingClientRect();
	    var top_value = scroll_parent.getBoundingClientRect().top;
	    var left_value = scroll_parent.getBoundingClientRect().left;
	    return (
	        rect.top >= Math.max(0, top_value) &&
	        rect.left >= Math.max(0, left_value) &&
	        rect.bottom <= Math.min(window.innerHeight, ((top_value < 0 ? 0 : top_value) + scroll_parent.clientHeight)) && /* or $(window).height() */
	        rect.right <= Math.min(window.innerWidth, ((left_value < 0 ? 0 : left_value) + scroll_parent.clientWidth)) /* or $(window).width() */
	    );
	},
	//Split string with the delimiter but without leaving out the delimiting character (delimiting character is also added in the splitted strings)
	stringDelimiter : function (sampleInput, delimiter) {
	    var stringArray = [''];
	    var j = 0;

	    for (var i = 0; i < sampleInput.length; i++) {
	        if (sampleInput.charAt(i) == delimiter) {
	            j++;
	            stringArray.push('');
	            stringArray[j] += sampleInput.charAt(i);
	        } else {
	            stringArray[j] += sampleInput.charAt(i);
	        }
	    }
	    return stringArray;
	},
	copyAttributes : function (attribute){
		if(attribute.nodeName === 'class'){
			this.option.className += ' '+attribute.nodeValue;
			//this.option.setAttribute('data-class', attribute.nodeValue.split(" "));
		} else {
			this.option.setAttribute(attribute.nodeName === 'id' ? 'data-id' : attribute.nodeName, attribute.nodeValue);
		}
		
		
	},
	
	escapeQuotes : function (input) {
	    return input.replace(/['"]/g, function(match) {
	        if (match === "'") {
	            return "\\'";
	        }
	        else if (match === '"') {
	            return '\\"';
	        }
	    });
	},
	
	setIntentForCntyCode :  function (id) {
		var length_ele = uvselect[id].select.siblings('input:first').attr("jsid") ? uvselect[id].select.siblings('input:first') : uvselect[id].select.parent().siblings('input:first');//no i18n
		length_ele.removeClass("uvtextindent0 uvtextindent2 uvtextindent3 uvtextindent4");
		if($(".uvselect[jsid="+id+"]").is(':visible')){
			var value_len = uvselect.getSelectInputByID(id).val().length;
	        //var value_len = $(input_ele).val().length;
	        
	        //var length_ele = $(length_id).parent().siblings("#" + changeid);
	        
	        if (value_len == "2") {
	          length_ele.addClass("uvtextindent2");
	        } else if (value_len == "3") {
	          length_ele.addClass("uvtextindent3");
	        } else if (value_len == "4") {
	          length_ele.addClass("uvtextindent4");
	        }
	        length_ele.focus();
		} else {
			length_ele.addClass("uvtextindent0");
		}
      },
	
	/*	First Param: native select html element.
		Second Param: "open", "close", "destroy"
			"open" : opens the dropdown of the already constructed uvselect.
			"close" : closes the dropdown of the already constructed uvselect.
			"destroy" : destroys the uvselect and its dropdown completely. 
	*/
	initialize : function(ele, obj){
		if(!$(ele).attr("id")){
			$(ele).attr("id", uvselect.idGenerator()); //No I18n
	    }
		var id = $(ele).attr("id");
		if(!uvselect[id]) {
			uvselect[id] = {};
		}
		
		//Pre Actions
		if(obj){
			if(typeof obj === 'object'){
				uvselect[id] = obj;
				uvselect.initDefaultValues(id);
			} else {
				uvselect[id][obj] = true;
				uvselect.initDefaultValues(id);
				if(obj == "open" && !window.isMobile){ //No I18n
					uvselect.destroySelectDropdown(id);
					uvselect.openDropDown(id);
					return id;
				} else if(obj == "close" && !window.isMobile){ //No I18n
					uvselect.destroySelectDropdown(id);
					return id;
				} else if(obj == "destroy"){ //No I18n
					uvselect.destroySelectDropdown(id);
					uvselect.destroySelectContainer(id);
					uvselect[id] = {};
					return;
				}
			}
		} else {
			uvselect.initDefaultValues(id);
		}
		
		uvselect[id].select = ele;
	    uvselect.checkForMobileScreen($(ele),obj);
	    
	    //Post Actions
	    if(obj){
	    	if(obj == "ViewMode" || obj.ViewMode){ //No I18n
	    		uvselect.enableViewMode(id);
			} else if(obj == "disableViewMode"){ //No I18n
	    		uvselect.disableViewMode(id);
			}
	    }
	    uvselect.final_handlings(id);
	    return id;
	},
	//check whether it is mobile screen or pc screen
	checkForMobileScreen : function(ele,obj){
		if(window.isMobile && (!obj || !obj.prevent_mobile_style || obj.prevent_mobile_style == undefined)){
			uvselect.create_mobile_select(ele);
		} else {
			uvselect.createSelectContainer(ele);
		}
	},
	create_mobile_select : function(t) {
		var id = t.attr("id"); //No I18n
		if($(".mobile_select_container[jsid="+id+"]").length > 0){
			return;
		}
		var mobile_select_container = document.createElement('div');
		mobile_select_container.classList.add('mobile_select_container', id); //No I18n
		mobile_select_container.setAttribute("jsid", id);
		t[0].replaceWith(mobile_select_container);
		
		if(t.attr("label")){
		    var select_label = document.createElement('div');
		    select_label.classList.add('select_label');	//No I18n
		    select_label.setAttribute("jsid", id);
		    var label = document.createTextNode(t.attr("label")); //No I18n
		    select_label.appendChild(label);
		    mobile_select_container.appendChild(select_label);
	    }
			var mobile_arrow_container = document.createElement('div');
			mobile_arrow_container.classList.add('mobile_arrow_container'); //No I18n
			mobile_arrow_container.setAttribute("jsid", id);
			mobile_select_container.appendChild(mobile_arrow_container);
			
			t.addClass('selectbox');
			t.addClass('mobile_selectbox');
			if(uvselect[id] && uvselect[id].ViewMode){
		    	t.addClass('selectbox--viewmode');	//No I18n
		    }
			t.attr("jsid", id); //No I18n
			mobile_arrow_container.appendChild(t[0]);
			
			var selectbox_arrow = document.createElement('div');
		    selectbox_arrow.classList.add('mobile_uvselect_arrow');	//No I18n
		    selectbox_arrow.setAttribute("jsid", id);
		    mobile_arrow_container.appendChild(selectbox_arrow);
		    
			    var arrow = document.createElement('b');
			    selectbox_arrow.appendChild(arrow);
		    
	},
	createSelectContainer : function(t){
	    if(!t.attr("placeholder")){
	    	t.attr("placeholder",""); //No I18n
	    }
	    var id = t.attr("id"); //No I18n
	    
	    // Calling the ajax call first to reduce loading time
		if(uvselect[id].ajax){
			uvselect.make_ajax_call(id, "");	    	
	    }
	    
	    var sel_con = document.getElementsByClassName('select_container '+id); //No I18n
	    if(sel_con.length > 0){
	    	sel_con[0].remove();
	    }
	    var sel_op_con = document.getElementsByClassName('selectbox_options_container '+id);//No I18n
	    if(sel_op_con.length > 0){
	    	sel_op_con[0].remove();
	    }
	    
	    var select_container = document.createElement('div');
	    select_container.classList.add('uvselect', 'select_container', id);	//No I18n
	    if(uvselect[id] && uvselect[id].theme){
	    	select_container.classList.add('select_container--'+uvselect[id].theme);	//No I18n
	    }
	    if(t.attr("country-code") || uvselect[id]["country-code"]) {
	    	select_container.classList.add('select_container_cntry_code', id);	//No I18n
	    }
	    
	    var widthVal = "width";//No I18n
	    if(t.attr("country-code") || uvselect[id]["country-code"]) {
	    	widthVal = "min-width";//No I18n
	    	select_container.style.width = "100%";
	    	select_container.style.width = "-moz-fit-content";
	    	select_container.style.width = "fit-content";
	    }
	    
	    if(uvselect[id] && uvselect[id].width){
	    	select_container.style[widthVal] = uvselect[id].width;
	    } else if(t.attr("size") && t.attr("size") == "medium"){ //No I18n
	    	select_container.classList.add('select_container_medium');	//No I18n
	    } else if(t.attr("width")){ //No I18n
	    	select_container.style[widthVal] = t.attr("width"); //No I18n
	    } else if(t[0].style.width != "" && t[0].style.width != "0px"){ 
	    	select_container.style[widthVal] = t[0].style.width;
	    }
	    select_container.setAttribute("jsid", id);
	    t.after(select_container);
	    
	    if(t.attr("label")){
		    var select_label = document.createElement('div');
		    select_label.classList.add('select_label');	//No I18n
		    var label = document.createTextNode(t.attr("label")); //No I18n
		    select_label.appendChild(label);
		    select_container.appendChild(select_label);
	    }
		    
		    var selectbox = document.createElement('div');
		    selectbox.classList.add('selectbox', 'basic_selectbox');	//No I18n
		    if(t.attr("multiple") || uvselect[id].multiple){
		    	selectbox.classList.add('multi_selectbox'); //No I18n
		    }
		    if(uvselect[id] && uvselect[id].theme){
		    	selectbox.classList.add('selectbox--'+uvselect[id].theme);	//No I18n
		    }
		    if(uvselect[id] && uvselect[id].ViewMode){
		    	selectbox.classList.add('selectbox--viewmode');	//No I18n
		    }
		    if(t.attr("country-code") || uvselect[id]["country-code"]){
		    	selectbox.classList.add('selectbox_cntry_code');	//No I18n
				//t.siblings('input:first').addClass('selectbox');
		    	t.siblings().is('input') ? t.siblings('input:first').attr("jsid", id) : $("#"+id).parent().siblings('input:first').attr("jsid", id); //No I18n
		    }
		    if(t.attr("inline-select") || uvselect[id]["inline-select"]){
		    	selectbox.classList.add('inline_selectbox');	//No I18n
		    }
		    if(t.attr("button-select") || uvselect[id]["button-select"]){
		    	selectbox.classList.remove('basic_selectbox'); //No I18n
		    	selectbox.classList.add('button_selectbox');	//No I18n
		    }		    
		    selectbox.setAttribute("jsid", id);
		    if(t.attr("tabindex") || uvselect[id].tabindex){
		    	selectbox.setAttribute("tabindex", t.attr("tabindex") || uvselect[id].tabindex);
		    } else {
		    	selectbox.setAttribute("tabindex", 0);
		    }		    
		    select_container.appendChild(selectbox);
		    	
		    if(!t.attr("multiple") && !uvselect[id].multiple){
		    	var selectbox_overlay = document.createElement('span');
		    	selectbox_overlay.classList.add('selectbox_overlay');	//No I18n
		    	selectbox.appendChild(selectbox_overlay);
		    }
		    
		    if(t.attr("embed-icon-class") || uvselect[id]["embed-icon-class"]){
		    	t.attr("embed-icon-class", t.attr("embed-icon-class") || uvselect[id]["embed-icon-class"]); //No I18n
		    	var leading_icon = document.createElement('i');
		    	leading_icon.classList.add('leading_icon', 'select_icon');	 //, t.attr("embed-icon-class"), t.attr("embed-icon-class")+'__selected' //No I18n
		    	if(uvselect[id] && uvselect[id].theme){
		    		leading_icon.classList.add('select_icon--'+uvselect[id].theme);	//No I18n
			    }
		    	var classes = t.attr("embed-icon-class").split(",");//No I18n
		    	for(var i = 0; i < classes.length; i++) {
		    		leading_icon.classList.add(classes[i]);
		    	}
		    	/*classes.forEach( function(item, index) {
		    		leading_icon.classList.add(item);
		    	});*/
		    	selectbox.appendChild(leading_icon);
		    }
		    /*if(t.attr("country-code") || uvselect[id]["country-code"]){
		    	t.attr("country-code", t.attr("country-code") || uvselect[id]["country-code"]); //No I18n
		    	var country_code = document.createElement('input');
		    	country_code.classList.add('country_code');	//No I18n
		    	selectbox.appendChild(country_code);
		    }*/
		    
		    if(t.attr("multiple") || uvselect[id].multiple){
		    	t.attr("multiple", t.attr("multiple") || uvselect[id].multiple); //No I18n
		    	var multi_select_input = document.createElement('div');
		    	multi_select_input.classList.add('select_input','multiselect_input');	//No I18n
		    	if(uvselect[id] && uvselect[id].theme){
		    		multi_select_input.classList.add('multiselect_input--'+uvselect[id].theme);	//No I18n
			    }
		    	multi_select_input.setAttribute("jsid", id);
		    	multi_select_input.setAttribute("placeholder", t.attr("placeholder"));
		    	multi_select_input.setAttribute("multiple", t.attr("multiple") || uvselect[id].multiple);
		    	multi_select_input.setAttribute("data-selected", "");
		    	selectbox.appendChild(multi_select_input);

		    		/*var placeholder = document.createElement('span');
		    		placeholder.appendChild(document.createTextNode(t.attr("placeholder"))); //No I18n
		    		multi_select_input.appendChild(placeholder);*/
		    		
		    		/*var selectbox_search = document.createElement('div');
					selectbox_search.classList.add('selectbox_search');	//No I18n
					if(uvselect[id] && uvselect[id].theme){
						selectbox_search.classList.add('selectbox_search--'+uvselect[id].theme);	//No I18n
				    }
					selectbox_search.setAttribute("jsid", id);
					multi_select_input.appendChild(selectbox_search);*/
		    			var selected_cards_container = document.createElement('div');
		    			selected_cards_container.classList.add('selected_cards_container');	//No I18n
		    			multi_select_input.appendChild(selected_cards_container);
				    
					    var select_search_icon = document.createElement('div');
				    	select_search_icon.classList.add('icon-search', 'select_search_icon', 'inline_search_icon');	//No I18n
				    	if(uvselect[id] && uvselect[id].theme){
				    		select_search_icon.classList.add('select_search_icon--'+uvselect[id].theme);	//No I18n
					    }
				    	multi_select_input.appendChild(select_search_icon);
				    
					    var select_search_input = document.createElement('input');
					    select_search_input.classList.add('select_search_input', 'inline_search_input', 'multiselect_search_input');	//No I18n
					    if(uvselect[id] && uvselect[id].theme){
					    	select_search_input.classList.add('select_search_input--'+uvselect[id].theme);	//No I18n
					    }
					    select_search_input.setAttribute("jsid", id);
					    select_search_input.setAttribute("placeholder", uvselect.search_text_placeholder);
					    multi_select_input.appendChild(select_search_input);
					    
		    } else if(t.attr("button-select") || uvselect[id]["button-select"]){ //No I18n
		    	var select_span = document.createElement('span');
		    	select_span.classList.add('select_span');	//No I18n
		    	if(uvselect[id] && uvselect[id].theme){
		    		select_span.classList.add('select_span--'+uvselect[id].theme);	//No I18n
			    }
		    	select_span.setAttribute("jsid", id);
		    	selectbox.appendChild(select_span);
		    } else {
		    	var select_input = document.createElement('input');
		    	if(t.attr("zoho-services") || uvselect[id]["zoho-services"]){
		    		select_input = document.createElement('div');
		    		var serviceName = document.createElement('div');
		    		serviceName.classList.add('uv_service_name');	//No I18n
		    		var orgName = document.createElement('div');
		    		orgName.classList.add('uv_org_name');	//No I18n
		    		select_input.appendChild(serviceName);
		    		select_input.appendChild(orgName);
		    		select_input.setAttribute("zoho-services", t.attr("zoho-services") || uvselect[id]["zoho-services"]);
		    	}
			    select_input.classList.add('select_input');	//No I18n
			    if(uvselect[id] && uvselect[id].theme){
			    	select_input.classList.add('select_input--'+uvselect[id].theme);	//No I18n
			    }
			    select_input.setAttribute("jsid", id);
			    select_input.setAttribute("selected-value", "");
			    select_input.setAttribute("placeholder", t.attr("placeholder"));
			    if(t.attr("validation")){
			    	select_input.setAttribute("validation", t.attr("validation"));
			    }
			    if(t.attr("country-flag") || uvselect[id]["country-flag"]){
			    	select_input.setAttribute("country-flag", t.attr("country-flag") || uvselect[id]["country-flag"]);
		    	}
			    if(t.attr("country-code") || uvselect[id]["country-code"]){
			    	select_input.classList.add('select_input_cntry_code');	//No I18n
			    	//select_input.setAttribute("size", "3");
			    }
			    select_input.setAttribute("disabled", "true");
			    selectbox.appendChild(select_input);
		    }
			    
			    var selectbox_arrow = document.createElement('span');
			    selectbox_arrow.classList.add('selectbox_arrow');	//No I18n
			    if(uvselect[id] && uvselect[id].theme){
			    	selectbox_arrow.classList.add('selectbox_arrow--'+uvselect[id].theme);	//No I18n
			    }
			    selectbox.appendChild(selectbox_arrow);
			    
				    var arrow = document.createElement('b');
				    selectbox_arrow.appendChild(arrow);
				    
		    var input_error = document.createElement('div');
		    input_error.classList.add('input_error');	//No I18n
		    if(uvselect[id] && uvselect[id].theme){
		    	input_error.classList.add('input_error--'+uvselect[id].theme);	//No I18n
		    }
		    if(uvselect[id]){
				if(uvselect[id]["use-attr-as-value"] && uvselect[id]["use-attr-as-value"] != ""){
					uvselect[id].realValue = uvselect[id]["use-attr-as-value"];
				}
				if(uvselect[id]["flag-code-attr"] && uvselect[id]["flag-code-attr"] != ""){
					uvselect[id].flagCodeAttr = uvselect[id]["flag-code-attr"];
				}
				if(uvselect[id]["country-code-attr"] && uvselect[id]["country-code-attr"] != ""){
					uvselect[id].cntyCodeAttr = uvselect[id]["country-code-attr"];
				}
		    }
		    
		    select_container.appendChild(input_error);

		    t.css({'visibility':'hidden', 'height':'0px', 'width':'0px', 'border':'none', 'float':'left', 'padding':'0px', 'display':'none'});//No I18n
		    t.attr("tabindex", -1); //No I18n

		    uvselect.loadSelectData(t);
		    uvselect.selectbox_handlers();
		    if(t.attr("inline-select") || uvselect[id]["inline-select"] || t.attr("country-code") || uvselect[id]["country-code"]){
		    	uvselect.enable_responsive_input(id);
		    }
		    //Register onchange listener for the native select to listen for changes in it and update it in uvselect
		    //t[0].addEventListener('change', uvselect.native_select_onchange_listener, true);
		    t.unbind("change").on('change',function(e, isLocal){
				if(!isLocal){
					uvselect.loadSelectData(t);
				}
			});						
	},
	loadSelectData : function(t){
		var id = t.attr("id"); //No I18n		
		if(t.attr("button-select") || uvselect[id]["button-select"]){ //No I18n
			var select_span = $(".select_span[jsid="+id+"]")[0];
			select_span.innerText = t.find("option:first").text();
			return;
		}		
		var select_input = uvselect.getSelectInputByID(id);		
	    
	    var native_sel_option = t.find(":selected");
	    if(native_sel_option.length > 0){
			select_input.val(native_sel_option.text());
			select_input.attr("selected-value",native_sel_option.attr(uvselect[id].realValue)); //No I18n
		} else if(t.val() != null && t.val() != undefined && t.val() != "") {
			//In case of maual onchange and if selected option is not avaibale, then Get the option with the same value as given, and set the text of the option in inputfield of the uvselect
			var value = t.val();
			var options = uvselect.getAllOptions(id);				
		    for (var i = 0; i < options.length; i++) {
			    var option_child = options[i];
			    //var input_element = uvselect.getSelectInputByID(id);
			    if($(option_child).attr("value") && $(option_child).attr("value") == value){
					var selected_option = $(option_child).children('p').text(); //No I18n
			    	select_input.val(selected_option).change();
			    	break;
			    } else {
					//If no option value matches, then instead of option text just set the value directly to select input of uvselect
					select_input.val(value).change();
				}
		    }		
		    select_input.attr("selected-value",t.val()); //No I18n	
		}     	    	   
	    
	    //Copy the attributes of selected option to the input element
	    if(native_sel_option.length > 0) {
	    	getArrayFromObj(native_sel_option[0].attributes).forEach(function(attribute){
	    		 if(!(attribute.nodeName == 'id' || attribute.nodeName == 'jsid' || attribute.nodeName == 'class' || attribute.nodeName == 'value')){
	    			 select_input.attr(attribute.nodeName, attribute.nodeValue);
	    		 }
	    	  });
	    }
	    
		if(t.attr("country-flag") || uvselect[id]["country-flag"]){
    		uvselect.selectFlag(id);
    	}
    	if(t.attr("zoho-services") || uvselect[id]["zoho-services"]){
    		uvselect.selectServiceIcon(id);
    		var select_obj = $(select_input);
			var service_name = uvselect.escapeHTML(select_obj.attr("data-service"));			//No I18n
			var org_name = uvselect.escapeHTML(select_obj.attr("data-org_name"));				//No I18n
			select_obj.find(".uv_service_name").text(service_name).show();		 //No I18n
			select_obj.find(".uv_org_name").text(org_name).show();		 //No I18n
			if(service_name == org_name){
				select_obj.find(".uv_service_name").hide();
			}
			else if(org_name == ""){
				select_obj.find(".uv_service_name").hide();
				select_obj.find(".uv_org_name").text(service_name);	
			}
    	}
		if(t.attr("country-code") || uvselect[id]["country-code"]){
			select_input.val(native_sel_option.attr(uvselect[id].cntyCodeAttr));
		}
		if(uvselect[id].editSelectionText){
			var edited_selection_Text = uvselect[id].editSelectionText.call(this, select_input.val());	
		    select_input.val(edited_selection_Text);
		}
		
		select_input.change();
		
		var selectbox = uvselect.getSelectboxByID(id)[0];
		//Pending Feature Handlings
		if(uvselect[id].editSelectionMarkup){
			var edited_selection_template = uvselect[id].editSelectionMarkup.call(this, selectbox);
			if(edited_selection_template){
				selectbox.innerHTML = edited_selection_template;
			}			
		}
		if(uvselect[id].templateSelection){
			var custom_selection_template = uvselect[id].templateSelection.call(this, selectbox);
	    	if(custom_selection_template){
				selectbox.innerHTML = custom_selection_template;
			}
		}		

		if((t.attr("multiple") || uvselect[id].multiple) && t.val().length != 0){
			var input_element = uvselect.getSelectInputByID(id);
			input_element.find(".option_card").remove();
			input_element.children('span').addClass('uv_hide'); //No I18n
			var selected = t.children('option:selected');	//No I18n
			var attr_value = [];
			selected.each(function(ind,ele){
				attr_value.push(ele.value);
				if(uvselect[id].templateSelection){						
					if(uvselect[id]["custom-ajax-result"]){
						var options = uvselect[id]["custom-ajax-result"].results;
						var obj = options.find(function(obj){
							if (uvselect.decodeHTMLDefault(obj.id) === ele.value){
								return obj;
							}
						});							
	    				var custom_option = uvselect[id].templateSelection.call(this, obj);
					} else {
						var custom_option = uvselect[id].templateSelection.call(this, option);
					}							    				
    				uvselect.addCustomCardToMultiSelect(input_element, ele.value, custom_option);
				} else {
					uvselect.addCardToMultiSelect(input_element, ele.value, ele.innerText);
				}
			});
			uvselect.placeSelectOptionContainer(id);
			input_element.attr('data-selected', attr_value); //No I18n
		}
	},
	createSelectDropdown : function(id){
		/*uvselect.lastWindowHeight = window.innerHeight;
		uvselect.lastWindowWidth = window.innerWidth;*/
		uvselect.destroySelectDropdown(uvselect.getCurrentDropdown().attr("jsid")); //No I18n
		var t = uvselect[id].select;
		var select_container = uvselect.getSelectContainerByID(id);
		var value = $(".select_input[jsid="+id+"]").attr("selected-value"); //No I18n

		var selectbox_options_container = document.createElement('div');
	    selectbox_options_container.classList.add('selectbox_options_container', id);	//No I18n
	    if(uvselect[id] && uvselect[id].theme){
	    	selectbox_options_container.classList.add('selectbox_options_container--'+uvselect[id].theme);	//No I18n
	    }
	    if(t.attr("dropdown-width") || uvselect[id]["dropdown-width"]) {
	    	$(selectbox_options_container).css("width", t.attr("dropdown-width") || uvselect[id]["dropdown-width"]);
	    } else {
	    	$(selectbox_options_container).css("min-width",$(select_container).css("width"));
	    }
	    selectbox_options_container.setAttribute("jsid", id);
	    if(t.attr("immediate-options") && t.attr("immediate-options")=="true"){
	    	select_container[0].appendChild(selectbox_options_container);
		} else {
		    document.body.appendChild(selectbox_options_container);
		}
	    
	    var dropdown_header = document.createElement('div');
	    dropdown_header.classList.add('dropdown_header');	//No I18n
	    if(uvselect[id] && uvselect[id].theme){
	    	dropdown_header.classList.add('dropdown_header--'+uvselect[id].theme);	//No I18n
	    }
	    dropdown_header.setAttribute("jsid", id);
	    selectbox_options_container.appendChild(dropdown_header);
	    
		if((t.attr("searchable") && t.attr("searchable")=="true") || uvselect[id].searchable){
			var selectbox_search_container = document.createElement('div');
			selectbox_search_container.classList.add('selectbox_search_container');	//No I18n
			if(uvselect[id] && uvselect[id].theme){
				selectbox_search_container.classList.add('selectbox_search_container--'+uvselect[id].theme);	//No I18n
		    }
			selectbox_search_container.setAttribute("jsid", id);
			dropdown_header.appendChild(selectbox_search_container);
			
				var selectbox_search = document.createElement('div');
				selectbox_search.classList.add('selectbox_search');	//No I18n
				if(uvselect[id] && uvselect[id].theme){
					selectbox_search.classList.add('selectbox_search--'+uvselect[id].theme);	//No I18n
			    }
				selectbox_search.setAttribute("jsid", id);
				selectbox_search_container.appendChild(selectbox_search);
			    
				    var select_search_icon = document.createElement('div');
			    	select_search_icon.classList.add('select_search_icon');	//No I18n
			    	
			    	if(uvselect[id] && uvselect[id].theme){
			    		select_search_icon.classList.add('select_search_icon--'+uvselect[id].theme);	//No I18n
				    }
				    select_search_icon.innerHTML = uvselect.searchIconSVG;
				    selectbox_search.appendChild(select_search_icon);
			    
				    var select_search_input = document.createElement('input');
				    select_search_input.classList.add('select_search_input');	//No I18n
				    if(uvselect[id] && uvselect[id].theme){
				    	select_search_input.classList.add('select_search_input--'+uvselect[id].theme);	//No I18n
				    }
				    select_search_input.setAttribute("jsid", id);
				    select_search_input.setAttribute("placeholder", uvselect.search_text_placeholder);
				    selectbox_search.appendChild(select_search_input);
		}
	    
		    var selectbox_options = document.createElement('ul');
		    selectbox_options.classList.add('selectbox_options');	//No I18n
		    if(uvselect[id] && uvselect[id].theme){
		    	selectbox_options.classList.add('selectbox_options--'+uvselect[id].theme);	//No I18n
		    }
		    selectbox_options.setAttribute("jsid", id);
		    selectbox_options_container.appendChild(selectbox_options);
		    
		    uvselect.placeSelectOptionContainer(id);
		    /* Options list */
		    uvselect.createDropdownOptions(id, selectbox_options, true);
			/* Options list */		    
	},
	createDropdownOptions : function(id, selectbox_options, isResultLoading){
		
		/* Options list */

		// Clear any residual options created before
		selectbox_options.innerHTML = "";
		if(uvselect[id]["custom-ajax-result"]){  //If processResults function exists inside ajax object when invoking .uvselec(), then the processed data is stored here
			var children = uvselect[id]["custom-ajax-result"].results;
			
		} else if(uvselect[id].ajax && isResultLoading){ /** If Ajax results are still loading, then show "loading result" in dropdown */    		
    			var option = document.createElement('li');
    		    option.classList.add('loading_result');	//No I18n    		  
    		    
    		    selectbox_options.appendChild(option);
    			    var p = document.createElement('p');
    			    option.appendChild(p);
    				    p.appendChild(document.createTextNode('Loading...')); //No I18n
    	} else {
			var t = uvselect[id].select;    		
		    var children = t.children();			
		}
		var value = $(".select_input[jsid="+id+"]").attr("selected-value"); //No I18n
		
		for (var i = 0; i < children.length; i++) {
    		var option_child = children[i];
    		
    		var option = document.createElement('li');				
			option.classList.add('option');	//No I18n
			selectbox_options.appendChild(option); /* check -- decide whether to append at first or at last */
			
			/* If the value of the current option is equal to selected value stored in uvselect select input, then mark this option as selected 
			 * in case of multi-select, check if the uvselect select input 'data-selected' value contains the value of the current option
			 */
			if($(option_child).attr(uvselect[id].realValue)){
		    	if(value == $(option_child).attr(uvselect[id].realValue)){
			    	option.classList.add('selected_option');	//No I18n
			    }

				if(t.attr('multiple')){
					var multi_selected_options = [];
					var multi_selected_options = uvselect.getMultipleSelectedOptions(id);
					if(multi_selected_options.indexOf($(option_child).attr(uvselect[id].realValue)) != -1){
						option.classList.add('uv_hide'); //No I18n
					}
				}
		    }
								 
			/** If templateResult function exists inside uvselect object when invoking .uvselec(), then plain option is sent to that function
				(i.e either plain option from natice select or plain option from ajax call, no uvselect styling is applied before senting unlike editResultMarkup)
				Hence you need to make each and every styling manually, the uvselect just appends the given result directly into the option
				If you want to apply the default uvselect stylings and customize it afterwards use 	'editResultMarkup'	
			 */					   		    
			if(uvselect[id].templateResult){
				var custom_option_template = uvselect[id].templateResult.call(this, option_child);				
			    option.innerHTML = custom_option_template;			    
			    option.setAttribute("value",  $(option).children().first().attr("value"));
			    
			    var selected_options = uvselect.getMultipleSelectedOptions(id);
			    
			    // Hide Previously selected items
			    if(selected_options.indexOf(uvselect.decodeHTML(option_child.id)) != -1){
			    	option.classList.add('uv_hide');	//No I18n
    			}
			    
			} else {
				
				/* Skip the first option for button type select as first option is considered as the button select label */
		    	if((t.attr("button-select") || uvselect[id]["button-select"]) && i==0){ //No I18n
		    		// check -- need to delete first option if already created
		    		$(option).remove();
		    		continue;
		    	}
				
				/* Handling for providing the default option , which cannot be selected (i.e, select state, select language etc..) */
			    if(i==0 && option_child.getAttribute('id') && option_child.getAttribute('id').indexOf('default') != -1){
				    	option.classList.remove('option');	//No I18n
				    	option.classList.add('default_option');	//No I18n
				}
				
				/* Copy all attributes of native option to uvselect option */
			    getArrayFromObj(option_child.attributes).forEach(uvselect.copyAttributes, {option: option});
	
				if(t.attr("embed-icon-class")){
			    	var leading_icon_option = document.createElement('i');
			    	leading_icon_option.classList.add('leading_icon', 'select_icon_option');	// t.attr("embed-icon-class"), t.attr("embed-icon-class")+'__option' //No I18n
			    	
			    	var classes = t.attr("embed-icon-class").split(",");//No I18n
			    	for(var k = 0; k < classes.length; k++) {
			    		leading_icon_option.classList.add(classes[k]);
			    	}
			    				    	
			    	if($(option_child).attr("icon-src")){
			    		$(leading_icon_option).css('background-image',$(option_child).attr("icon-src"));
			    	}			    
			    	
			    	// Tweaks related to ZOHO IAM -- for Zoho Services
			    	if(t.attr("zoho-services") || uvselect[id]["zoho-services"]){
			    		var service_code = "product-icon-"+$(option_child).attr("data-service").toLowerCase(); //No I18n
			    		leading_icon_option.classList.add(service_code.replace(/\s/g, ''));
			    		var icon_path;
			    		for(var count=1;count<=10;count++){
			    			icon_path = document.createElement('span');
			    			icon_path.classList.value = "path"+count;	//No I18n
			    			leading_icon_option.appendChild(icon_path);
			    		}
			    	}
			    	
			    	// Tweaks related to ZOHO IAM -- for Country Flags
					if(t.attr("country-flag") || uvselect[id]["country-flag"]){			    		
			    		if(t.attr("country-code") || uvselect[id]["country-code"]){
		    				option_child.text = option_child.text.split("(")[0].trim();
		    			}
						addFlagIcon($(leading_icon_option), $(option_child).attr(uvselect[id].flagCodeAttr));
			    	}
			    	option.appendChild(leading_icon_option);
			    }
			    
				var p = document.createElement('p');
			    option.appendChild(p);					    	
		    	if(uvselect[id] && uvselect[id]["break-option-text"]){
		    		var text_nodes = uvselect.stringDelimiter(option_child.text, (uvselect[id]["break-option-text"]==true) ? " ": uvselect[id]["break-option-text"]); //No I18n
		    		//var text_nodes = option_child.text.split((uvselect[id]["break-option-text"]==true) ? " ": uvselect[id]["break-option-text"]);
		    		for(var j=0; j < text_nodes.length; j++){
		    			var option_text_span = document.createElement("span");
		    			option_text_span.classList.add('option_text_span', 'option_text_span_'+(j+1));	//No I18n
		    			option_text_span.appendChild(document.createTextNode(text_nodes[j]));
		    			p.appendChild(option_text_span);
		    		}
		    	} else {
		    		p.appendChild(document.createTextNode(option_child.text));
		    	}
		    	
		    	if(uvselect[id].editResultText){
					var edited_option_text = uvselect[id].editResultText.call(this, $(p).text());			
				    $(p).text(edited_option_text);
				}
		    	
		    	// Tweaks related to ZOHO IAM -- For country code
			    if(t.attr("country-code") || uvselect[id]["country-code"]){
		    		option_child.text = option_child.text.split("(")[0];
		    		var country_code = document.createElement('div');
		    		country_code.classList.add('country_code'); //No I18n
		    		
		    		option.appendChild(country_code);
		    			
					country_code.appendChild(document.createTextNode($(option_child).attr(uvselect[id].cntyCodeAttr)));		    
		    	}
		    	// Tweaks related to ZOHO IAM -- for Zoho Services
			    if(t.attr("zoho-services") || uvselect[id]["zoho-services"]){
			    	p.innerText = "";
			    	if($(option_child).attr("data-service") == $(option_child).attr("data-org_name")){
			    		p.appendChild(document.createTextNode(uvselect.escapeHTML(option_child.text)));
			    		//ob = '<span class="service_icon product_icon" ></span><span class="org_name">'+escapeHTML(option.text)+"</span>" ;
			    	}
			    	else if($(option_child).attr("data-org_name")=="" || $(option_child).attr("data-org_name")==undefined){
			    		p.appendChild(document.createTextNode($(option_child).attr("data-service")));
			    		//ob = '<span class="service_icon product_icon icon_'+service.toLowerCase()+'" ></span><span class="org_name">'+service+"</span>" ;
			    	}
			    	else{
			    		p.appendChild(document.createTextNode(uvselect.escapeHTML($(option_child).attr("data-org_name"))));
			    		//ob = '<span class="service_icon product_icon icon_'+service.toLowerCase()+'" ></span><span class="org_name">'+escapeHTML(org_name)+"</span>" ;
			    	}
			    }
			    
			    if(uvselect[id].editResultMarkup){
					var edited_option_template = uvselect[id].editResultMarkup.call(this, option_child);				
				    option.innerHTML = edited_option_template;				    				    
				}
			    			    		    			    	
			}									
		}
		
		/* If a custom height for options is specified, then set the height of all options to the given value */
	    if(uvselect[id]["option-height"]){					
			$('.selectbox_options_container .selectbox_options .option').css({"height": uvselect[id]["option-height"]}); //No I18n
		}
		
		/* create a 'No Result' option and hide it, need to unhide it whenever needed */
		var option = document.createElement('li');
	    option.classList.add('no_result', 'uv_hide');	//No I18n
	    if(children.length == 0){
	    	option.classList.remove('uv_hide');	//No I18n
	    }	    
	    selectbox_options.appendChild(option);
	    
		    var p = document.createElement('p');
		    option.appendChild(p);
			    p.appendChild(document.createTextNode(uvselect.no_result_text_placeholder)); // check-- Tweaks related to ZOHO IAM -- used No result IAM constant
			    
		
		/* If a custom theme class is specified, then add the theme class to all the option elements and its children */
		if(uvselect[id] && uvselect[id].theme){	    	
	    	$('.selectbox_options_container .selectbox_options .option').addClass('option--'+uvselect[id].theme); //No I18n		    	
	    	$('.selectbox_options_container .selectbox_options .loading_result').addClass('loading_result--'+uvselect[id].theme); //No I18n		    	
	    	$('.selectbox_options_container .selectbox_options .option .select_icon_option').addClass('select_icon_option--'+uvselect[id].theme); //No I18n		    	
	    	$('.selectbox_options_container .selectbox_options .option .country_code').addClass('country_code--'+uvselect[id].theme); //No I18n
	    	$('.selectbox_options_container .selectbox_options .no_result').addClass('no_result--'+uvselect[id].theme); //No I18n		    	
	    }
		
		uvselect.dropdown_handlers();
				    
		/* Options list */
	},
	destroySelectContainer : function(id){
		var sel_con = document.getElementsByClassName('select_container '+id); //No I18n
	    if(sel_con.length > 0){
	    	sel_con[0].remove();
	    }
	    /*var mob_sel_con = document.getElementsByClassName('mobile_select_container '+id); //No I18n
	    if(mob_sel_con.length > 0){
	    	mob_sel_con[0].remove();
	    }*/
	},
	destroySelectDropdown : function(id) {
		if(uvselect[id] && uvselect[id]["onDropdown:close"]){
    		uvselect[id]["onDropdown:close"].call(this);
		}
		var t = uvselect.getSelectboxByID(id).removeClass("selectbox--open selectbox--open-reverse"); //No I18n
		if(uvselect[id] && uvselect[id]["country-code"]) {
			t.parent().siblings().is('input') ? t.parent().siblings("input[jsid="+id+"]").removeClass("selectbox--open selectbox--open-reverse") : $("#"+id).parent().siblings("input[jsid="+id+"]").removeClass("selectbox--open selectbox--open-reverse"); //No I18n
		}
		if(t.attr("place-options-after") || (uvselect[id] && uvselect[id]["place-options-after"])){
			$("#"+uvselect[id]["place-options-after"]).removeClass("selectbox--open selectbox--open-reverse"); //No I18n
		}
		var sel_op_con = document.getElementsByClassName('selectbox_options_container '+id); //No I18n
	    if(sel_op_con.length > 0){
	    	sel_op_con[0].remove();
	    }
	    if(uvselect[id] && uvselect[id]["country-code"]){
	    	uvselect[id].select.siblings('input:first').focus(); //No I18n
	    } else {
	    	uvselect.getSelectboxByID(id).focus();
	    }
	    document.removeEventListener('click', uvselect.click_listener, true);
	    document.removeEventListener('scroll', uvselect.scroll_listener, true);
	    window.removeEventListener('resize', uvselect.window_resize_listener, true);
	},
	getSelectContainerByID : function(id){
		return $(".select_container[jsid="+id+"]");
	},
	getSelectboxByID : function(id){
		//return uvselect.getSelectContainerByID(id).children(".selectbox"); //No I18n
		return $(".selectbox[jsid="+id+"]");
	},
	getSelectInputByID : function(id){
		return $(".select_input[jsid="+id+"]");
	},
	getOptionsContainerByID : function(id){
		return $(".selectbox_options_container[jsid="+id+"]");
	},
	isDropdownOpen : function(id){
		if($(".selectbox_options_container[jsid="+id+"]").length > 0){
			return true;
		}
		return false;
	},
	getCurrentDropdown : function(){
		//return document.getElementsByClassName("selectbox_options_container")[0];
		return $(".selectbox_options_container");
	},
	openDropDown : function(id){
		uvselect.createSelectDropdown(id);
		if(uvselect[id] && uvselect[id]["onDropdown:open"]){
    		uvselect[id]["onDropdown:open"].call(this, uvselect.getCurrentDropdown()[0]);
		}
		uvselect.placeSelectOptionContainer(id);
		if($(".option.selected_option").length > 0){
			$(".option.selected_option")[0].classList.add("option__highlighted");
			if(uvselect.check_if_overflowing(uvselect.getOptionsContainerByID(id).children(".selectbox_options")[0])){
				$(".option.selected_option")[0].scrollIntoView({block: "nearest", inline: "nearest"}); //No I18n
			}			
	    }		
		uvselect.focusSelectbox(id);
		if($(".select_search_input[jsid="+id+"]").length > 0){
			$(".select_search_input[jsid="+id+"]").focus();
		}
		document.addEventListener('click', uvselect.click_listener, true);
		document.addEventListener('scroll', uvselect.scroll_listener, true);
		window.addEventListener('resize', uvselect.window_resize_listener, true);
		uvselect.dropdown_final_handlings(id);				
		
	},
	closeCurrentDropdown : function(){

		var t = uvselect.getCurrentDropdown();
		var id = t.attr("jsid"); //No I18n
		var q = uvselect.getSelectContainerByID(id);
		var r = q.children(".selectbox").children(".select_input"); //No I18n
		r.blur();
		uvselect.blurAllSelectbox();
		uvselect.destroySelectDropdown(id);		
	},
	focusSelectbox : function(id){
		uvselect.blurAllSelectbox();
		if(uvselect[id]["country-code"]){
			//uvselect.getSelectContainerByID(id).siblings('input:first').focus();
			uvselect.getSelectContainerByID(id).siblings('input:first').addClass("selectbox--focus");
		} else {
			uvselect.getSelectboxByID(id).addClass("selectbox--focus");
		}
	},
	blurAllSelectbox : function(){
		$(".selectbox").removeClass("selectbox--focus");
		$(".selectbox").parent().siblings('input:first').removeClass("selectbox--focus");
	},
	getSelectInput : function(select_container){
		var t = select_container;
		if (!select_container instanceof jQuery){
	    	t = $(select_container)
		}
		return t.children('.selectbox').children('.select_input'); //No I18n
	},
	getAllOptions : function(id){
		return $(".selectbox_options[jsid="+id+"]").children(".option"); //No I18n
	},
	getAllNativeSelectOptions : function(id){
		return $(uvselect[id].select).children("option"); //No I18n		
	},
	embedSelectedIcon : function(option_icon, select_icon){
		select_icon.css({"background":option_icon.css("background")}); //No I18n
		/*select_icon.css({"background-image":option_icon.css("background-image")});
		select_icon.css({"background-position":option_icon.css("background-position")});
		select_icon.css({"background-size":option_icon.css("background-size")});*/
	},
	selectFlag : function(id){				
		var select_icon = uvselect.getSelectboxByID(id).children('.leading_icon'); //No i18N
		//var flag_code = ischaracter(uvselect[id].select.find(":selected").attr("value")) ? uvselect[id].select.find(":selected").attr("value") : uvselect[id].select.find(":selected").attr("data-num"); //No i18N
		if(uvselect[id].select){
		var flag_code = uvselect[id].select.find(":selected").attr(uvselect[id].flagCodeAttr);
		
		/*if(uvselect[id]["country-code"] || uvselect[id].select.attr("country-code")){
			flag_code = flag_code.split("(")[0].trim();
		}*/
		select_icon[0].innerHTML = "";		// removes the old flag icon //No i18N
		if(flag_code){addFlagIcon(select_icon, flag_code);}
		}
	},
	selectServiceIcon : function(id){
		var servicepos = "product-icon-"+$(".select_input[jsid="+id+"]").attr("data-service").toLowerCase();//No i18N
		var select_icon = uvselect.getSelectboxByID(id).children('.leading_icon'); //No i18N
		select_icon.removeClass(function (index, className) {
		    return (className.match(/\bproduct-icon-\S+/g) || []).join(' ');// removes the old class that starts with "icon_" //No i18N
		});
		if(select_icon.children().length == 0){
			var icon_path;
			for(var count=1;count<=10;count++){
				icon_path = document.createElement('span');
				icon_path.classList.value = "path"+count;	//No I18n
				select_icon.append(icon_path);
			}
		}
		select_icon.addClass(servicepos);
	},
	addCardToMultiSelect : function (ele, value, text){
		var t = ele;
		if (!ele instanceof jQuery){
	    	t = $(ele)
		}

		var option_card = document.createElement('div');
		option_card.classList.add('option_card','default_card');	//No I18n
		option_card.setAttribute("value", value);
		t[0].appendChild(option_card);

			option_card.appendChild(document.createTextNode(text));
		
			var icon_minus = document.createElement('div');
			icon_minus.classList.add('remove_option_card','icon-Minus');	//No I18n
			option_card.appendChild(icon_minus);
	},
	addCustomCardToMultiSelect : function (ele, value, custom_template){
		var t = ele;
		if (!ele instanceof jQuery){
	    	t = $(ele)
		}

		var option_card = document.createElement('div');
		option_card.classList.add('option_card');	//No I18n
		option_card.setAttribute("value", value);
		t.children('.selected_cards_container')[0].appendChild(option_card);

			option_card.innerHTML = custom_template;
			
			var multiselect_remove = document.createElement('b');
			multiselect_remove.classList.add('multiselect_remove'); //No I18n
			multiselect_remove.setAttribute('role', 'presentation');
			$(option_card).prepend(multiselect_remove);
			
		var isOverflow = uvselect.check_if_overflowing(t.parent()[0]);
		if(isOverflow){
			t.siblings('.selectbox_arrow').addClass('uv_hide'); //No I18n
		} else {
			t.siblings('.selectbox_arrow').removeClass('uv_hide'); //No I18n
		}
		
			/*var icon_minus = document.createElement('div');
			icon_minus.classList.add('remove_option_card','icon-Minus');	//No I18n
			option_card.appendChild(icon_minus);*/
	},
	removeCardFromMultiSelect : function (ele, parentele){
		if(parentele.length>0){
			var t = ele;
			var q = parentele;
	
			if (ele instanceof jQuery){
		    	t = ele[0];
			}
			if (parentele instanceof jQuery){
		    	q = parentele[0];
			}
			q.removeChild(t);
		}
	},
	deSelectFromMultiSelect : function(id, val_to_remove){
		 var options = uvselect.getAllOptions(id);
		 var input_element = uvselect.getSelectInputByID(id);

		    for (var i = 0; i < options.length; i++) {
			    var option_child = options[i];
				    if($(option_child).attr("value") && $(option_child).attr("value") == val_to_remove){
				    	$(option_child).removeClass('uv_hide');
				    }	
		    }

		    var selected = uvselect.getMultipleSelectedOptions(id); // input_element.attr('data-selected').split(','); //No I18n
			selected.splice(selected.indexOf(val_to_remove), 1);
			input_element.attr("data-selected", selected); //No I18n

			(uvselect[id].select).val(selected).trigger('change', [true]);

		    if(input_element.children('.option_card').length == 0) {
		    	input_element.children('span').removeClass('uv_hide'); //No I18n
		    }
	},
	getMultipleSelectedOptions : function (id){
		var t = uvselect.getSelectContainerByID(id);
		var input_element = uvselect.getSelectInput(t);
		return input_element.attr('data-selected').split(','); //No I18n
	},
	placeSelectOptionContainer : function (id){
		var t = uvselect.getSelectboxByID(id);
		if(uvselect[id]["country-code"]){
			t = t.parent().siblings().is("input") ? t.parent().siblings("input[jsid="+id+"]") : $("#"+id).parent().siblings("input[jsid="+id+"]");//no i18n
			//var t = $(".selectbox_cntry_code[jsid="+id+"]")
		}
		if(t.attr("place-options-after") || uvselect[id]["place-options-after"]){
			t = $("#"+uvselect[id]["place-options-after"]);
		}
		var u = uvselect.getOptionsContainerByID(id);
		if(u.length == 0){
			return;
		}
		var rect = t[0].getBoundingClientRect();
		var selectbox_pos = rect.top + t.outerHeight();
		if ((window.innerHeight - selectbox_pos < u.outerHeight()) && rect.top > u.outerHeight()) {
		   //display dropdown upwards
			var bottom_px = window.innerHeight - rect.top; 
		   	u.css('top', ''); //No i18n
		   	u.css('bottom', bottom_px+'px'); //No i18n
		   	if(u[0].getBoundingClientRect().bottom != bottom_px){
		   		bottom_px = bottom_px + (u[0].getBoundingClientRect().bottom - rect.top);
	    		u.css('bottom', bottom_px+'px'); //No i18n
	    	}
		   	u.css('flex-direction', 'column-reverse'); //No I18n
		   	if(!t.attr("inline-select") && !uvselect[id]["inline-select"]){
			   	u.removeClass("selectbox_options_container--open");
		    	u.addClass("selectbox_options_container--open-reverse");
			   	t.removeClass("selectbox--open"); //No I18n
			   	t.addClass("selectbox--open-reverse"); //No I18n
		   	}
		   	
	    } else {
	    	var top_px = rect.top + t.outerHeight();
	    	u.css('top', top_px+'px'); //No i18n
	    	u.css('bottom', ''); //No i18n
	    	if(u[0].getBoundingClientRect().top != top_px){
	    		top_px = top_px + (rect.top - u[0].getBoundingClientRect().top) + t.outerHeight();
	    		u.css('top', top_px+'px'); //No i18n
	    	}
	    	u.css('flex-direction', 'column'); //No I18n
	    	if(!t.attr("inline-select") && !uvselect[id]["inline-select"]){
		    	u.removeClass("selectbox_options_container--open-reverse");
			   	u.addClass("selectbox_options_container--open");
		    	t.removeClass("selectbox--open-reverse"); //No I18n
		    	t.addClass("selectbox--open"); //No I18n
	    	}
	    }
		//Reassign value to adapt any changes in viewport
		rect = t[0].getBoundingClientRect();
		if(uvselect[id]["dropdown-align"] && uvselect[id]["dropdown-align"] == "right"){
			var  right_px = rect.right;
			u.css('right', right_px); //No I18n
		    if(u[0].getBoundingClientRect().right != right_px){
	    		var right_px = right_px + (u[0].getBoundingClientRect().right - rect.right);
	    		u.css('right', right_px); //No I18n
	    	}
		} else {
			var  left_px = rect.left;
			u.css('left', left_px); //No I18n
		    if(u[0].getBoundingClientRect().left != left_px){
	    		var left_px = left_px + (rect.left - u[0].getBoundingClientRect().left);
	    		u.css('left', left_px); //No I18n
	    	}
		}
	    
	    if(u.height() == 0){
			u.addClass('uv_hide');
	    } 
	},
	check_if_overflowing : function(element){
		if (element.offsetHeight < element.scrollHeight || element.offsetWidth < element.scrollWidth) {
			return true;
		} else {
			return false;
		}
	},
	selectbox_handlers : function(){

		$(".selectbox").unbind("click").click(function(e){
			if(e.target.classList.contains('remove_option_card') || e.target.classList.contains('multiselect_remove')){
				onRemoveOptionCardClick(e);
				return;
			} else if (e.target.classList.contains('mobile_selectbox')){ //No I18n
				return;
			}
			var t = $(this);
			var id = t.attr("jsid"); //No I18n
			if(uvselect.isDropdownOpen(id)){
				uvselect.destroySelectDropdown(id);
			} else {
				uvselect.openDropDown(id);
			}
		});

		$(".select_input").unbind("blur").blur(function() {
			
			var e = this;
			var t = $(this);
			var q = t.parent();
			
			if(t.attr("validation")){
				var l = q.siblings('.select_label').text();
				
				var str = t.val();
				var validation = t.attr("validation"); //No I18n
				validation = validation.split(',');
				if(validation.indexOf('special-characters') != -1 && /^[a-zA-Z0-9- ]*$/.test(str) == false) {
					this.setCustomValidity('special characters'); //No I18n
					q.children('.input_error').text(l+' does not support special characters'); //No I18n
					q.addClass('inValid');
				}
				else if(validation.indexOf('mandatory') != -1 && (str == null | str == '')) {
					this.setCustomValidity('mandatory'); //No I18n
					q.siblings('.input_error').text(l+' cannot be empty'); //No I18n
					q.addClass('inValid');
				}
				else {
					this.setCustomValidity('');
					q.siblings('.input_error').html('');
					q.removeClass('inValid');
				}
			}
		});

		$(".select_input").on("invalid", function() {
			
		});

		function onRemoveOptionCardClick(e) {
			var t = $(e.target).parent();
	        var val_to_remove = t.attr("value"); //No I18n
	        var input_element = t.parent().parent();
	        var id = input_element.attr("jsid"); //No I18n
	        
	        uvselect.deSelectFromMultiSelect(id, val_to_remove);

	        uvselect.removeCardFromMultiSelect(t, t.parent());
	        var q = uvselect.getOptionsContainerByID(id);
		    q.removeClass('uv_hide');
		    uvselect.placeSelectOptionContainer(id);
			if(uvselect[id] && uvselect[id]["onDropdown:remove"]){				
	    		uvselect[id]["onDropdown:remove"].call(this, (uvselect[id].select).find(":selected")[0], this);
			}
		    e.preventDefault();
	        e.stopPropagation();

		}
		
		if(!uvselect.windowKeyDownBind){
			//Key event handler for dropdown navigation
			$(document).on("keydown", function(event) {				
				var focused_ele = document.activeElement;
				if($(".selectbox_options_container").not(".uv_hide").length > 0){
					var t = $(".selectbox_options_container").not(".uv_hide");
					var scrollable = false;
					if(uvselect.check_if_overflowing(t.children(".selectbox_options")[0])){
						scrollable = true;
					}
					var id = t.attr("jsid"); //No I18n
					var option_list = t.children(".selectbox_options").children(".option").not('.uv_hide'); //No I18n
					var current_option = option_list.index(option_list.filter(".option__highlighted"));
					// Check for up/down key presses
					  switch(event.keyCode){
					    case 38: // Up arrow    
					      // Remove the highlighting from the previous element
					    	uvselect.getAllOptions(id).removeClass("option__highlighted");
					    	if(current_option < 0){
								option_list[0].classList.add("option__highlighted");
								if(scrollable){
									option_list[0].scrollIntoView({block: "nearest", inline: "nearest"}); //No I18n
								}
							} else {
						    	current_option = current_option > 0 ? --current_option : 0;     // Decrease the counter      
						    	option_list[current_option].classList.add("option__highlighted"); // Highlight the new element
						    	if(scrollable){
						    		option_list[current_option].scrollIntoView({block: "nearest", inline: "nearest"}); //No I18n
						    	}
							}
					    	event.preventDefault();
					      break;
					    case 40: // Down arrow
					      // Remove the highlighting from the previous element
					    	uvselect.getAllOptions(id).removeClass("option__highlighted");
					    	if(current_option < 0){
								option_list[0].classList.add("option__highlighted");
								if(scrollable){
									option_list[0].scrollIntoView({block: "nearest", inline: "nearest"}); //No I18n
								}
							} else {
						    	current_option = current_option < option_list.length-1 ? ++current_option : option_list.length-1; // Increase counter 
						    	option_list[current_option].classList.add("option__highlighted");       // Highlight the new element
						    	if(scrollable){
						    		option_list[current_option].scrollIntoView({block: "nearest", inline: "nearest"}); //No I18n
						    	}
							}
					    	event.preventDefault();
					    	break;
					    case 13: //Enter button
					    	//make the current highlighted element as selected
					    	if(option_list[current_option]){
					    		option_list[current_option].click();
					    		event.preventDefault();
					    	}					    						    	
					    	break;
					    case 27:
					    	uvselect.closeCurrentDropdown();
					    	event.preventDefault();
					    	break;
					  }
				} else if(focused_ele.classList.contains('selectbox') && focused_ele.parentElement.classList.contains('uvselect') && !focused_ele.classList.contains('selectbox--viewmode')){  //No I18n
					switch(event.keyCode){
					case 13: //Enter button
				    	//open the dropdown
						//$(focused_ele).click();
						uvselect.openDropDown(focused_ele.getAttribute("jsid"));
				    	event.preventDefault();
				    	break;
					}
				}
			  
			});
			uvselect.windowKeyDownBind = true;
		}
		
	},
	dropdown_handlers : function() {

		$('.selectbox_options_container').on('classChange', function() {
			
		});

		$(".selectbox_options .option").unbind("click").click(function(){
			var t = $(this);
			var q = t.parent();			
			var id = q.attr("jsid"); //No I18n

			var selected_option = t.children('p').text(); //No I18n
			var value = t.attr(uvselect[id].realValue == "id" ? "data-id" : uvselect[id].realValue);
			
			if(uvselect[id] && uvselect[id]["onDropdown:selecting"]){			
	    		uvselect[id]["onDropdown:selecting"].call(this, (uvselect[id].select).find(":selected")[0], this);
			}
			
			//In case of ajax call data and custom option, there will be no options in native select , hence add the selected option first before selecting it here
	    	
			if(uvselect[id].select.find("option["+uvselect[id].realValue+"='"+ uvselect.escapeQuotes(value) +"']").length < 1){
	    		var option = document.createElement('option');
	    		option.setAttribute(uvselect[id].realValue, value);
	    		uvselect[id].select[0].appendChild(option);	    		
	    	}
			
			if(t.attr("unselectable") == "true"){
				if(uvselect[id] && uvselect[id]["onDropdown:select"]){
					//If unselectable then instead of passing the native select option in this hook, the uvselect option element is passed, since the select event doesnt propagate further and no changes made to native select.
		    		uvselect[id]["onDropdown:select"].call(this, this);
				}
				return;
			}
			

			var p = uvselect.getSelectContainerByID(id);
			var selectbox = uvselect.getSelectboxByID(id);
			var input_element = uvselect.getSelectInput(p);
			p.children('.input_error').html(''); //No I18n
			p.children('.selectbox').removeClass('inValid'); //No I18n
			
			
			if(t.attr("zoho-services") || uvselect[id]["zoho-services"]){
				input_element.attr("data-service","");	//No I18n
				input_element.attr("data-org_name","");	//No I18n
			}
			//Copy the attributes of selected option to the input element
			getArrayFromObj(t[0].attributes).forEach(function(attribute){
	    		 if(!(attribute.nodeName == 'id' || attribute.nodeName == 'jsid' || attribute.nodeName == 'class' || attribute.nodeName == 'value' || attribute.nodeName == 'style')){
	    			 input_element.attr(attribute.nodeName, attribute.nodeValue);
	    		 }
	    	  });
	    	
			
			if(input_element.attr('multiple')){
				input_element.children('span').addClass('uv_hide'); //No I18n
				var selected = [];
				if(input_element.attr('data-selected') != ''){
					input_element.attr('data-selected').split(',').forEach(function(option){ //no i18n
						selected.push(option);
					});
				}
				if(selected.indexOf(value) == -1){
					selected.push(value);
					if(uvselect[id].templateSelection){						
						if(uvselect[id]["custom-ajax-result"]){
							var options = uvselect[id]["custom-ajax-result"].results;

							var obj = options.find(function(o){
								if (uvselect.decodeHTMLDefault(o.id) === value){
									return o;
								}
							});						

		    				var custom_option = uvselect[id].templateSelection.call(this, obj);
						} else {
							var custom_option = uvselect[id].templateSelection.call(this, option);
						}							    				
	    				uvselect.addCustomCardToMultiSelect(input_element, value, custom_option);
					} else {
						uvselect.addCardToMultiSelect(input_element, value, selected_option);
					}
					t.addClass('uv_hide');
					uvselect.placeSelectOptionContainer(id);
				} 
				input_element.attr('data-selected', selected); //No I18n
				if(value) {
					var sel_val = (uvselect[id].select).val();
					if(sel_val.indexOf(value) == -1){
						sel_val.push(value);
					}
					(uvselect[id].select).val(sel_val).trigger('change', [true]);
					//(uvselect[id].select).val(selected).change();
					//$("select#"+r.attr("jsid")).val(selected).change();
				}
				//Reset the value of multiselect search input field				
				//$(".multiselect_search_input[jsid="+id+"]").val("");
				$(".multiselect_search_input[jsid="+id+"]").val("");
				if(uvselect[id] && uvselect[id]["onDropdown:select"]){				
		    		uvselect[id]["onDropdown:select"].call(this, (uvselect[id].select).find(":selected")[0], this);
				}
			} else {
				if(uvselect[id].templateSelection){
					var custom_selection_template = uvselect[id].templateSelection.call(this, option);
			    	selectbox.innerHTML = custom_selection_template;			    	
				}
				if(t.attr("country-code") || uvselect[id]["country-code"]){
					input_element.val(t.attr(uvselect[id].cntyCodeAttr)).change();
				} 
				else if(uvselect[id].editSelectionText) {
					var edited_selection_Text = uvselect[id].editSelectionText.call(this, selected_option, value);			
				    input_element.val(edited_selection_Text).change();
				}
				else {
					input_element.val(selected_option).change();
				}
				input_element.attr("selected-value",value); //No I18n
				
				if(t.attr("zoho-services") || uvselect[id]["zoho-services"]){
					var service_name = uvselect.escapeHTML(input_element.attr("data-service"));			//No I18n
					var org_name = uvselect.escapeHTML(input_element.attr("data-org_name"));				//No I18n
					input_element.find(".uv_service_name").text(service_name).show();		 //No I18n
					input_element.find(".uv_org_name").text(org_name).show();		 //No I18n
					if(service_name == org_name){
						input_element.find(".uv_service_name").hide();
					}
					else if(org_name == ""){
						input_element.find(".uv_service_name").hide();
						input_element.find(".uv_org_name").text(service_name);	
					}
				}

				if(value && uvselect[id].realValue == "value") {
					uvselect[id].select.val(value).trigger('change', [true]);					
				}else if(value){
					var native_options = uvselect[id].select[0].options;
		            for (var i = 0; i < native_options.length; i++) {
		                var n_option = native_options[i];
		                if (n_option.getAttribute(uvselect[id].realValue) === value) {		                    
		                    n_option.selected = true;
		                    break;
		                }
		            }
					uvselect[id].select.trigger('change', [true]);
				}else {
					uvselect[id].select.val(selected_option).trigger('change', [true]);					
				}
								
				
				// Set selected leading icon
				if(t.children('.leading_icon').length > 0) {
					if(input_element.attr('country-flag') || uvselect[id]["country-flag"]){
						uvselect.selectFlag(id);
					} else if(input_element.attr("zoho-services") || uvselect[id]["zoho-services"]){ //No I18n
						uvselect.selectServiceIcon(id);
					} else {
						uvselect.embedSelectedIcon(t.children('.leading_icon'), input_element.siblings('.leading_icon'));
					}
				}
				
				if(uvselect[id].editSelectionMarkup){
					var edited_selection_template = uvselect[id].editSelectionMarkup.call(this, selectbox);			
				    selectbox.innerHTML = edited_selection_template;				    				    
				}
				
				if(uvselect[id] && uvselect[id]["onDropdown:select"]){				
		    		uvselect[id]["onDropdown:select"].call(this, (uvselect[id].select).find(":selected")[0], this);
				}

				//Reset Search
				q.siblings('.selectbox_search').children('.select_search_input').val(''); //No I18n
				q.children('.option').removeClass('uv_hide'); //No I18n
				uvselect.destroySelectDropdown(id);
			}
			
		});

		$(".select_search_input").unbind("keyup").on("keyup", function(event) {
			if(event.keyCode == 38 || event.keyCode == 40 || event.keyCode == 13 || event.keyCode == 27){
				return;
			}
			var t = $(this);
			var q = t.parent();
			var id = t.attr("jsid"); //No I18n
			var g = t.val().toLowerCase().replace(/\s/g, ''); //No I18n;
			
			q.parent().removeClass('uv_hide');
			
			//If it is ajax options and the length of the search term is 3 or more, then make ajax call and get the new results for dropdown
			if(uvselect[id] && uvselect[id].ajax){
				uvselect.make_ajax_call(id, g);		
				return;
			}			
			
			var multi_selected_options = [];

			var input_element = $(".select_input[jsid="+id+"]");
			if(input_element.attr('multiple')){
				var multi_selected_options = uvselect.getMultipleSelectedOptions(id);
			}
			
			
			var options = uvselect.getAllOptions(id);
			
			var arr = getArrayFromObj(options);
			var highlighted = false;
			arr.forEach( function(item, index) {
				//var s = $(item).children('p').text().toUpperCase(); //No I18n
				var s = "";
				var children = $(item).children();
			    for (var i = 0; i < children.length; i++) {
			      s = s +children[i].textContent.toLowerCase().replace(/\s/g, ''); //No I18n
			  	}

				if (s.indexOf(g)!=-1) {
					if(multi_selected_options.indexOf($(item).attr("value")) == -1){
						$(item).removeClass('uv_hide');
					}
					$('.no_result').addClass("uv_hide");
					if(!highlighted){
						item.classList.add("option__highlighted"); //No I18n
						item.scrollIntoView({block: "nearest", inline: "nearest"}); //No I18n
					}
					highlighted = true;
				}
				else {
					$(item).addClass('uv_hide');
					item.classList.remove("option__highlighted"); //No I18n
					if($('.selectbox_options .option').not('.uv_hide').length == 0){
						$('.no_result').removeClass("uv_hide");
					}
				}
			});
			
		});
		
		$(".multiselect_search_input").unbind("keydown").on("keydown", function(event) {			
			if(event.keyCode == 38 || event.keyCode == 40 || event.keyCode == 27){
				return;
			}
			var t = $(this);
		    var id = t.attr("jsid"); //No I18n
			if(event.keyCode == 13){
				if(uvselect[id]["custom-option-handler"]){
					if(uvselect.default_custom_option_handler(this, $(this).val().toLowerCase())){
						t.val("");
						event.preventDefault();
					}
					//uvselect[id]["custom-option-handler"].call(this, this, $(this).val().toLowerCase());					
				} else {
					return;
				}			
			}			
			switch(event.keyCode){
		    case 8: // BackSpace   
		      // Delete the previously selected item if the search input is empty		    	
		    	if(t.val() == ''){
		    		//t.siblings('.selected_cards_container').find("div:last").remove();
		    		var last_child = t.siblings('.selected_cards_container').children().last();
		    		var value = last_child.attr('value'); //No I18n
		    		
		    		uvselect.deSelectFromMultiSelect(id,value);
		    		/*var multi_selected_options = uvselect.getMultipleSelectedOptions(id);
		    		
		    		const index = multi_selected_options.indexOf(value);
		    		if (index > -1) {
		    			multi_selected_options.splice(index, 1);
		    		}
		    		
		    		let input_element = uvselect.getSelectInput(uvselect.getSelectContainerByID(id));
		    		input_element.attr('data-selected', multi_selected_options); //No I18n
					var sel_val = (uvselect[id].select).val();
					
		    		if (sel_val.indexOf(value) > -1) {
		    			sel_val.splice(sel_val.indexOf(value), 1);
		    		}
					(uvselect[id].select).val(sel_val).change();*/
		    		last_child.remove();
		    		uvselect.placeSelectOptionContainer(id);
		    		t.focus();
		    		event.preventDefault();
		    	}
		      break;
		  }
			
		});
	},
	click_listener : function(event) {		
		if (event && !$(event.target).closest('.select_container').length && !$(event.target).closest('.selectbox_options_container').length) {
			uvselect.closeCurrentDropdown();
		 }
	},
	scroll_listener : function(event) {	
		//portal case iframe min height not available handling
		if (event && !$(event.target).closest('.selectbox_options').length && uvselect.getCurrentDropdown().length) {
			var id = uvselect.getCurrentDropdown().attr("jsid"); //No I18n
			if(uvselect.isElementInViewport(uvselect.getSelectboxByID(id))){
				uvselect.placeSelectOptionContainer(id);
			}
		}			    
	}, 
	window_resize_listener : function(event){		
		var u = uvselect.getCurrentDropdown();
		var id = u.attr("jsid"); //No I18n
		if(u.length > 0){
			uvselect.placeSelectOptionContainer(id);
		}
	},
	native_select_onchange_listener : function(event){
		var native_select = $(event.target);		
		uvselect.loadSelectData(native_select);
	},
	enable_responsive_input : function(id){
		var t = uvselect.getSelectInputByID(id);
		//var t = $(".inline_selectbox .select_input")[0]; 
		t[0].style.width = t[0].value.length + 1 +'ch';
		uvselect.setIntentForCntyCode(id);
		//$(".inline_selectbox .select_input").unbind("change").on("change", function() {
		t.unbind("change").on("change", function() {
			this.style.width = this.value.length + 1 + 'ch';
			uvselect.setIntentForCntyCode(id);
		});
	},
	final_handlings : function(id){
		var handle_container = false;
		/**
			These handlings are specifically for Accounts setup
		 */
		if(de('zcontiner') && de('zcontiner').style.display == 'none'){
			handle_container = true;
			var visibility = de('zcontiner').style.visibility; //No I18n
			var display = de('zcontiner').style.display; //No I18n
			de('zcontiner').style.visibility='hidden';
			de('zcontiner').style.display='block';
		}
		
		if(uvselect.getSelectboxByID(id).outerHeight(true) > 45){
	    	uvselect.getSelectboxByID(id).children(".selectbox_arrow").children("b").css({"border-width": "4px"}); //No I18n
	    }
					
		if(handle_container){
			de('zcontiner').style.display=display;
			de('zcontiner').style.visibility=visibility;
		}
	},
	dropdown_final_handlings : function(id){
		//Other runtime dropdown Handlings Here		
		if(uvselect.getOptionsContainerByID(id).outerWidth(true)){
	    	uvselect.getOptionsContainerByID(id).css({"width": uvselect.getOptionsContainerByID(id).outerWidth(true)}); //No I18n
	    }
		
		//if there is no elements (i.e no search field etc) in dropdown header, then hide dropdown header
		var dropdown_header = uvselect.getOptionsContainerByID(id).children('.dropdown_header'); //No I18n
		if(dropdown_header.children().length == 0 || dropdown_header[0].innerHTML == ""){
			dropdown_header.css("all","unset"); //No I18n
		}
	},
	
	make_ajax_call : function(id, query) {
		var aj = uvselect[id].ajax;		
		if(query != ""){
			var data_pre_obj  = {};
			data_pre_obj.term = query;
		}				
    	$.ajax({
			url: aj.url,
			type: aj.type,
			dataType: aj.dataType,
			data: data_pre_obj ? aj.data.call(this, data_pre_obj): "",
			success: function (data, params) {
				uvselect[id]["ajax-result-data"] = data;
				uvselect[id]["ajax-result-params"] = params;
				uvselect[id]["custom-ajax-result"] = aj.processResults.call(this, data, params);
				
				//If the dropdown is open, then need to refresh dropdown options with the new results
				if(uvselect.isDropdownOpen(id)){
					uvselect.createDropdownOptions(id, $(".selectbox_options[jsid="+id+"]")[0], false);
				}
			},
			error: function (error) {
				aj.error.call(this, error);
			}
		});
		
	},
	
	default_custom_option_handler: function(element, value) {
		var id = $(element).attr("jsid");
		if(uvselect[id]["custom-option-handler"]){
			value = uvselect[id]["custom-option-handler"].call(this, element, value);
		}
		if(value != ''){						
			var input_element =  uvselect.getSelectInputByID(id);
			if(input_element.attr('multiple')){
				input_element.children('span').addClass('uv_hide'); //No I18n
				var selected = [];
				if(input_element.attr('data-selected') != ''){
					input_element.attr('data-selected').split(',').forEach(function(option){ // No I18N
						selected.push(option);
					});
				}
				if(selected.indexOf(value) == -1){
					selected.push(value);
					if(uvselect[id]["custom-option-templateSelection"]){												
						var custom_option = uvselect[id]["custom-option-templateSelection"].call(this, value);
	    				uvselect.addCustomCardToMultiSelect(input_element, value, custom_option);							    				
					} else {
						uvselect.addCardToMultiSelect(input_element, value, value);
					}					
					uvselect.placeSelectOptionContainer(id);
				} 
				input_element.attr('data-selected', selected); //No I18n

				//In case of custom option , there will be no options in native select , hence adding the selected option first before selecting it here
		    	if(uvselect[id].select.find("option[value='"+ value +"']").length < 1){
		    		var option = document.createElement('option');
		    		option.setAttribute("value", value);
		    		uvselect[id].select[0].appendChild(option);
		    		//uvselect[id].select
		    	}

				if(value) {
					var sel_val = (uvselect[id].select).val();
					if(sel_val.indexOf(value) == -1){
						sel_val.push(value);
					}
					(uvselect[id].select).val(sel_val).trigger('change', [true]);
					//(uvselect[id].select).val(selected).change();
					//$("select#"+r.attr("jsid")).val(selected).change();
				}
				return true;
			}			
		}
		return false;
	}

}


/*This method just calls the initialize method with the Obj of the select html element with which it is invoked.
*/
$.fn.uvselect = function(obj) {
	select_ele = this;
	select_ele.each(function(ind){
		uvselect.initialize($(select_ele[ind.toString()]),obj);	
	});
	return this;	
};
/*function ischaracter(obj){
	var reg = /^[A-Za-z]+$/;
	return reg.test(obj);
}
function isNumeric(obj){
	var reg = /^\d+$/;
	return reg.test(obj);
}*/
function getArrayFromObj(obj){
    var objArr = [];
    $(obj).each(function(index) {
    	objArr.push(this);
    });
    return objArr;
}