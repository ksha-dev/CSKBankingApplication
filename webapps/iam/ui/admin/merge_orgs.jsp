<div class="maincontent">
    <div class="menucontent">
	<div class="topcontent"><div class="contitle" id="deletetitle">Merge ORG</div></div> <%--No I18N--%>
	<div class="subtitle">Admin Services</div> <%--No I18N--%>
    </div>
	
	<div id="getDetailsdiv">
<form name="fetchOrgdetail" id="fetchOrgdetail" class="zform" onsubmit="return fetchOrgdetails(this);" method="post">
	    <div class="labelmain">
                <div class="labelkey">Enter from Org ID :</div> <%--No I18N--%>
		<div class="labelvalue"><input type="text" name="fromOrgId" class="input" autocomplete="off"/></div>               
		 <div class="labelkey">Enter To Org Id :</div> <%--No I18N--%>
                <div class="labelvalue"><input type="text" class="input" name="toOrgId" autocomplete="off"/></div>
		<div class="accbtn Hbtn">
		    <div class="savebtn" onclick="fetchOrgdetails(document.fetchOrgdetail)">
			<span class="btnlt"></span>
			<span class="btnco">Fetch Details</span> <%--No I18N--%>
			<span class="btnrt"></span>
		    </div>
		</div>
		<input type="submit" class="hidesubmit" />
	    </div>
	</form>
</div>
<div id="showDetailsdiv" style="display: none;">
 <form name="mergeOrgdetailfrm" class="zform" method="post" onsubmit="return mergeOrgdetails(this);">
 <div class="labelmain">
               <div class="labelkey">From Org ID :</div> <%--No I18N--%>
		<div class="labelvalue"><input type="text" id="idsfromOrgId" name="fromOrgId" class="input noborder" disabled="disabled"/></div>               
		 <div class="labelkey">To Org Id :</div> <%--No I18N--%>
                <div class="labelvalue"><input type="text" id="idstoOrgId"  class="input noborder" name="toOrgId" disabled="disabled"/></div>
                <div class="labelkey">From Org Name :</div> <%--No I18N--%>
                <div class="labelvalue"><input type="text" id="idsfromorgName"  class="input noborder" name="fromorgName" disabled="disabled"/></div>
                <div class="labelkey">From Org Contact :</div> <%--No I18N--%>
                <div class="labelvalue"><input type="text" id="idsfromOrgContact" class="input noborder" name="fromOrgContact" disabled="disabled"/></div>
                <div class="labelkey">From Org Groups :</div> <%--No I18N--%>
                <div class="labelvalue"><input type="text" id="idsfromorggroup" class="input noborder" name="fromorggroup" disabled="disabled"/></div>
                <div class="labelkey">From Org Domains :</div> <%--No I18N--%>
                <div class="labelvalue"><input type="text" id="idsfromorgdomain" class="input noborder" name="fromorgdomain" disabled="disabled"/></div>
                <div class="labelkey">From Org Domains :</div> <%--No I18N--%>
                <div class="labelvalue"><input type="text" id="idsfromorgdomain" class="input noborder" name="fromorgdomain" disabled="disabled"/></div>
                
                <div class="labelkey">To Org Name :</div> <%--No I18N--%>
                <div class="labelvalue"><input type="text" id="idstoorgName" class="input noborder" name="toorgName" disabled="disabled"/></div>
                <div class="labelkey">To Org Contact :</div> <%--No I18N--%>
                <div class="labelvalue"><input type="text" id="idstoOrgContact" class="input noborder" name="toOrgContact" disabled="disabled" style="width: 50%;"/>
                </div>
                <div class="labelkey">Retain Org Role :</div> <%--No I18N--%>
                <div class="labelvalue"><input type="checkbox" id="idsisExposed" class="check" name="retailRole"/></div>
			<div class="labelkey" style="padding: 5px 5px 5px 0">DataLoss AppAccount  :</div> <%--No I18N--%>
	        <div class="labelvalue" id="idsdataLoss"><input type="text" class="input noborder" disabled="disabled"/></div>
 			<div class="idslossappaccs" style="display:none;"> 
		       	<div class="labelkey">Merge DataLoss AccountMembers :</div> <%--No I18N--%>
            	  <div class="labelvalue">
            	  	<div class="edipdiv" style="width: auto;">
		           	  	<select class="input"  onchange="checkOptionisSelected(this)" id="idslossappaccs" style="width: 270px;">
		           	  		<option value="">--Select DataLoss AppAccounts to merge--</option> <%--No I18N--%>
		           	  	</select>
		           	    <input type="text" class="input mergeapp" placeholder="ToOrg Zaaid" disabled/>
		           	    <span class="addEDicon hideicons chaceicon" onclick="addSubDiv(this)">&nbsp;</span>
		           	 </div>
           		</div>
	        </div>
	        <div class="labelkey">Mandatory AppAccount  :</div> <%--No I18N--%>
	        <div class="labelvalue"><input type="text" id="idsmantappacc" class="input noborder" name="mantLossappacc" disabled="disabled"/></div> <%--No I18N--%>
	        <div class="labelkey">Bundled Services  :</div> <%--No I18N--%>
	    	<div class="labelvalue"><input type="text" id="idsbundleservice" class="input noborder" disabled="disabled" style="color: red;"/></div> <%--No I18N--%>
	        <div class="labelkey">Paid Subscription Services  :</div> <%--No I18N--%>
	    	<div class="labelvalue"><input type="text" id="idspaidservice" class="input noborder" disabled="disabled" style="color: red;"/></div> <%--No I18N--%>
	        <div class="labelkey">Migrated to Org ServiceOrgs  :</div> <%--No I18N--%>
	        <div class="labelvalue"><input type="text" id="idsmigorgappacc" class="input noborder" name="migorgappacc" disabled="disabled"/><br> <div style="display:inline; font-size:11.5px; color:gray;"> --- If IP_RESTRICTION is enabled, user has to enable IP_RESTRICTION again in new org</div></div> <%--No I18N--%>
	        
	         <div class="labelkey">Admin Password :</div> <%--No I18N--%>
				<div class="labelvalue"><input type="password" id="adminpassid" name="aminpass" class="input" /></div>
		<div class="labelkey">Select Appaccounts to migrate :</div> <%--No I18N--%>
         <select name="subIds" id="idsappaccs" data-placeholder="Select AppAccounts to merge" style="width:350px;" class="chosen-mergeorg-admin-select labelvalue" multiple tabindex="6">
          
		</select>
		<div class="accbtn Hbtn">
		    <div class="savebtn" id="merge" onclick="mergeOrgdetails(document.mergeOrgdetailfrm)">
			<span class="btnlt"></span>
			<span class="btnco">Merge</span><%--No I18N--%>
			<span class="btnrt"></span>
		    </div>
		    <div onclick="loadui('/ui/admin/merge_orgs.jsp')">
			<span class="btnlt"></span>
			<span class="btnco">Cancel</span> <%--No I18N--%>
			<span class="btnrt"></span>
		    </div>
		</div>
		<input type="submit" class="hidesubmit" />
	    </div>
	</form>
