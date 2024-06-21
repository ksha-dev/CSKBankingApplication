<html>
	<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/jquery-3.6.0.min.js")}" type="text/javascript"></script>
	<script>
		var response_obj = {
				"status" : "${status}",
				"idp_name" : "${provider_name}",
				"email" : "${Encoder.encodeJavaScript(email)}",
				"message" : "${Encoder.encodeJavaScript(message)}"
		}
		$( document ).ready(function() {
		    var parent = window.opener;
		    parent.link_account_response(response_obj);  
		    window.close();	
		});
	</script>
</html>