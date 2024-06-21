<%-- $Id$ --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="includes.jsp"%>
<div class="maincontent">
	<div class="menucontent">
		<div class="topcontent">
			<div class="contitle">View Emails By Domains</div><%--No I18N--%>
		</div>
		<div class="subtitle">Support Services</div><%--No I18N--%>
	</div>
	
	
	<div class="field-bg">
		<div id="getEmails" style="width:100%">
			<div id='inputform'>
				<form name="getdomain" class="zform" onsubmit="return getEmailsByDomain(this);">
					<div class="labelkey">Enter The Domain : </div><%--No I18N--%>
					<div class="labelvalue">
						<input type="text" class="input" name="domain" id="domain" placeholder='abc.com' value=''>
						<div style='margin-top:5px;'>(Emails are fetched from slave and query is costlier. So it takes time to load)</div><%--No I18N--%>
						<div style='margin-top:10px;' class="savebtn" onclick="getEmailsByDomain(document.getdomain);">
							<span class="btnlt"></span> 
							<span class="btnco">Fetch Emails</span><%--No I18N--%>
							<span class="btnrt"></span>
						</div>
					</div>
					<div class="subtitle"></div>
				</form>
			</div>			
		</div>
		
		<div id="showoutput" style="margin-top: 20px;">
			<div id="emailListDiv" style="display:none;">
				<div>
					<div style="text-align: right;">Count<input type="number" id="outcount" value="0" disabled="disabled" border="0" style="border: none;margin:0px 10px;width:120px;"></div><%--No I18N--%>
				</div>
				<div style="overflow: auto;width: calc(100% - (8% + .92*22% + 1px));position: absolute;height: calc(100% - 300px);margin-top: 8px;">
					<table style="margin:0px auto" class='usremailtbl' id='outputresult' border='1' cellpadding='4'>
						<tr style="position: sticky; z-index: 100; top: -1px;">
							<td class='usrinfoheader'>Email Address</td><%--No I18N--%>
							<td class='usrinfoheader'>ZUID</td><%--No I18N--%>
							<td class='usrinfoheader'>Is Primary</td><%--No I18N--%>
						</tr>
					</table>
				</div>
				<div style="text-align: right;width:calc(100% - (8% + .92*22% + 1px));top: calc(100% - 30px);position: fixed;"><a href="javascript:;" style="font-size:13px;margin-right:1%" id="loadmore">Load More >></a></div>  <%-- No I18N --%>
	 		</div>
	   		<div id="nouser" class="nosuchusr" style="display:none;">
	        	<p align="center">No Emails Found</p> <%--No I18N--%>
			</div>		
		</div>
		
		
	</div>
</div>