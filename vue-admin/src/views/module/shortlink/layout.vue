<template>
  <div>
    <sidebar :menus="submenus" :module-name="moduleName" :width="120" />
    <router-view name="subRouter" />
  </div>
</template>

<script>

import sidebar from '../sidebar'

export default {
  components: { sidebar },
  data() {
    return {
      moduleName: '生成短链',
      submenus: [
        {
          title: '小程序转短链',
          routeName: 'ModuleShortlinkWxapp',
          routeQuery: {}
        },
        {
          title: '公众号转短链',
          routeName: 'ModuleShortlinkWxmp',
          routeQuery: {}
        },
        {
          title: '普通h5转短链',
          routeName: 'ModuleShortlinkH5',
          routeQuery: {}
        },
        {
          title: '二维码转活码',
          routeName: 'ModuleShortlinkQrcode',
          routeQuery: {}
        },
        {
          title: '域名配置',
          routeName: 'ModuleShortlinkSetting',
          routeQuery: {}
        }
      ]
    }
  },
  methods: {

  }
}
</script>
<style scoped>
  .app-container {
    margin-left: 140px;
  }
</style>

