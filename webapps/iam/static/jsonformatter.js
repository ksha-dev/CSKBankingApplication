//$Id$ 
"use strict"; //No I18N
(() => {
  // src/lib/beforeAll.ts
  window.__jsonFormatterStartTime = performance.now();

  // src/style.css
  var style_default = ".responselabelvalue{\n  background-color: #fff;\n  user-select: text;\n  overflow-y: scroll !important;\n  margin: 0;\n  position: relative;\n  padding-top: 1px; /* hack to prevent margin collapse in 'Raw' */\n  font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto,\n    Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;\n}\n#optionBar {\n  user-select: none;\n  display: block;\n  position: absolute;\n  top: 13px;\n  right: 15px;\n}\n#buttonFormatted,\n#buttonPlain {\n  border-radius: 2px;\n  box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.1);\n  user-select: none;\n  background: linear-gradient(#fafafa, #f4f4f4 40%, #e5e5e5);\n  border: 1px solid #aaa;\n  color: #444;\n  font-size: 13px;\n  /* text-transform: uppercase; */\n  margin-bottom: 0px;\n  min-width: 4em;\n  padding: 3px 0;\n  position: relative;\n  z-index: 10;\n  display: inline-block;\n  width: 80px;\n  text-shadow: 1px 1px rgba(255, 255, 255, 0.3);\n}\n#buttonFormatted {\n  margin-left: 0;\n  border-top-left-radius: 0;\n  border-bottom-left-radius: 0;\n}\n#buttonPlain {\n  margin-right: 0;\n  border-top-right-radius: 0;\n  border-bottom-right-radius: 0;\n  border-right: none;\n}\n:is(#buttonPlain, #buttonFormatted):not(.selected):hover {\n  box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.2);\n  background: #ebebeb linear-gradient(#fefefe, #f8f8f8 40%, #e9e9e9);\n  border-color: #999;\n  color: #222;\n}\n:is(#buttonPlain, #buttonFormatted):active {\n  box-shadow: inset 0px 1px 3px rgba(0, 0, 0, 0.2);\n  background: #ebebeb linear-gradient(#f4f4f4, #efefef 40%, #dcdcdc);\n  color: #333;\n}\n:is(#buttonPlain, #buttonFormatted).selected {\n  box-shadow: inset 0px 1px 5px rgba(0, 0, 0, 0.2);\n  background: #ebebeb linear-gradient(#e4e4e4, #dfdfdf 40%, #dcdcdc);\n  color: #333;\n}\n:is(#buttonPlain, #buttonFormatted):focus {\n  outline: 0;\n}\n.entry {\n  display: block;\n  padding-left: 20px;\n  margin-left: -20px;\n  position: relative;\n}\n#jsonFormatterParsed {\n  padding-left: 28px;\n  padding-top: 6px;\n  line-height: 1.5;\n}\n#jsonFormatterRaw {\n  padding: 36px 10px 5px;\n}\n.collapsed {\n  white-space: nowrap;\n}\n.collapsed > .blockInner {\n  display: none;\n}\n.collapsed > .ell:after {\n  content: '\u2026';\n  font-weight: bold;\n}\n.collapsed > .ell {\n  margin: 0 4px;\n  color: #888;\n}\n.collapsed .entry {\n  display: inline;\n}\n\n.collapsed:after {\n  content: attr(data-size);\n  color: #aaa;\n}\n\n.e {\n  width: 20px;\n  height: 18px;\n  display: block;\n  position: absolute;\n  left: 0px;\n  top: 1px;\n  color: black;\n  z-index: 5;\n  background-repeat: no-repeat;\n  background-position: center center;\n  display: flex;\n  align-items: center;\n  justify-content: center;\n  opacity: 0.15;\n}\n\n.e::after {\n  content: '';\n  display: block;\n  width: 0;\n  height: 0;\n  border-style: solid;\n  border-width: 4px 0 4px 6.9px;\n  border-color: transparent transparent transparent currentColor;\n  transform: rotate(90deg) translateX(-0.7px) translateY(-3.7px);\n}\n\n.collapsed > .e::after {\n  transform: translateX(4px) translateY(-1.4px);\n}\n\n.e:hover {\n  opacity: 0.35;\n}\n.e:active {\n  opacity: 0.5;\n}\n.collapsed .entry .e {\n  display: none;\n}\n.blockInner {\n  display: block;\n  padding-left: 24px;\n  border-left: 1px dotted #bbb;\n  margin-left: 2px;\n}\n#jsonFormatterParsed {\n  color: #444;\n}\n\n.entry {\n  font-size: 13px;\n  font-family: monospace;\n}\n\n.b {\n  font-weight: bold;\n}\n.s {\n  color: #0b7500;\n  word-wrap: break-word;\n}\na:link,\na:visited {\n  text-decoration: none;\n  color: inherit;\n}\na:hover,\na:active {\n  text-decoration: underline;\n  color: #050;\n}\n.bl,\n.nl,\n.n {\n  font-weight: bold;\n  color: #1a01cc;\n}\n.k {\n  color: #000;\n}\n\n[hidden] {\n  display: none !important;\n}\nspan {\n  white-space: pre-wrap;\n}\n\n@keyframes spin {\n  from {\n    transform: rotate(0deg);\n  }\n  to {\n    transform: rotate(360deg);\n  }\n}\n\n#spinner {\n  animation: spin 2s linear infinite;\n}\n";

  // src/styleDark.css
  var styleDark_default = ".responselabelvalue{\n  background-color: #1a1a1a;\n  color: #eee;\n  -webkit-font-smoothing: antialiased;\n}\n\na:hover,\na:active {\n  color: hsl(114, 90%, 55%);\n}\n\n#optionBar {\n  -webkit-font-smoothing: subpixel-antialiased;\n}\n\n#jsonFormatterParsed {\n  color: #b6b6b6;\n}\n\n.blockInner {\n  border-color: #4d4d4d;\n}\n\n.k {\n  color: #fff;\n}\n\n.s {\n  color: hsl(114, 100%, 35%);\n}\n\n.bl,\n.nl,\n.n {\n  color: hsl(200, 100%, 70%);\n}\n\n.e {\n  color: #fff;\n  opacity: 0.25;\n}\n\n.e:hover {\n  opacity: 0.45;\n}\n.e:active {\n  opacity: 0.6;\n}\n\n.collapsed:after {\n  color: #707070;\n}\n\n:is(#buttonPlain, #buttonFormatted) {\n  text-shadow: none;\n  border: 0;\n  background: hsl(200, 35%, 60%);\n  box-shadow: none;\n  color: #000;\n}\n\n:is(#buttonPlain, #buttonFormatted):not(.selected):hover {\n  box-shadow: none;\n  background: hsl(200, 50%, 70%);\n  color: #000;\n}\n\n:is(#buttonPlain, #buttonFormatted).selected {\n  box-shadow: inset 0px 1px 5px rgba(0, 0, 0, 0.7);\n  background: hsl(200, 40%, 60%);\n  color: #000;\n}\n"; //No I18N

  // src/lib/constants.ts
  var TYPE_STRING = 1;
  var TYPE_NUMBER = 2;
  var TYPE_OBJECT = 3;
  var TYPE_ARRAY = 4;
  var TYPE_BOOL = 5;
  var TYPE_NULL = 6;

  // src/lib/assert.ts
  var prefix = "Runtime assertion failed";  //No I18N
  function assert(condition, message) {
    if (condition){
    	return;
    	}
    const providedMessage = typeof message === "function" ? message() : message;  //No I18N
    throw new Error(finalMessage);
  }

  // src/lib/getValueType.ts
  var getValueType = (value) => {
    if (typeof value === "string"){
      return TYPE_STRING;
    }
    if (typeof value === "number"){
      return TYPE_NUMBER;
    }
    if (value === false || value === true){
      return TYPE_BOOL;
    }
    if (value === null){
      return TYPE_NULL;
    }
    if (Array.isArray(value)){
      return TYPE_ARRAY;
    }
    return TYPE_OBJECT;
  };

  // src/lib/templates.ts
  var baseSpan = document.createElement("span");
  var createBlankSpan = () => baseSpan.cloneNode(false);
  var getSpanWithClass = (className) => {
    const span = createBlankSpan();
    span.className = className;
    return span;
  };
  var getSpanWithBoth = (innerText, className) => {
    const span = createBlankSpan();
    span.className = className;
    span.innerText = innerText;
    return span;
  };
  var templates = {
    t_entry: getSpanWithClass("entry"), //No I18N
    t_exp: getSpanWithClass("e"), //No I18N
    t_key: getSpanWithClass("k"), //No I18N
    t_string: getSpanWithClass("s"), //No I18N
    t_number: getSpanWithClass("n"), //No I18N
    t_null: getSpanWithBoth("null", "nl"), //No I18N
    t_true: getSpanWithBoth("true", "bl"), //No I18N
    t_false: getSpanWithBoth("false", "bl"), //No I18N
    t_oBrace: getSpanWithBoth("{", "b"),
    t_cBrace: getSpanWithBoth("}", "b"),
    t_oBracket: getSpanWithBoth("[", "b"),
    t_cBracket: getSpanWithBoth("]", "b"),
    t_sizeComment: getSpanWithClass("sizeComment"), //No I18N
    t_ellipsis: getSpanWithClass("ell"), //No I18N
    t_blockInner: getSpanWithClass("blockInner"), //No I18N
    t_colonAndSpace: document.createTextNode(":\xA0"), //No I18N
    t_commaText: document.createTextNode(","),
    t_dblqText: document.createTextNode('"')
  };

  // src/lib/buildDom.ts
  var buildDom = (value, keyName) => {
    const type = getValueType(value);
    const entry = templates.t_entry.cloneNode(false);
    let collectionSize = 0;
    if (type === TYPE_OBJECT) {
      collectionSize = Object.keys(value).length;
    } else if (type === TYPE_ARRAY) {
      collectionSize = value.length;
    }
    let nonZeroSize = false;
    if (type === TYPE_OBJECT || type === TYPE_ARRAY) {
      for (const objKey in value) {
        if (value.hasOwnProperty(objKey)) {
          nonZeroSize = true;
          break;
        }
      }
      if (nonZeroSize){
    	  entry.appendChild(templates.t_exp.cloneNode(false));
    	  }
    }
    if (keyName !== false) {
      entry.classList.add("objProp"); //No I18N
      const keySpan = templates.t_key.cloneNode(false);
      keySpan.textContent = JSON.stringify(keyName).slice(1, -1);
      entry.appendChild(templates.t_dblqText.cloneNode(false));
      entry.appendChild(keySpan);
      entry.appendChild(templates.t_dblqText.cloneNode(false));
      entry.appendChild(templates.t_colonAndSpace.cloneNode(false));
    } else {
      entry.classList.add("arrElem"); //No I18N
    }
    let blockInner;
    let childEntry;
    switch (type) {
      case TYPE_STRING: {
        assert(typeof value === "string"); //No I18N
        const innerStringEl = createBlankSpan();
        let escapedString = JSON.stringify(value);
        escapedString = escapedString.substring(1, escapedString.length - 1);
       
     
          innerStringEl.innerText = escapedString;
        
        const valueElement = templates.t_string.cloneNode(false);
        valueElement.appendChild(templates.t_dblqText.cloneNode(false));
        valueElement.appendChild(innerStringEl);
        valueElement.appendChild(templates.t_dblqText.cloneNode(false));
        entry.appendChild(valueElement);
        break;
      }
      case TYPE_NUMBER: {
        const valueElement = templates.t_number.cloneNode(
          false
        );
        valueElement.innerText = String(value);
        entry.appendChild(valueElement);
        break;
      }
      case TYPE_OBJECT: {
        assert(typeof value === "object"); //No I18N
        entry.appendChild(templates.t_oBrace.cloneNode(true));
        if (nonZeroSize) {
          entry.appendChild(templates.t_ellipsis.cloneNode(false));
          blockInner = templates.t_blockInner.cloneNode(false);
          let lastComma;
          for (let k in value) {
            if (value.hasOwnProperty(k)) {
              childEntry = buildDom(value[k], k);
              const comma = templates.t_commaText.cloneNode();
              childEntry.appendChild(comma);
              blockInner.appendChild(childEntry);
              lastComma = comma;
            }
          }
          assert(
            typeof childEntry !== "undefined" && typeof lastComma !== "undefined" //No I18N
          );
          childEntry.removeChild(lastComma);
          entry.appendChild(blockInner);
        }
        entry.appendChild(templates.t_cBrace.cloneNode(true));
        entry.dataset.size = ` // ${collectionSize} ${collectionSize === 1 ? "item" : "items"}`; //No I18N
        break;
      }
      case TYPE_ARRAY: {
        assert(Array.isArray(value));
        entry.appendChild(templates.t_oBracket.cloneNode(true));
        if (nonZeroSize) {
          entry.appendChild(templates.t_ellipsis.cloneNode(false));
          blockInner = templates.t_blockInner.cloneNode(false);
          for (let i = 0, length = value.length, lastIndex = length - 1; i < length; i++) {
            childEntry = buildDom(value[i], false);
            if (i < lastIndex) {
              const comma = templates.t_commaText.cloneNode();
              childEntry.appendChild(comma);
            }
            blockInner.appendChild(childEntry);
          }
          entry.appendChild(blockInner);
        }
        entry.appendChild(templates.t_cBracket.cloneNode(true));
        entry.dataset.size = ` // ${collectionSize} ${collectionSize === 1 ? "item" : "items"}`; //No I18N
        break;
      }
      case TYPE_BOOL: {
        if (value){
        	entry.appendChild(templates.t_true.cloneNode(true));
        	}
        else{
        	entry.appendChild(templates.t_false.cloneNode(true));
        }
        break;
      }
      case TYPE_NULL: {
        entry.appendChild(templates.t_null.cloneNode(true));
        break;
      }
    }
    return entry;
  };
  window.buildDom = buildDom;

  // src/content.ts
  var style = document.createElement('style');
  style.innerText =style_default;
  document.getElementsByTagName("head")[0].appendChild(style);
  
  //Event Listener for arrow click
  function setupArrowClick() {
	  const arrows = document.querySelectorAll('.e'); //No I18N

	  arrows.forEach(arrow => {
	    arrow.addEventListener('click', (event) => {
	      const correspondingEntry = event.srcElement.parentNode;
	      const isCollapsed = correspondingEntry.classList.contains('collapsed');//No I18N
	      if (isCollapsed) {
	        correspondingEntry.classList.remove('collapsed');//No I18N
	      } else {
	        correspondingEntry.classList.add('collapsed');//No I18N
	      }
	    });
	  });
	}
  window.setupArrowClick = setupArrowClick;	
  
})();

