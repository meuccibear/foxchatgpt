(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-4bc23a2c"],{"696c":function(e,t,u){"use strict";u("98fd")},"7a38":function(e,t,u){"use strict";u("c729")},"978a":function(e,t,u){"use strict";var a=function(){var e=this,t=e.$createElement,u=e._self._c||t;return u("div",{staticClass:"submenu",class:{collapsed:e.isCollapse},style:"width:"+e.width+"px;"},[u("div",{staticClass:"module-name"},[e._v(e._s(e.moduleName))]),u("ul",{staticClass:"list-group"},e._l(e.menus,(function(t,a){return u("li",{key:a,staticClass:"list-item",class:{active:e.routeName===t.routeName},on:{click:function(u){return e.linkto(t.routeName,t.routeQuery)}}},[e._v(" "+e._s(t.title))])})),0)])},s=[],n=u("4a60"),o=(u("1a7c"),u("5f17"),u("c36d"),u("19e4"),u("6db4")),r={props:{menus:{type:Array,default:null},moduleName:{type:String,default:""},width:{type:Number,default:110}},computed:Object(n["a"])(Object(n["a"])({},Object(o["b"])(["sidebar"])),{},{isCollapse:function(){return!this.sidebar.opened},routeName:function(){return this.$route.name}}),methods:{linkto:function(e){var t=arguments.length>1&&void 0!==arguments[1]?arguments[1]:{};this.$router.replace({name:e,query:t})}}},l=r,i=(u("7a38"),u("3427")),c=Object(i["a"])(l,a,s,!1,null,"69562c9a",null);t["a"]=c.exports},"98fd":function(e,t,u){},c729:function(e,t,u){},ee34:function(e,t,u){"use strict";u.r(t);var a=function(){var e=this,t=e.$createElement,u=e._self._c||t;return u("div",[u("sidebar",{attrs:{menus:e.submenus,"module-name":e.moduleName}}),u("router-view",{attrs:{name:"subRouter"}})],1)},s=[],n=u("978a"),o={components:{sidebar:n["a"]},data:function(){return{moduleName:"AI身份模拟",submenus:[{title:"对话记录",routeName:"ModuleCosplayMsg",routeQuery:{}},{title:"角色管理",routeName:"ModuleCosplayRole",routeQuery:{}},{title:"类别管理",routeName:"ModuleCosplayType",routeQuery:{}}]}},methods:{}},r=o,l=(u("696c"),u("3427")),i=Object(l["a"])(r,a,s,!1,null,"98df12be",null);t["default"]=i.exports}}]);