</div>

<div id="resultDetailsdiv" style="display: none;">
 <div class="labelmain">
               <div class="labelkey">Users Migrated :</div> <%--No I18N--%>
		<div class="labelvalue"><input type="text" id="idsusrmig" name="usrmig" class="input" disabled="disabled"/></div>               
		 <div class="labelkey">AppAccount Migrated :</div> <%--No I18N--%>
                <div class="labelvalue"><input type="text" id="idsappaccmig"  class="input" name="appaccmig" disabled="disabled"/></div>
                <div class="labelkey">AppAccount Skiped :</div> <%--No I18N--%>
                <div class="labelvalue"><input type="text" id="idsappaccskp"  class="input" name="idsappaccskp" disabled="disabled"/></div>
                <div class="labelkey">Groups Migrated :</div> <%--No I18N--%>
                <div class="labelvalue"><input type="text" id="idsgrpmig" class="input" name="grpmig" disabled="disabled"/></div>
                <div class="labelkey">Domains Migrated :</div> <%--No I18N--%>
                <div class="labelvalue"><input type="text" id="idsdomainmig" class="input" name="domainmig" disabled="disabled"/></div>
                <div class="labelkey">AppAccount's Merged :</div> <%--No I18N--%>
                <div class="labelvalue"><input type="text" id="idsmergedmig" class="input" name="mergedmig" disabled="disabled"/></div>
		<div class="accbtn Hbtn">
		    <div onclick="loadui('/ui/admin/merge_orgs.jsp')">
			<span class="btnlt"></span>
			<span class="btnco">OK</span> <%--No I18N--%>
			<span class="btnrt"></span>
		    </div>
		</div>
		<input type="submit" class="hidesubmit" />
	    </div>
</div>
	
</div>
<script type="text/javascript">
function addSubDiv(e) {
    var ele = e.parentNode.parentNode;
	var remaining_options = [];
	var child_div = $(".edipdiv");
	for (var i = 0; i < child_div.length; i++) {
		var selectDiv = child_div[i].getElementsByTagName('select')[0];//No I18N
		var options = selectDiv.options;
		for (var j = 1; j < options.length; j++) {
			var opt = '<option value="' + options[j].value + '"> ' + options[j].text + ' </option>';
			if (!options[j].selected) {
				if(!remaining_options.includes(opt)) {
					remaining_options.push(opt);
				}
			} else if(remaining_options.includes(opt)) {
				remaining_options.pop(opt);
			}
		}
	}
	if(remaining_options.length == 0) {
		return;
	}
    var html = '<select class="input" onchange="checkOptionisSelected(this)" style="width: 270px;"><option value="">--Select DataLoss AppAccounts to merge--</option> '; //No I18N
   	for(var k = 0; k < remaining_options.length; k++) {
   		html += remaining_options[k];
   	}
   	html +='</select>';
    html += '<span>&nbsp;</span>'; // No I18N
    html += '<input type="text" class="input mergeapp" placeholder="ToOrg Zaaid" disabled/>';
    html += '<span>&nbsp;</span>'; // No I18N
    html += '<span class="removeEDicon hideicons" onclick="removeADIcon(this)">&nbsp;</span>'; //No I18N
    html += '<span>&nbsp;</span>'; // No I18N
    html += '<span class="addEDicon hideicons chaceicon" onclick="addSubDiv(this)">&nbsp;</span>';
    var div = document.createElement('div');
    div.innerHTML = html;
    div.className = 'edipdiv';
    ele.appendChild(div);
}

function checkOptionisSelected(event) {
	var selectedValue = event.value;
   	var id = event.id;
   	$(event).addClass("choosen");
   	var child_div = $(".edipdiv");
	for (var i = 0; i < child_div.length; i++) {
		var selectDiv = child_div[i].getElementsByTagName('select')[0];//No I18N
		if(selectDiv.className.split(" ").includes("choosen")) {
			continue;
		}
		var options = selectDiv.options;
		for (var j = 1; j < options.length; j++) {
			if (options[j].value == selectedValue && options[j].selected) {
				event.value = "";
				return;
			}
		}
	}

	if (selectedValue == '') {
		event.parentNode.querySelector(".mergeapp").value = ''; //No I18N
	} else {
		event.parentNode.querySelector(".mergeapp").value = selectedValue.split("|")[1]; //No I18N
	}
	$(event).removeClass("choosen");//No I18N
}
</script>