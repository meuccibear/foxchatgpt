(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["pages-wxapp-cosplay"],{"1da1":function(t,e,n){"use strict";function r(t,e,n,r,a,i,o){try{var s=t[i](o),c=s.value}catch(u){return void n(u)}s.done?e(c):Promise.resolve(c).then(r,a)}n("7a82"),Object.defineProperty(e,"__esModule",{value:!0}),e.default=function(t){return function(){var e=this,n=arguments;return new Promise((function(a,i){var o=t.apply(e,n);function s(t){r(o,a,i,s,c,"next",t)}function c(t){r(o,a,i,s,c,"throw",t)}s(void 0)}))}},n("d3b7")},"7a6b":function(t,e,n){"use strict";n.r(e);var r=n("ca54"),a=n.n(r);for(var i in r)["default"].indexOf(i)<0&&function(t){n.d(e,t,(function(){return r[t]}))}(i);e["default"]=a.a},"8a79":function(t,e,n){"use strict";var r=n("23e7"),a=n("4625"),i=n("06cf").f,o=n("50c4"),s=n("577e"),c=n("5a34"),u=n("1d80"),l=n("ab13"),d=n("c430"),f=a("".endsWith),h=a("".slice),g=Math.min,p=l("endsWith"),v=!d&&!p&&!!function(){var t=i(String.prototype,"endsWith");return t&&!t.writable}();r({target:"String",proto:!0,forced:!v&&!p},{endsWith:function(t){var e=s(u(this));c(t);var n=arguments.length>1?arguments[1]:void 0,r=e.length,a=void 0===n?r:g(o(n),r),i=s(t);return f?f(e,i,a):h(e,a-i.length,a)===i}})},a81d:function(t,e,n){var r=n("f893");r.__esModule&&(r=r.default),"string"===typeof r&&(r=[[t.i,r,""]]),r.locals&&(t.exports=r.locals);var a=n("4f06").default;a("9bd61a44",r,!0,{sourceMap:!1,shadowMode:!1})},b636:function(t,e,n){var r=n("e065");r("asyncIterator")},c7eb:function(t,e,n){"use strict";Object.defineProperty(e,"__esModule",{value:!0}),e.default=function(){
/*! regenerator-runtime -- Copyright (c) 2014-present, Facebook, Inc. -- license (MIT): https://github.com/facebook/regenerator/blob/main/LICENSE */
e.default=function(){return t};var t={},n=Object.prototype,a=n.hasOwnProperty,i=Object.defineProperty||function(t,e,n){t[e]=n.value},o="function"==typeof Symbol?Symbol:{},s=o.iterator||"@@iterator",c=o.asyncIterator||"@@asyncIterator",u=o.toStringTag||"@@toStringTag";function l(t,e,n){return Object.defineProperty(t,e,{value:n,enumerable:!0,configurable:!0,writable:!0}),t[e]}try{l({},"")}catch(j){l=function(t,e,n){return t[e]=n}}function d(t,e,n,r){var a=e&&e.prototype instanceof g?e:g,o=Object.create(a.prototype),s=new O(r||[]);return i(o,"_invoke",{value:_(t,n,s)}),o}function f(t,e,n){try{return{type:"normal",arg:t.call(e,n)}}catch(j){return{type:"throw",arg:j}}}t.wrap=d;var h={};function g(){}function p(){}function v(){}var b={};l(b,s,(function(){return this}));var m=Object.getPrototypeOf,y=m&&m(m(C([])));y&&y!==n&&a.call(y,s)&&(b=y);var w=v.prototype=g.prototype=Object.create(b);function x(t){["next","throw","return"].forEach((function(e){l(t,e,(function(t){return this._invoke(e,t)}))}))}function k(t,e){var n;i(this,"_invoke",{value:function(i,o){function s(){return new e((function(n,s){(function n(i,o,s,c){var u=f(t[i],t,o);if("throw"!==u.type){var l=u.arg,d=l.value;return d&&"object"==(0,r.default)(d)&&a.call(d,"__await")?e.resolve(d.__await).then((function(t){n("next",t,s,c)}),(function(t){n("throw",t,s,c)})):e.resolve(d).then((function(t){l.value=t,s(l)}),(function(t){return n("throw",t,s,c)}))}c(u.arg)})(i,o,n,s)}))}return n=n?n.then(s,s):s()}})}function _(t,e,n){var r="suspendedStart";return function(a,i){if("executing"===r)throw new Error("Generator is already running");if("completed"===r){if("throw"===a)throw i;return S()}for(n.method=a,n.arg=i;;){var o=n.delegate;if(o){var s=T(o,n);if(s){if(s===h)continue;return s}}if("next"===n.method)n.sent=n._sent=n.arg;else if("throw"===n.method){if("suspendedStart"===r)throw r="completed",n.arg;n.dispatchException(n.arg)}else"return"===n.method&&n.abrupt("return",n.arg);r="executing";var c=f(t,e,n);if("normal"===c.type){if(r=n.done?"completed":"suspendedYield",c.arg===h)continue;return{value:c.arg,done:n.done}}"throw"===c.type&&(r="completed",n.method="throw",n.arg=c.arg)}}}function T(t,e){var n=e.method,r=t.iterator[n];if(void 0===r)return e.delegate=null,"throw"===n&&t.iterator["return"]&&(e.method="return",e.arg=void 0,T(t,e),"throw"===e.method)||"return"!==n&&(e.method="throw",e.arg=new TypeError("The iterator does not provide a '"+n+"' method")),h;var a=f(r,t.iterator,e.arg);if("throw"===a.type)return e.method="throw",e.arg=a.arg,e.delegate=null,h;var i=a.arg;return i?i.done?(e[t.resultName]=i.value,e.next=t.nextLoc,"return"!==e.method&&(e.method="next",e.arg=void 0),e.delegate=null,h):i:(e.method="throw",e.arg=new TypeError("iterator result is not an object"),e.delegate=null,h)}function L(t){var e={tryLoc:t[0]};1 in t&&(e.catchLoc=t[1]),2 in t&&(e.finallyLoc=t[2],e.afterLoc=t[3]),this.tryEntries.push(e)}function E(t){var e=t.completion||{};e.type="normal",delete e.arg,t.completion=e}function O(t){this.tryEntries=[{tryLoc:"root"}],t.forEach(L,this),this.reset(!0)}function C(t){if(t){var e=t[s];if(e)return e.call(t);if("function"==typeof t.next)return t;if(!isNaN(t.length)){var n=-1,r=function e(){for(;++n<t.length;)if(a.call(t,n))return e.value=t[n],e.done=!1,e;return e.value=void 0,e.done=!0,e};return r.next=r}}return{next:S}}function S(){return{value:void 0,done:!0}}return p.prototype=v,i(w,"constructor",{value:v,configurable:!0}),i(v,"constructor",{value:p,configurable:!0}),p.displayName=l(v,u,"GeneratorFunction"),t.isGeneratorFunction=function(t){var e="function"==typeof t&&t.constructor;return!!e&&(e===p||"GeneratorFunction"===(e.displayName||e.name))},t.mark=function(t){return Object.setPrototypeOf?Object.setPrototypeOf(t,v):(t.__proto__=v,l(t,u,"GeneratorFunction")),t.prototype=Object.create(w),t},t.awrap=function(t){return{__await:t}},x(k.prototype),l(k.prototype,c,(function(){return this})),t.AsyncIterator=k,t.async=function(e,n,r,a,i){void 0===i&&(i=Promise);var o=new k(d(e,n,r,a),i);return t.isGeneratorFunction(n)?o:o.next().then((function(t){return t.done?t.value:o.next()}))},x(w),l(w,u,"Generator"),l(w,s,(function(){return this})),l(w,"toString",(function(){return"[object Generator]"})),t.keys=function(t){var e=Object(t),n=[];for(var r in e)n.push(r);return n.reverse(),function t(){for(;n.length;){var r=n.pop();if(r in e)return t.value=r,t.done=!1,t}return t.done=!0,t}},t.values=C,O.prototype={constructor:O,reset:function(t){if(this.prev=0,this.next=0,this.sent=this._sent=void 0,this.done=!1,this.delegate=null,this.method="next",this.arg=void 0,this.tryEntries.forEach(E),!t)for(var e in this)"t"===e.charAt(0)&&a.call(this,e)&&!isNaN(+e.slice(1))&&(this[e]=void 0)},stop:function(){this.done=!0;var t=this.tryEntries[0].completion;if("throw"===t.type)throw t.arg;return this.rval},dispatchException:function(t){if(this.done)throw t;var e=this;function n(n,r){return o.type="throw",o.arg=t,e.next=n,r&&(e.method="next",e.arg=void 0),!!r}for(var r=this.tryEntries.length-1;r>=0;--r){var i=this.tryEntries[r],o=i.completion;if("root"===i.tryLoc)return n("end");if(i.tryLoc<=this.prev){var s=a.call(i,"catchLoc"),c=a.call(i,"finallyLoc");if(s&&c){if(this.prev<i.catchLoc)return n(i.catchLoc,!0);if(this.prev<i.finallyLoc)return n(i.finallyLoc)}else if(s){if(this.prev<i.catchLoc)return n(i.catchLoc,!0)}else{if(!c)throw new Error("try statement without catch or finally");if(this.prev<i.finallyLoc)return n(i.finallyLoc)}}}},abrupt:function(t,e){for(var n=this.tryEntries.length-1;n>=0;--n){var r=this.tryEntries[n];if(r.tryLoc<=this.prev&&a.call(r,"finallyLoc")&&this.prev<r.finallyLoc){var i=r;break}}i&&("break"===t||"continue"===t)&&i.tryLoc<=e&&e<=i.finallyLoc&&(i=null);var o=i?i.completion:{};return o.type=t,o.arg=e,i?(this.method="next",this.next=i.finallyLoc,h):this.complete(o)},complete:function(t,e){if("throw"===t.type)throw t.arg;return"break"===t.type||"continue"===t.type?this.next=t.arg:"return"===t.type?(this.rval=this.arg=t.arg,this.method="return",this.next="end"):"normal"===t.type&&e&&(this.next=e),h},finish:function(t){for(var e=this.tryEntries.length-1;e>=0;--e){var n=this.tryEntries[e];if(n.finallyLoc===t)return this.complete(n.completion,n.afterLoc),E(n),h}},catch:function(t){for(var e=this.tryEntries.length-1;e>=0;--e){var n=this.tryEntries[e];if(n.tryLoc===t){var r=n.completion;if("throw"===r.type){var a=r.arg;E(n)}return a}}throw new Error("illegal catch attempt")},delegateYield:function(t,e,n){return this.delegate={iterator:C(t),resultName:e,nextLoc:n},"next"===this.method&&(this.arg=void 0),h}},t},n("7a82"),n("a4d3"),n("e01a"),n("d3b7"),n("d28b"),n("3ca3"),n("ddb0"),n("b636"),n("944a"),n("0c47"),n("23dc"),n("3410"),n("d9e2"),n("d401"),n("14d9"),n("159b"),n("131a"),n("26e9"),n("fb6a");var r=function(t){return t&&t.__esModule?t:{default:t}}(n("53ca"))},ca54:function(t,e,n){"use strict";n("7a82");var r=n("4ea4").default;Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0;var a=r(n("c7eb")),i=r(n("1da1"));n("ac1f"),n("5319"),n("498a"),n("14d9"),n("d3b7"),n("e9c4"),n("8a79"),n("c975"),n("e25e");var o=r(n("44fb"));n("fd1e8"),n("279a"),n("a7eb"),n("40d3");var s=getApp(),c=[],u=0,l={components:{TextComponent:o.default},data:function(){return{pageIsLoad:!1,siteroot:"",lists:[],message:"",writingText:"",writing:!1,page:1,pagesize:10,scrollTop:0,role:{},role_id:0,inputShow:!0}},onLoad:function(t){var e=this;t.role_id&&this.setData({role_id:t.role_id}),this.setData({system:s.globalData.system,siteroot:s.globalData.siteroot.replace("/web.php","")}),s.globalData.util.checkLogin().then((function(){e.getRole(),e.getHistoryMsg(),e.setData({pageIsLoad:!0})}))},methods:{sendText:function(){var t=this;return(0,i.default)((0,a.default)().mark((function e(){var n,r,i,o,l,d,f,h,g,p,v,b,m,y,w;return(0,a.default)().wrap((function(e){while(1)switch(e.prev=e.next){case 0:if(!t.writing){e.next=2;break}return e.abrupt("return");case 2:if(n=t.trim(t.message),n){e.next=12;break}if(!t.role.hint){e.next=9;break}t.message=t.role.hint,n=t.message,e.next=12;break;case 9:return s.globalData.util.message("请输入你的问题"),t.message="",e.abrupt("return");case 12:return u&&(clearInterval(u),u=0,c=[]),t.lists.push({user:"我",message:n}),t.message="",t.writing=!0,t.scrollToBottom(),r=new Headers,r.append("Content-Type","application/json"),r.append("X-site",uni.getStorageSync("sitecode")),i=t.siteroot+"/web.php/chat/sendText",o={role_id:t.role_id,message:n},e.next=24,fetch(i,{method:"POST",headers:r,body:JSON.stringify(o)});case 24:if(l=e.sent,l.ok){e.next=29;break}return t.writing=!1,s.globalData.util.message(l.statusText),e.abrupt("return");case 29:d=l.body.getReader(),f=new TextDecoder("utf-8"),h=!1,g="",u=setInterval((function(){c.length>0?(t.writingText+=c.shift(),t.scrollToBottom()):t.writing||(clearInterval(u),u=0,t.writingText&&t.lists.push({user:"AI",message:t.writingText}),t.writingText="",setTimeout((function(){t.scrollToBottom()}),200))}),50);case 34:if(h){e.next=55;break}return t.scrollToBottom(),e.next=38,d.read();case 38:if(p=e.sent,v=p.value,b=p.done,!v){e.next=52;break}if(m=f.decode(v),"\n"!==m||!g.endsWith("\n")){e.next=45;break}return e.abrupt("continue",34);case 45:if(!m){e.next=52;break}if(-1===m.indexOf("[error]")){e.next=50;break}if(y=function(){t.writing=!1,t.writingText="",t.lists.pop();var e=m.replace("[error]","");return-1!==e.indexOf("请登录")?(t.$emit("showlogin"),setTimeout((function(){s.globalData.util.message(e)}),500)):-1!==e.indexOf("请充值")?(t.$emit("showUserInfo"),setTimeout((function(){s.globalData.util.message(e)}),500)):s.globalData.util.message(e,"error"),"break"}(),"break"!==y){e.next=50;break}return e.abrupt("break",55);case 50:for(t.writing=!0,w=0;w<m.length;w++)c.push(m[w]);case 52:h=b,e.next=34;break;case 55:t.writing=!1;case 56:case"end":return e.stop()}}),e)})))()},sendConfirm:function(){var t=this;setTimeout((function(){t.sendText()}),50)},getHistoryMsg:function(){var t=this;s.globalData.util.request({url:"/cosplay/getHistoryMsg",data:{role_id:this.role_id,page:this.page,pagesize:this.pagesize}}).then((function(e){e.data.length>0&&t.setData({lists:e.data}),setTimeout((function(){t.scrollToBottom()}),300)}))},getRole:function(){var t=this;s.globalData.util.request({url:"/cosplay/getRole",data:{role_id:this.role_id}}).then((function(e){t.setData({role:e.data}),document.title=e.data.title}))},scrollToBottom:function(){var t=this;setTimeout((function(){var e=uni.createSelectorQuery().in(t);e.select(".list").boundingClientRect((function(e){t.setData({scrollTop:parseInt(e.height)})})),e.exec((function(t){}))}),200)},copyText:function(t){var e=document.createElement("textarea");e.value=t,e.readOnly="readOnly",e.style="width:0;height:0;",document.body.appendChild(e),e.select(),e.setSelectionRange(0,t.length),s.globalData.util.message("已复制"),document.execCommand("copy"),e.remove()},trim:function(t){return t?t.replace(/(^\s*)|(\s*$)/g,""):""}}};e.default=l},cb13:function(t,e,n){"use strict";n.r(e);var r=n("f61c1"),a=n("7a6b");for(var i in a)["default"].indexOf(i)<0&&function(t){n.d(e,t,(function(){return a[t]}))}(i);n("e9cb");var o=n("f0c5"),s=Object(o["a"])(a["default"],r["b"],r["c"],!1,null,"971d73c0",null,!1,r["a"],void 0);e["default"]=s.exports},e9cb:function(t,e,n){"use strict";var r=n("a81d"),a=n.n(r);a.a},f61c1:function(t,e,n){"use strict";n.d(e,"b",(function(){return r})),n.d(e,"c",(function(){return a})),n.d(e,"a",(function(){}));var r=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("v-uni-view",{staticStyle:{height:"100%"}},[t.pageIsLoad?n("v-uni-view",{staticClass:"page"},[t.lists&&t.lists.length>0?n("v-uni-scroll-view",{staticClass:"box-msg-list",style:"bottom: "+(t.inputShow?"316rpx":"102rpx")+";",attrs:{"scroll-x":!1,"scroll-y":!0,"scroll-with-animation":!1,"scroll-top":t.scrollTop}},[n("v-uni-view",{staticClass:"list"},[t._l(t.lists,(function(e,r){return["AI"==e.user?n("v-uni-view",{key:r+"_0",staticClass:"message",staticStyle:{background:"#f7f7f8"},attrs:{"data-index":r}},[n("v-uni-view",{staticClass:"avatar"},[n("img",{attrs:{mode:"widthFix",src:"/static/img/ic_ai.png"}})]),n("v-uni-view",{staticClass:"text markdown-body"},[n("textComponent",{attrs:{text:e.message}}),n("v-uni-view",{staticStyle:{display:"block"}},[n("span",{staticClass:"btn-copy",on:{click:function(n){arguments[0]=n=t.$handleEvent(n),t.copyText(e.message)}}},[t._v("复制内容")])])],1)],1):n("v-uni-view",{staticClass:"message",staticStyle:{background:"#fff"},attrs:{"data-index":r},on:{longpress:function(n){arguments[0]=n=t.$handleEvent(n),t.copyText(e.message)}}},[n("v-uni-view",{staticClass:"avatar",staticStyle:{background:"#9aa37e"}},[n("img",{attrs:{mode:"widthFix",src:"/static/img/ic_user.png"}})]),n("v-uni-view",{staticClass:"text markdown-body"},[n("textComponent",{attrs:{text:e.message}})],1)],1)]})),t.writing||t.writingText?n("v-uni-view",{staticClass:"message",staticStyle:{background:"#f7f7f8"}},[n("v-uni-view",{staticClass:"avatar"},[n("img",{attrs:{src:"/static/img/ic_ai.png"}})]),n("v-uni-view",{staticClass:"text markdown-body"},[n("textComponent",{attrs:{text:t.writingText,writing:!(!t.writing&&!t.writingText)}})],1)],1):t._e()],2)],1):t._e(),n("v-uni-view",{staticClass:"box-input"},[n("v-uni-view",{staticClass:"input"},[n("v-uni-textarea",{attrs:{type:"text","confirm-type":"send","auto-height":!0,placeholder:t.role.hint||"输入你的问题",maxlength:"3000","cursor-spacing":"0"},on:{confirm:function(e){arguments[0]=e=t.$handleEvent(e),t.sendConfirm.apply(void 0,arguments)}},model:{value:t.message,callback:function(e){t.message=e},expression:"message"}}),n("v-uni-button",{staticClass:"btn-send",on:{click:function(e){arguments[0]=e=t.$handleEvent(e),t.sendText.apply(void 0,arguments)}}},[n("v-uni-image",{attrs:{mode:"widthFix",src:"/static/images/ic_send.png"}})],1)],1)],1)],1):t._e()],1)},a=[]},f893:function(t,e,n){var r=n("24fb");e=r(!1),e.push([t.i,"uni-page-body[data-v-971d73c0]{background:#f7f7f7}body.?%PAGE?%[data-v-971d73c0]{background:#f7f7f7}.box-input[data-v-971d73c0]{width:100%;padding:%?40?% 0;left:0;bottom:0;border-top:1px solid #d8d8e2;background:#f6f9fc}.box-input .input[data-v-971d73c0]{width:%?690?%;margin:0 %?30?%;position:relative;box-sizing:border-box;box-shadow:0 0 %?12?% rgba(0,0,0,.1);background:#fefefe}.box-input .input uni-textarea[data-v-971d73c0]{width:%?580?%;padding:%?20?% %?10?% %?20?% %?20?%;border-radius:%?10?%;line-height:%?40?%;max-height:%?800?%;overflow-x:hidden;overflow-y:auto}.box-input .input .btn-send[data-v-971d73c0]{position:absolute;right:0;bottom:0;width:%?100?%;height:%?80?%;padding:0;border:none;border-radius:%?10?%;background:none;display:flex;align-items:center;justify-content:center;z-index:9}.box-input .input .btn-send[data-v-971d73c0]::after{display:none}.box-input .input .btn-send[data-v-971d73c0]:active{background:#f2f2f2}.box-input .input .btn-send uni-image[data-v-971d73c0]{width:%?40?%}.empty[data-v-971d73c0]{text-align:center;margin:0 %?60?%;padding:%?80?% 0 %?100?% 0;margin-top:%?200?%;background:#fff;border-radius:%?20?%}.empty uni-image[data-v-971d73c0]{width:%?404?%;height:%?266?%;margin-bottom:%?40?%}.empty .tip[data-v-971d73c0]{width:100%;line-height:%?40?%;font-size:%?32?%;letter-spacing:%?2?%;color:#444}.btn-finish[data-v-971d73c0]{width:60%;height:%?80?%;line-height:%?80?%;border-radius:%?48?%;border:none;color:#fff;margin:%?240?% auto 0 20%;box-shadow:0 0 %?20?% rgba(0,235,79,.1);font-size:%?30?%;letter-spacing:%?4?%;outline:none;background:#39b54a;text-align:center}.page[data-v-971d73c0]{width:100%;overflow:hidden;display:flex;flex-direction:column;position:absolute;left:0;right:0;top:0;bottom:0;background:#fff}.box-msg-list[data-v-971d73c0]{width:100%;height:100%;top:0;bottom:%?132?%;left:0;box-sizing:border-box;overflow:hidden}.list[data-v-971d73c0]{width:100%;height:auto}.message[data-v-971d73c0]{display:flex;justify-content:flex-start;padding:%?40?% %?40?%;border-bottom:%?2?% solid #eee}.message[data-v-971d73c0]:last-child{border-bottom:0}.message .text[data-v-971d73c0]{width:100%;color:#343541;line-height:%?52?%;font-size:%?32?%;word-break:break-all;padding:%?4?% 0;overflow:hidden}.message .text span[data-v-971d73c0]{display:inline}.message .avatar[data-v-971d73c0]{width:%?48?%;height:%?48?%;background:#10a37f;margin-right:%?30?%;color:#fff;font-size:%?28?%;border-radius:%?4?%;display:flex;align-items:center;justify-content:center;margin-top:%?6?%;overflow:hidden}.message .avatar uni-image[data-v-971d73c0],\n.message .avatar img[data-v-971d73c0]{width:%?48?%;height:%?48?%}.account[data-v-971d73c0]{margin:%?20?% %?30?%;padding:%?16?% %?24?% %?16?% %?24?%;box-sizing:border-box;\n\t/* background: #f3f6f9; */border-radius:%?10?%;display:flex;justify-content:space-between;align-items:center}.account .balance[data-v-971d73c0]{color:#666;font-size:%?24?%}.account .balance uni-text[data-v-971d73c0]{color:#10a37f;margin-right:%?6?%}.account .btn-pay[data-v-971d73c0]{display:inline-block;color:#10a37f;margin-left:%?20?%;font-size:%?24?%}.banner-ad[data-v-971d73c0]{width:100%;height:%?120?%;border-top:%?2?% solid #ddd}.content[data-v-971d73c0]{padding:%?20?%}.content uni-view[data-v-971d73c0]{margin:%?10?% 0;word-break:break-all;line-height:1.5;font-size:%?28?%;color:#444}.content uni-image[data-v-971d73c0]{width:100%}.btn-copy[data-v-971d73c0]{color:#409eff}",""]),t.exports=e}}]);