<#if murph_data.isMurphyAllowed>

	<@resource path="/v2/components/tp_pkg/murphy.min.js" />

	<script type="text/javascript">
		murphy && murphy.install({
			config : {
				'appKey' : '${murph_data.murphyKey}',
				'appDomain' : '${murph_data.murphyDomain}',
				'environment' : 'production',
				'enableTracking' : ${murph_data.enableTracking?c},
				'authKey': '${murph_data.murphyAuthKey}'
			},
			setTags: function() {
				return {
				    'buildId' : '${murph_data.buildLabel}',
				    'zuid' : '${murph_data.zuid}'
				}
			}
		});

		var windowPath = window.location.pathname + window.location.hash

		function sendMurphyMsg(msg){
			murphy.error(new Error( windowPath + "_" + msg ));
		}
	</script>

</#if>