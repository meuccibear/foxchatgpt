(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-2d225295"],{e2e7:function(t,e,a){"use strict";a.r(e);var i=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",{staticClass:"app-container",staticStyle:{"padding-bottom":"20px"}},[a("div",{staticClass:"toolbar"},[a("el-button",{attrs:{type:"primary",icon:"el-icon-refresh",size:"mini"},on:{click:t.getList}},[t._v("重新检查")]),t.version?a("span",{staticStyle:{"margin-left":"20px","font-size":"14px"}},[t._v("当前版本："+t._s(t.version))]):t._e()],1),a("el-tabs",{staticClass:"my-tabs",on:{"tab-click":t.switchTab},model:{value:t.tabname,callback:function(e){t.tabname=e},expression:"tabname"}},[a("el-tab-pane",{attrs:{label:"系统升级",name:"upgrade"}},[t.dataList&&t.dataList.length>0?a("el-table",{attrs:{data:t.dataList,stripe:"",size:"medium","header-cell-class-name":"bg-gray"}},[a("el-table-column",{attrs:{label:"序号",type:"index",idnex:t.tableIndex,width:"80",align:"center"}}),a("el-table-column",{attrs:{prop:"add_time",label:"发布时间",width:"150"}}),a("el-table-column",{attrs:{prop:"version",label:"版本号",width:"130"}}),a("el-table-column",{attrs:{prop:"content",label:"更新内容"},scopedSlots:t._u([{key:"default",fn:function(e){return[a("div",{domProps:{innerHTML:t._s(e.row.content)}})]}}],null,!1,3083567933)}),a("el-table-column",{attrs:{label:"操作",width:"200"},scopedSlots:t._u([{key:"default",fn:function(e){return[a("el-button",{attrs:{disabled:e.row.index>1,type:"text",size:"mini",icon:"el-icon-s-promotion"},nativeOn:{click:function(a){return a.preventDefault(),t.doUpgrade(e.row.version)}}},[t._v("升级 ")])]}}],null,!1,1634348691)})],1):a("div",{staticStyle:{width:"100%","background-color":"#f8f8f8","text-align":"center",padding:"100px 0"}},[a("span",{staticClass:"el-icon-circle-check",staticStyle:{"font-size":"48px",color:"#06b306"}}),a("p",{staticStyle:{color:"#666","font-size":"16px"}},[t._v("已是最新版")])])],1),a("el-tab-pane",{attrs:{label:"升级记录",name:"history"}},[t.historyList&&t.historyList.length>0?a("el-table",{attrs:{data:t.historyList,stripe:"",size:"medium","header-cell-class-name":"bg-gray","empty-text":"无内容"}},[a("el-table-column",{attrs:{prop:"add_time",label:"发布时间",width:"150"}}),a("el-table-column",{attrs:{prop:"version",label:"版本号",width:"130"}}),a("el-table-column",{attrs:{prop:"content",label:"更新内容"},scopedSlots:t._u([{key:"default",fn:function(e){return[a("div",{domProps:{innerHTML:t._s(e.row.content)}})]}}],null,!1,3083567933)})],1):t._e(),a("el-pagination",{attrs:{"current-page":t.historyPage,"page-size":t.historyPagesize,layout:"total, prev, pager, next",total:t.historyTotal},on:{"current-change":t.historyPageChange}})],1)],1)],1)},s=[],n=a("b775");function o(){return Object(n["a"])({url:"/upgrade/getList",method:"get"})}function r(t){return Object(n["a"])({url:"/upgrade/doUpgrade",method:"post",data:t})}function l(t){return Object(n["a"])({url:"/upgrade/getHistory",method:"post",data:t})}var c={data:function(){return{tabname:"upgrade",version:"",dataList:[],historyList:[],historyTotal:0,historyPage:0,historyPagesize:10}},mounted:function(){this.getList()},methods:{getList:function(){var t=this;this.tabname="upgrade",o().then((function(e){t.version=e.data.version,t.dataList=e.data.list}))},tableIndex:function(t){return t+1},doUpgrade:function(t){var e=this;r({type:this.tabname,version:t}).then((function(t){e.getList(),e.$message({message:t.message,type:"success",duration:1500})}))},getHistory:function(){var t=this;l({page:this.historyPage,pagesize:this.historyPagesize}).then((function(e){t.historyList=e.data.list,t.historyTotal=e.data.total}))},switchTab:function(){"history"===this.tabname?(this.historyPage=1,this.historyList=[],this.historyTotal=0,this.getHistory()):(this.dataList=[],this.getList())},historyPageChange:function(t){this.historyPage=t,this.getHistory()}}},d=c,u=a("3427"),p=Object(u["a"])(d,i,s,!1,null,null,null);e["default"]=p.exports}}]);