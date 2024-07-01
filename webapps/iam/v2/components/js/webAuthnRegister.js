//$Id$
function webAuthnRegister(params) {
  if (typeof params === "object" && Object.keys(params).length) {
    existingKeyNames = params.existingKeys && Array.isArray(existingKeys) ? params.existingKeys : undefined; //optional
    type = params.type; //mandatory
    requestor = params.requestor; //mandatory //either zresource object or requestwithcallback reference
    //args = params.args; //if zresource expected type Array else expected JSON
    isZresource = params.requestor && params.requestor.__zresource ? true : false;
    if (!isZresource) {
      url = params.url;
      wrapperkey = params.wrapperkey;
    }
  }
  var challengeJSON, credentialsJSON;
  var keyName;
  function isSecurityKeyNamePattern(val) {
    var pattern = /^[0-9a-zA-Z_\-\+\.\$@\,\:\'\!\[\]\|\u0080-\uFFFF\s]+$/;
    return pattern.test(val.trim());
  }
  function isRepeatedName(name) {
    if (Array.isArray(existingKeyNames) && existingKeyNames.length) {
      name = name.toUpperCase();
      for (n = 0; n < existingKeyNames.length; n++) {
        if (existingKeyNames[n].toUpperCase() == name) {
          return true;
        }
      }
      return false;
    }
  }
  function validateName(name, type) {
    if (name == null || name == "") {
      result = { errors: { code: "FEE"}, localized_message: emptyField }; //No I18N
    } else if (name.length > 50) {
      result = { errors: { code: "WKN999" }, localized_message: webkeyMaxLength }; //WebAuthn Key Name max length //No I18N
    } else if (!isSecurityKeyNamePattern(name)) {
      if (type === "passkey") {
        result = { errors: { code: "PKIN" }, localized_message: passkeyNamePattern }; //No I18N
      } else {
        result = { errors: { code: "YKIN" }, localized_message: seckeyNamePattern }; //No I18N
      }
    } else if (isRepeatedName(name)) {
      result = { errors: { code: "WKNRN" }, localized_message: webkeyRepeatedName }; //WebAuthn Key repeated name usage //No I18N
    } else {
      result = true;
    }
    return result;
  }

  function makeCredential(options) {
    var makeCredentialOptions = {};
    makeCredentialOptions.rp = options.rp;
    makeCredentialOptions.user = options.user;
    makeCredentialOptions.user.id = strToBin(options.user.id);
    makeCredentialOptions.challenge = strToBin(options.challenge);
    makeCredentialOptions.pubKeyCredParams = options.pubKeyCredParams;
    makeCredentialOptions.timeout = options.timeout;
    makeCredentialOptions.extensions = {};
    if ("extensions" in options) {
      if ("appidExclude" in options.extensions) {
        makeCredentialOptions.extensions.appidExclude = options.extensions.appidExclude;
      }
    }
    if ("excludeCredentials" in options) {
      makeCredentialOptions.excludeCredentials = credentialListConversion(options.excludeCredentials);
    }
    if ("authenticatorSelection" in options) {
      makeCredentialOptions.authenticatorSelection = options.authenticatorSelection;
    }
    if ("attestation" in options) {
      makeCredentialOptions.attestation = options.attestation;
    }
    return new Promise(function (resolve, reject) {
      navigator.credentials
        .create({
          publicKey: makeCredentialOptions
        })
        .then(function (attestation) {
          var publicKeyCredential = {};
          if ("id" in attestation) {
            publicKeyCredential.id = attestation.id;
          }
          if ("type" in attestation) {
            publicKeyCredential.type = attestation.type;
          }
          if ("rawId" in attestation) {
            publicKeyCredential.rawId = binToStr(attestation.rawId);
          }
          if (!attestation.response) {
            type == "passkey" ? reject(passkeyInvalidResp) : reject(webauthnInvalidResp); //No I18N
          }
          var response = {};
          response.clientDataJSON = binToStr(attestation.response.clientDataJSON);
          response.attestationObject = binToStr(attestation.response.attestationObject);
          if (attestation.response.getTransports) {
            response.transports = attestation.response.getTransports();
          }
          publicKeyCredential.response = response;
          if (type === "passkey") {
            credentialsJSON = publicKeyCredential;
            resolve(credentialsJSON);
          } else {
            credentialsJSON = publicKeyCredential;
            resolve(credentialsJSON);
          }
        })
        .catch(function (error) {
          if (error.name == "NotAllowedError") {
            reject(webauthnNotAllowed);
          } else if (error.name == "InvalidStateError") {
            type === "passkey" ? reject(passkeyInvalidState) : reject(webauthnInvalidState); //No I18N
          } else if (error.name == "NotSupportedError") {
            reject(webauthnNoSupport);
          } else if (error.name == "AbortError") {
            reject(webauthnNotAllowed);
          } else if (error.name == "TypeError") {
            reject(formatMessage(passkeyTypeError + " " + passkeySupport, passkeySupportURL)); //no i18n
          } else {
            type === "passkey" //No I18N
              ? reject(formatMessage(passkeyRegisterError, accountsSupportMail) + "<br>" + error.toString())
              : reject(formatMessage(webauthnRegisterError, accountsSupportMail) + "<br>" + error.toString());
          }
        });
    });
  }
  return {
    init: function (params) {
      return new Promise(function (resolve, reject) {
        payload = params.payload;
        if (type === "passkey") {
          if (typeof payload !== "object" || Array.isArray(payload) || payload == null || !payload.hasOwnProperty('name')) {
            reject("Passkey requires name on initialisation"); //No I18N
          }
          var vn = validateName(payload.name, type);
          if (vn != true) {
            reject(vn);
          }
          keyName = payload.name;
        }
        if (isZresource) {
          reqObj = requestor.create(payload);
          reqObj.POST.apply(reqObj, params.args).then(
            function (resp) {
              challengeJSON = resp[resp.resource_name][0];
              resolve(resp);
            },
            function (resp) {
              reject(resp);
            }
          );
        } else {
          requestor(url, payload, true, function (respStr) {
            try {
              var resp = JSON.parse(respStr);
              if (resp.status_code >= 200 && resp.status_code <= 299) {
                resolve(resp);
              }
            } catch (e) {
              reject(respStr || e);
            }
          });
        }
      });
    },
    makeCredential: function () {
      return makeCredential(challengeJSON);
    },
    register: function (params) {
      return new Promise(function (resolve, reject) {
        payload = params.payload;
        if (type == "yubikey" && params) {
          var vn = validateName(payload.name, type);
          if (vn != true) {
            reject(vn);
          }
        } else if (type == "passkey") { //No I18N
          payload.name = keyName;
        }
        var payload = {
          key_name: payload.name,
          id: credentialsJSON.id,
          rawId: credentialsJSON.rawId,
          response: credentialsJSON.response,
          type: credentialsJSON.type
        };
        if (isZresource) {
          var reqObj = requestor.create(payload);
          reqObj.PUT.apply(reqObj, params.args).then(
            function (resp) {
              resolve(resp);
            },
            function (resp) {
              reject(resp);
            }
          );
        } else {
          requestor(url, payload, true, function (respStr) {
            try {
              var resp = JSON.parse(respStr);
              if (resp.status_code >= 200 && resp.status_code <= 299) {
                resolve(resp);
              }
            } catch (e) {
              reject(respStr || e);
            }
          });
        }
      });
    }
  };
}
