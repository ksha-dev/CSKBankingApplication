<%--$Id: $ --%>
<%@page import="com.zoho.resource.util.RESTConstants.HTTPHeader"%>
<%@ include file="includes.jsp" %>

<style>
.switch {
	position: relative;
	display: inline-block;
	width: 60px;
	height: 32px;
}

.switch input {
	opacity: 0;
	width: 0;
	height: 0;
}

.slider {
	position: absolute;
	cursor: pointer;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: #ccc;
	-webkit-transition: .4s;
	transition: .4s;
}

.slider:before {
	position: absolute;
	content: "";
	height: 26px;
	width: 26px;
	left: 4px;
	bottom: 4px;
	background-color: white;
	-webkit-transition: .4s;
	transition: .4s;
}

input:checked+.slider {
	background-color: #2196F3;
}

input:focus+.slider {
	box-shadow: 0 0 1px #2196F3;
}

input:checked+.slider:before {
	-webkit-transform: translateX(26px);
	-ms-transform: translateX(26px);
	transform: translateX(26px);
}

/* Rounded sliders */
.slider.round {
	border-radius: 34px;
}

.slider.round:before {
	border-radius: 50%;
}
.error-message {
    color: #f01919;
    font-weight: 200;
    padding: 5px;
    border: 1px solid #221f1f;
    background-color: #ffffff;
    display: none;
    margin-left: 330px;
    width: 200px;
}
</style>
<div class="maincontent">
    <div class="menucontent">
		<div class="topcontent"><div class="contitle">REST Operations</div></div>	<%--No I18N--%>
		<div class="subtitle">Do REST client operations like POST, GET, DELETE and PUT</div>	<%--No I18N--%>
    </div>
	<div class="field-bg">
		<form id="restform" method="post">
			<div class="labelmain">
			<div>
				<div class="labelkey">Request Method :</div>	<%--No I18N--%>
				<div class="labelvalue">
					<select name="method" onChange="changeRESTColor(this)">
						<option value="get">GET</option> <%--No I18N--%>
						<option value="post">POST</option>	<%--No I18N--%>
						<option value="put">PUT</option>	<%--No I18N--%>
						<option value="delete">DELETE</option>	<%--No I18N--%>
					</select>
				</div>
			</div>
			<div>
				<div class="labelkey">Enter Relative URI : </div>	<%--No I18N--%>
				<div class="labelvalue">
					<input type="text" size="100" name="uri" placeholder="eg: account/system" maxlength="500"/>
				</div>
			</div>
			<div>
				<div class="labelkey">Select Headers</div>	<%--No I18N--%>
				<div class="labelvalue" id='edipadd'>
					<div class='edipdiv' name='addheader'>
						<select class='select' name='header' style="width:350px;">
							<option value=''>Select Header</option> <%--No I18N--%>
							<%for(HTTPHeader head : HTTPHeader.values() ){ %>
								<option value='<%=head.getName() %>'><%=head %> </option>
							<%} %>
						</select>
						<input type="text" name="headervalue" placeholder="Header Value" maxlength="20"/>
						<span class='addEDicon hideicon chaceicon' onclick='addElement(this,3,3)'>&nbsp;</span>
					</div>
				</div>
			</div>
			<div>
				<div class="labelkey">Enter Attributes : </div>	<%--No I18N--%>
				<div class="labelvalue" id='edipadd'>
					<div class='edipdiv' name='addattribute'>
						<input type="text" name="attributename" placeholder="Attribute Name" value="" style="width:342px;"/>
						<input type="text" name="headervalue" placeholder="Attribute Value" maxlength="20"/>
						<span class='addEDicon hideicon chaceicon' onclick='addElement(this,3,3)'>&nbsp;</span>
					</div>
				</div>
			</div>
			<div class="labelkey">Comment :</div> <%--No I18N--%>
			<div>
				<textarea class="labelvalue" name="comment"  rows="4" cols="30"></textarea>
			</div>
			<div style="display:none;" id="jsonpassworddiv">
				<div class="labelkey">Enter Admin Password : </div>	<%--No I18N--%>
				<div class="labelvalue">
					<input type="password" autocomplete="off" name="password"/>
				</div>
			</div>
			<div style="display:none;" id="jsonbodydiv">
				<div class="labelkey">Body (In JSON) : </div>	<%--No I18N--%>
				<div class="labelvalue">
					<textarea style="font-size:10px;" name="body" rows="10" cols="50" placeholder="eg: {'account_name':'testaccount'}"></textarea>
				</div>
			</div>
			<div>
				<div class="labelkey"></div>
				<div class="labelvalue">
					<input type="button" id="submitbutton" value="Send" style="height:30px;width:70px;background-color:green" onclick="validateRESTInputs()"/>
				</div>
			</div>
			<div style="overflow:auto;">
				<div id="jsonresponsediv" style="display:none;" class="labelkey">Response (In JSON) : </div>	<%--No I18N--%>	
			</div>
			<div id="togglebuttondiv" style="overflow:auto;display:none;">
				<div class="labelkey">Show Raw Data</div> <%--No I18N--%>
				<label class="switch" id="togglebutton"><input type="checkbox" onclick="showRaworParsed()"> <span class="slider round"></span> </label>			
			</div>
			<div id="jsonresponsefinaldiv" >
				<div id="parsedjsonresponse" class="responselabelvalue" style = "position:relative;left:335px;top:7px; background-color: white; border:3px solid #878787;display:none; z-index: 1;">
					<div id="parsedresponse"  name="response" ></div>
				</div>
				<div id="rawjsonresponse" style="display:none;">	
					<textarea id="rawresponse" readonly style="margin-left: 335px;margin-top: 7px;font-size:10px;background-color:white" name="rresponse" rows="15" cols="70"></textarea>
				</div>
			</div>
			<div id="errordiv" class="error-message"></div>
		</form>
	</div>
</div>