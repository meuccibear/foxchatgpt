<template>
  <div>
    <sidebar :menus="submenus" :module-name="moduleName" />
    <router-view name="subRouter" />
  </div>
</template>

<script>

import sidebar from '../sidebar'

export default {
  components: { sidebar },
  data() {
    return {
      moduleName: 'Key池管理',
      submenus: [
        {
          title: 'OpenAI',
          routeName: 'ModuleKeysOpenai',
          routeQuery: {}
        },
        {
          title: 'GPT4',
          routeName: 'ModuleKeysGpt4',
          routeQuery: {}
        },
        {
          title: 'Api2d',
          routeName: 'ModuleKeysApi2d',
          routeQuery: {}
        },
        {
          title: '灵犀AI',
          routeName: 'ModuleKeysLxai',
          routeQuery: {}
        },
        {
          title: 'Replicate',
          routeName: 'ModuleKeysReplicate',
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
    margin-left: 130px;
  }
</style>

