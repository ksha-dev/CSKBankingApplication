<!-- ---------- webAuthn open ---------- -->
<script>
var emptyField = '<@i18n key="IAM.ERROR.EMPTY.FIELD"/>';
var webkeyMaxLength = '<@i18n key="IAM.TFA.PASSKEY.NAME.MAX.LENGTH.ERROR"/>';
var passkeyNamePattern = '<@i18n key="IAM.PASSKEY.NAME.ERROR"/>';
var seckeyNamePattern = '<@i18n key="IAM.SECURKEY.NAME.ERROR"/>';
var webkeyRepeatedName = '<@i18n key="IAM.WEBAUTHN.ERROR.DUPLICATE.PASSKEY"/>';
var passkeyInvalidResp = '<@i18n key="IAM.WEBAUTHN.ERROR.PASSKEY.InvalidResponse"/>';
var webauthnInvalidResp = '<@i18n key="IAM.WEBAUTHN.ERROR.InvalidResponse"/>';
var passkeyRegisterError = '<@i18n key="IAM.WEBAUTHN.ERROR.PASSKEY.ErrorOccurred"/>';
var webauthnRegisterError = '<@i18n key="IAM.WEBAUTHN.ERROR.ErrorOccurred"/>';
var passkeyTypeError = '<@i18n key="IAM.PASSKEY.WEBAUTHN.TYPEERROR"/>';
var passkeySupport = '<@i18n key="IAM.PASSKEY.SUPPORT"/>';
//var passkeySupportURL = <#-- '${passkeyURL}'; -->
var webauthnNotAllowed = '<@i18n key="IAM.WEBAUTHN.ERROR.NotAllowedError"/>';
var passkeyInvalidState= '<@i18n key="IAM.WEBAUTHN.ERROR.PASSKEY.InvalidStateError"/>';
var webauthnInvalidState= '<@i18n key="IAM.WEBAUTHN.ERROR.InvalidStateError"/>';
var webauthnNoSupport= '<@i18n key="IAM.WEBAUTHN.ERROR.BrowserNotSupported"/>';
var generalError= '<@i18n key="IAM.ERROR.GENERAL"/>';
</script>
<@resource path="/v2/components/js/webauthn.js" attributes="defer" />
<@resource path="/v2/components/js/webAuthnRegister.js" attributes="defer" />
<!-- ---------- webAuthn close ---------- -->