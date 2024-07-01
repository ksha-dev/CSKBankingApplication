// $Id: $
(function (global, factory) {
  typeof exports === 'object' && typeof module !== 'undefined' ? module.exports = factory() : // No I18N
    typeof define === 'function' && define.amd ? define(factory) : // No I18N
      (global.ZSEC = factory());
}(this, (function () { 'use strict'; // No I18N

  /**
   * Polyfills
   */

  /**
   *
   * It's a wrapper over Object.defineProperty for setting  data descriptors for object .A data descriptor is a property that has a value, which sets isWritable,isConfigurable,isEnumerable for an object. By default all configuration values are false.
   *
   * Below function will define Object.defineProperty if not defined.
   * Normal property addition through assignment(=) creates properties.
   * But it shows up during property enumeration (for...in loop or Object.keys method), whose values may be changed or deleted.
   * And it may even create some unusual behaviour. The Object.defineProperty method allows
   * three extra details(configurable, writable, and enumerable) to be set for the value.
   * By default all the value are true. Since defineProperty is not supported
   * below IE-9 we have implemented fall back to directly assign value to the object
   *
   * @param   {Object} obj
   * @param   {string} property
   * @param   {value}  value
   * @param   {boolean}  isOverrideDefaultValue
   * @param   {boolean}  isWritable
   * @param   {boolean}  isConfigurable
   * @param   {boolean}  isEnumerable
   * @returns {Object}
   */
  /* eslint-disable-next-line max-params */
  function defineProperty(obj, property, value, isOverrideDefaultValue, isWritable, isConfigurable, isEnumerable) {
    if (!isOverrideDefaultValue && property in obj) {
      return;
    }
    if (!Object.defineProperty || !function () {
      try {
        Object.defineProperty({}, 'x', {}); // No I18N
        return true;
      } catch (e) {
        return false;
      }
    }()) {
      obj[property] = value;
      return obj;
    }

    isWritable = isWritable === true;
    isConfigurable = isConfigurable === true;
    isEnumerable = isEnumerable === true;
    return Object.defineProperty(obj, property, {
      value: value,
      writable: isWritable,
      configurable: isConfigurable,
      enumerable: isEnumerable
    });
  }

  /**
   * Defining String.prototype.codePointAt if not defined already
   * This is not supported in IE 11 and below
   */


  /**
   * Defining String.fromCodePoint if not defined already
   * Which is not supported in many browsers like IE ,Android ,Opera Mobile
   * */

  /**
   * @author: Patrick-2626 & Vigneshwar-5036
   *
   * @wiki: https://intranet.wiki.zoho.com/security/client-side-security.html
   *
   * Reference
   *  1)https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/
   *  2)https://github.com/danielstjules/blankshield
   */

  var ZSEC$1 = window && window.ZSEC ? window.ZSEC : { version: '5.4.0' };

  if (!ZSEC$1.defineProperty) {
    ZSEC$1.defineProperty = defineProperty;
  }

  if (!ZSEC$1['5.4.0']) {
    ZSEC$1['5.4.0'] = {
      version: '5.4.0',
      defineProperty: defineProperty
    };
  }

  /** @format */

  var APP_AGENT_CONF_PROMISE = null;
  var CSRF_DETAILS_PROMISE = null;
  var CSRF_PROP_NAME = "csrf"; // No I18N
  var CSRF_PARAM_PROP_NAME = "param_name"; // No I18N
  var CSRF_COOKIE_PROP_NAME = "cookie_name"; // No I18N
  var WAF_APP_AGENT_CONFIG_URL = "/waf/appAgentConf"; // No I18N

  /**
   * Load App Agent Conf, primarily used now for getting CSRF info
   * As of now, this call will not be made. We are only using this to get CSRF param and cookie names
   * which are currently set by user using setCSRF.
   * But it might be used for other purposes in the future, and we will mandate getting this info
   * through the /waf call. So keeping this implementation for now.
   *
   * Response will be like:
   *   {
   *     csrf: {
   *       param_name: "ac_p"
   *       cookie_name: "_ca"
   *     }
   *   }
   * @return {Promise<Response>}
   */
  function loadAppAgentConf() {

    if (APP_AGENT_CONF_PROMISE) {
      return APP_AGENT_CONF_PROMISE;
    }
    APP_AGENT_CONF_PROMISE = fetch(WAF_APP_AGENT_CONFIG_URL).catch(function (error) {
      throw Error("Error while fetching App Agent Conf: " + error); // No I18N
    });
    return APP_AGENT_CONF_PROMISE;
  }

  /**
   * Usage is like this:
   *    ZSEC.configuration.setCSRF({
   *      paramName: "_ca",
   *      cookieName: "ac_p"
   *    })
   * @param config
   */
  function setCSRF(config) {
    if (config.paramName && config.cookieName) {
      CSRF_DETAILS_PROMISE = Promise.resolve([config.paramName, config.cookieName]);
    }
  }

  function getCSRFDetails() {
    if (CSRF_DETAILS_PROMISE) {
      return CSRF_DETAILS_PROMISE;
    }
    CSRF_DETAILS_PROMISE = this.loadAppAgentConf().then(function (response) {
      return response.json().then(function (jsonResponse) {
        var csrfParamName = jsonResponse && jsonResponse[CSRF_PROP_NAME] && jsonResponse[CSRF_PROP_NAME][CSRF_PARAM_PROP_NAME];
        if (!csrfParamName) {
          throw Error("Invalid CSRF Param Name in Conf"); // No I18N
        }
        var csrfCookieName = jsonResponse && jsonResponse[CSRF_PROP_NAME] && jsonResponse[CSRF_PROP_NAME][CSRF_COOKIE_PROP_NAME];
        if (!csrfCookieName) {
          throw Error("Invalid CSRF Cookie Name in Conf"); // No I18N
        }
        return [csrfParamName, csrfCookieName];
      });
    });
    return CSRF_DETAILS_PROMISE;
  }

  function getCSRFName() {
    return getCSRFDetails().then(function (response) {
      return response[0];
    });
  }

  function getCSRFValue() {
    return getCSRFDetails().then(function (response) {
      return response[1];
    });
  }

  var configuration = {
    setCSRF: setCSRF,
    getCSRFName: getCSRFName,
    getCSRFValue: getCSRFValue,
    getCSRFDetails: getCSRFDetails,
    loadAppAgentConf: loadAppAgentConf
  };

  if (Object.freeze) {
    Object.freeze(configuration);
  }

  if (ZSEC$1.version === '5.4.0' && !ZSEC$1.configuration) {
    ZSEC$1.defineProperty(ZSEC$1, 'configuration', // No I18N
      configuration, true, false, false, true);
  }
  if (!ZSEC$1['5.4.0'].configuration) {
    ZSEC$1.defineProperty(ZSEC$1['5.4.0'], 'configuration', // No I18N
      configuration, true, false, false, true);
  }

  var _createClass = function () {
    function defineProperties(target, props) {
      for (var i = 0; i < props.length; i++) {
        var descriptor = props[i];
        descriptor.enumerable = descriptor.enumerable || false;
        descriptor.configurable = true;
        if ("value" in descriptor) { // No I18N
          descriptor.writable = true;
        }
        Object.defineProperty(target, descriptor.key, descriptor);
      }
    }
    return function (Constructor, protoProps, staticProps) {
      if (protoProps) {
        defineProperties(Constructor.prototype, protoProps);
      }
      if (staticProps) {
        defineProperties(Constructor, staticProps);
      }
      return Constructor;
    };
  }();

  function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } } // No I18N

  /** @format */

  var PayloadEncryptAgent = function () {
    function PayloadEncryptAgent() {
      _classCallCheck(this, PayloadEncryptAgent);

      this.keyEncryptionAlgorithm = "AES-GCM"; // No I18N
      this.keyLength = 256;
    }
    /**
     * Convert a Base64 String to Uint8Array
     * @param {String} base64string
     * @returns {Uint8Array}
     */


    _createClass(PayloadEncryptAgent, [{
      key: "base64ToUint8Array", // No I18N
      value: function base64ToUint8Array(base64string) {
        var binaryString = window.atob(base64string);
        var bytes = new Uint8Array(binaryString.length);
        for (var i = 0; i < binaryString.length; i++) {
          bytes[i] = binaryString.charCodeAt(i);
        }
        return bytes;
      }

      /**
       * Convert a Uint8Array to Base64 String
       * @param {Uint8Array} uint8array
       * @returns {String}
       */

    }, {
      key: "uint8ArrayToBase64", // No I18N
      value: function uint8ArrayToBase64(uint8array) {
        var binaryString = String.fromCharCode.apply(null, uint8array);
        return btoa(binaryString);
      }

      /**
       * Encrypt AESKeyIV with RSA PublicKey
       * @param {Uint8Array} aesKeyIV
       * @param {String} publicKey
       * @returns {Promise<String>}
       */

    }, {
      key: "encryptWithRSAPublicKey", // No I18N
      value: function encryptWithRSAPublicKey(aesKeyIV, publicKey) {
        var _this = this;

        return new Promise(function (resolve, reject) {
          var publicKeyBytes = _this.base64ToUint8Array(publicKey);
          // Import the public key
          crypto.subtle.importKey("spki", // No I18N
            publicKeyBytes.buffer, { name: "RSA-OAEP", hash: "SHA-256" }, // No I18N
            true, ["encrypt"]).then(function (key) {
            // Encrypt data using the public key
            _this.encryptData(aesKeyIV, key, { name: "RSA-OAEP" }) // No I18N
              .then(function (encryptedData) {
                resolve(encryptedData);
              }).catch(function (error) {
              reject("RSA Encryption error: " + error); // No I18N
            });
          }).catch(function (error) {
            reject("RSA Key import error: " + error); // No I18N
          });
        });
      }

      /**
       * Generate IV for AES-GCM
       * @returns {Uint8Array}
       */

    }, {
      key: "generateIV", // No I18N
      value: function generateIV() {
        return crypto.getRandomValues(new Uint8Array(12));
      }

      /**
       * Export AES key as Base64 String
       * @param {CryptoKey} key
       * @returns {Promise<Uint8Array>}
       */

    }, {
      key: "exportAESKey", // No I18N
      value: function exportAESKey(key) {
        return new Promise(function (resolve, reject) {
          crypto.subtle.exportKey("raw", key) // No I18N
            .then(function (exportedKey) {
              resolve(new Uint8Array(exportedKey));
            }).catch(function (error) {
            return reject(error);
          });
        });
      }

      /**
       * Generate an AES-256 key
       * @returns {Promise<CryptoKey>}
       */

    }, {
      key: "generateAESKey", // No I18N
      value: function generateAESKey() {
        var _this2 = this;

        return new Promise(function (resolve, reject) {
          crypto.subtle.generateKey({
            name: _this2.keyEncryptionAlgorithm,
            length: _this2.keyLength
          }, true, ["encrypt"]).then(function (key) {
            resolve(key);
          }).catch(function (error) {
            return reject(error);
          });
        });
      }

      /**
       *
       * @param {Uint8Array} dataBytes
       * @param {CryptoKey} key
       * @param {RsaOaepParams,AesGcmParams} algorithm
       * @return {Promise<String>}
       */

    }, {
      key: "encryptData", // No I18N
      value: function encryptData(dataBytes, key, algorithm) {
        var _this3 = this;

        return new Promise(function (resolve, reject) {
          crypto.subtle.encrypt(algorithm, key, dataBytes).then(function (encrypted) {
            encrypted = _this3.uint8ArrayToBase64(new Uint8Array(encrypted));
            resolve(encrypted);
          }).catch(function (error) {
            return reject(error);
          });
        });
      }

      /**
       * Encrypt the given payload using AES-GCM
       * @param {String} data
       * @param {String} publicKey
       * @return {Promise<Object>}
       */

    }, {
      key: "encrypt", // No I18N
      value: function encrypt(data, publicKey) {
        var _this4 = this;

        return new Promise(function (resolve, reject) {
          var dataBytes = new TextEncoder().encode(data);
          // Generate a key
          _this4.generateAESKey().then(function (key) {
            var IVBytes = _this4.generateIV();
            // Encrypt the payload using the key
            _this4.encryptData(dataBytes, key, { name: "AES-GCM", iv: IVBytes }) // No I18N
              .then(function (encryptedData) {
                // Export the used key
                _this4.exportAESKey(key).then(function (encryptionKeyBytes) {
                	if(encWithTimeStamp){
	                	var timestampString = Date.now().toString();
						var timestampBytes = new Uint8Array(timestampString.length);
						for (let i = 0; i < timestampString.length; i++) {
						    timestampBytes[i] = timestampString.charCodeAt(i);
						}
						var aesKeyIV = new Uint8Array(encryptionKeyBytes.length + IVBytes.length + timestampBytes.length);
						aesKeyIV.set(encryptionKeyBytes);
						aesKeyIV.set(IVBytes, encryptionKeyBytes.length);
						aesKeyIV.set(timestampBytes, encryptionKeyBytes.length + IVBytes.length)
	                }else{
	                  var aesKeyIV = new Uint8Array(encryptionKeyBytes.length + IVBytes.length);
	                  aesKeyIV.set(encryptionKeyBytes);
	                  aesKeyIV.set(IVBytes, encryptionKeyBytes.length);
                	}
                  // Encrypt the key with RSA Public Key
                  _this4.encryptWithRSAPublicKey(aesKeyIV, publicKey).then(function (encryptedKeyIV) {
                    // Return the encrypted key and the encrypted payload, separated by "#"
                    resolve({
                      key: encryptedKeyIV,
                      data: encryptedData
                    });
                  }).catch(function (error) {
                    reject(error);
                  });
                }).catch(function (error) {
                  reject("AES key export error: " + error); // No I18N
                });
              }).catch(function (error) {
              reject("AES Encryption error: " + error); // No I18N
            });
          }).catch(function (error) {
            reject("AES key generator error: " + error); // No I18N
          });
        });
      }
    }]);

    return PayloadEncryptAgent;
  }();

  /**
   * Custom Functions for Sanitizer
   **/















  /**
   * Cookie handling functions
   **/




  function getCookie(name) {
    name = name + '=';
    var cookieList = document.cookie;
    var res = void 0;
    cookieList.split('; ').forEach(function (cookie) {
      if (decodeURIComponent) {
        cookie = decodeURIComponent(cookie);
      }
      if (cookie.indexOf(name) === 0) {
        res = cookie.substring(name.length);
      }
    });
    return res;
  }



// Unused functions
//
// function setArray(arr1, arr2){
//   arr1.splice.apply(arr1,[0,arr1.length].concat(arr2));
// }
//
// function addObjsToSet(set, set2) {
//   for (let each in set2) {
//     if (set2.hasOwnProperty(each)) {
//       set[each] = true;
//     }
//   }
//   return set;
// };
//
// function removeFromSet(set, key) {
//   delete set[key];
//   return set;
// }
//
// /* Add all object keys to array */
// function addToArr(array, set) {
//   let property;
//   for (property in set) {
//     if (set.hasOwnProperty(property)) {
//       array.push(property);
//     }
//   }
//   return array;
// }
//
// /* Add flags to config */
// function addToConfig(set, array) {
//   let l = array.length;
//   while (l--) {
//     set[array[l]] = true;
//   }
//   return set;
// }

  function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

  /** @format */

  var DEFAULT_ENCRYPTION_CONFIG = {
    DELIMITER: "-" // No I18N
  };
  var SCOPES = {
    ORG: "org", // No I18N
    COMMON: "common" // No I18N
  };
  var ORG_PUBLIC_KEY_PROMISE = null;
  var COMMON_PUBLIC_KEY_PROMISE = null;
  var WAF_ENCRYPTION_PUBLIC_KEY_URL = "/waf/getPayloadEncryptionPublicKey"; // No I18N
  /** 
   * Encrypt the given payload using AES-GCM. publicKeyData contains the keyID, followed by version and
   * publicKey. All 3 are separated by the delimiter "-".
   * Response will be a string containing the following, separated by the same delimiter "-"
   *  keyID
   *  version
   *  encryptedKey
   *  encryptedData
   *
   * @param {String} data
   * @param {String} publicKeyData
   * @param {Object} config
   *
   * @return {Promise<String>}
   */

  function encrypt(data, publicKeyData) {
    var config = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : {};

    config = {
      delimiter: config.delimiter || DEFAULT_ENCRYPTION_CONFIG.DELIMITER
    };
    var publicKeyArray = publicKeyData.split(config.delimiter);
    var keyID = publicKeyArray[0];
    var version = publicKeyArray[1];
    var publicKey = publicKeyArray[2];
    var encryptAgent = new PayloadEncryptAgent();
    return encryptAgent.encrypt(data, publicKey).then(function (result) {
      return keyID + config.delimiter + version + config.delimiter + result.key + config.delimiter + result.data;
    }).catch(function (error) {
      throw Error("Error while encrypting data: " + error); // No I18N
    });
  }

  /**
   * Fetch the publicKeyData using Common scope and encrypt the given data
   *
   * @param {String} data
   * @param {Object} config
   *
   * @return {Promise<String>}
   */

  function encryptDataInCommonScope(data, config) {
    return getPublicKey(SCOPES.COMMON,data,config).then(function (publicKeyData) {
      return encrypt(data, publicKeyData, config);
    });
  }

  /**
   * Fetch the publicKeyData using Org scope and encrypt the given data
   *
   * @param {String} data
   * @param {Object} config
   *
   * @return {Promise<String>}
   */

  function encryptDataInOrgScope(data, config) {
    return getPublicKey(SCOPES.ORG).then(function (publicKeyData) {
      return encrypt(data, publicKeyData, config);
    });
  }

  /**
   * Fetch the publicKeyData using the given scope and encrypt the given data
   *
   * @param {String} data
   * @param {String} scope
   * @param {Object} config
   *
   * @return {Promise<String>}
   */

  function encryptData(data, scope, config) {
    scope = scope || SCOPES.COMMON;
    if (scope === SCOPES.ORG) {
      return encryptDataInOrgScope(data, config);
    } else if (scope === SCOPES.COMMON) {
      return encryptDataInCommonScope(data, config);
    } else {
      throw new Error("Unknown Scope"); // No I18N
    }
  }

  function getPublicKey(scope) {
	if(typeof payloadEncryptionPublicKey != 'undefined' && payloadEncryptionPublicKey){
		 if (scope === SCOPES.ORG) {
		     ORG_PUBLIC_KEY_PROMISE = payloadEncryptionPublicKey;
		 }
		 if (scope === SCOPES.COMMON) {
		    COMMON_PUBLIC_KEY_PROMISE = payloadEncryptionPublicKey;
		    }
		 return payloadEncryptionPublicKey;
	}
    if (scope === SCOPES.ORG && ORG_PUBLIC_KEY_PROMISE) {
      return ORG_PUBLIC_KEY_PROMISE;
    }
    if (scope === SCOPES.COMMON && COMMON_PUBLIC_KEY_PROMISE) {
      return COMMON_PUBLIC_KEY_PROMISE;
    }
    var PUBLIC_KEY_PROMISE = new Promise(function(resolve, reject) {
    	  configuration.getCSRFDetails().then(function(detail) {
    	    var csrfParamName = detail[0];
    	    var csrfValue = getCookie(detail[1]);
    	    var params = "scope=" + scope + "&" + csrfParamName + "=" + csrfValue; // No I18N
    	    var objHTTP = xhr();
    	    objHTTP.open('POST', accountsPublicKeyURL, true);
    	    objHTTP.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded;charset=UTF-8');
    	    objHTTP.setRequestHeader('X-ZCSRF-TOKEN', csrfParamName + '=' + csrfValue);
    	    objHTTP.onreadystatechange = function() {
    	      if (objHTTP.readyState == 4) {
    	        resolve(objHTTP.responseText.toString());
    	      }
    	    };
    	    objHTTP.send(params);
    	  }).catch(function(error) {
    	    reject(error); // Propagate any errors from configuration.getCSRFDetails()
    	  });
    	});
//    var PUBLIC_KEY_PROMISE = configuration.getCSRFDetails().then(function (detail) {
//      var csrfParamName = detail[0];
//      var csrfValue = getCookie(detail[1]);
//      var bodyParams = _defineProperty({
//        scope: scope
//      }, csrfParamName, csrfValue);
//      var formData = new FormData();
//      for (var key in bodyParams) {
//        formData.append(key, bodyParams[key]);
//      }
//      var params = "scope="+scope+ "&" +csrfParamName +"="+ csrfValue; // No I18N
//      var objHTTP = xhr();
//      objHTTP.open('POST', accountsPublicKeyURL, true);
//      objHTTP.setRequestHeader('Content-Type','application/x-www-form-urlencoded;charset=UTF-8');
//      objHTTP.setRequestHeader('X-ZCSRF-TOKEN',csrfParamName+'='+csrfValue);
//	  objHTTP.onreadystatechange=function() {
//		if(objHTTP.readyState==4) {
//			return objHTTP.responseText.toString();
//		}
//      }
//      objHTTP.send(params);
//      return fetch(accountsPublicKeyURL, {
//        method: "POST", // No I18N
//        body: formData
//      }).then(function (response) {
//        return response.text();
//      });
//    });
    if (scope === SCOPES.ORG) {
      ORG_PUBLIC_KEY_PROMISE = PUBLIC_KEY_PROMISE;
    }
    if (scope === SCOPES.COMMON) {
      COMMON_PUBLIC_KEY_PROMISE = PUBLIC_KEY_PROMISE;
    }
    return PUBLIC_KEY_PROMISE;
  }

  var Encryption = {
    SCOPES: SCOPES,
    encryptData: encryptData,
    encryptDataInOrgScope: encryptDataInOrgScope,
    encryptDataInCommonScope: encryptDataInCommonScope
  };

  if (Object.freeze) {
    Object.freeze(Encryption);
  }

  if (ZSEC$1.version === '5.4.0' && !ZSEC$1.Encryption) {
    ZSEC$1.defineProperty(ZSEC$1, 'Encryption', // No I18N
      Encryption, true, false, false, true);
  }
  if (!ZSEC$1['5.4.0'].Encryption) {
    ZSEC$1.defineProperty(ZSEC$1['5.4.0'], 'Encryption', // No I18N
      Encryption, true, false, false, true);
  }

  return ZSEC$1;

})));


/*
  Usage:

  // Need to configure CSRF param name and cookie name to fetch the public key from WAF Agent
  ZSEC.configuration.setCSRF({
      paramName: "_pppp",
      cookieName: "_cccc"
  });

  // This will return a promise that fulfills to the following string format
  ZSEC.Encryption.encryptData("sampleData").then(response => {
    console.log(response); // <KeyID>-<Version>-<EncryptedKey>-<EncryptedData>
  });

 */