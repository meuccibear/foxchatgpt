<template>
  <div v-if="qrcode">
    <el-dialog
      custom-class="my-dialog"
      title="微信扫一扫登录"
      :visible="true"
      width="360px"
      :close-on-click-modal="false"
      :before-close="closeLogin"
    >
      <el-row style="text-align: center;">
        <img :src="qrcode" width="300" />
      </el-row>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: 'Login',
  props: {
    qrcode: {
      type: String,
      default: ''
    }
  },
  methods: {
    closeLogin() {
      this.$emit('close')
    }
  }
}
</script>

<style scoped>
.app-main {
  /*50 = navbar  */
  min-height: calc(100vh - 50px);
  /*min-height: 100vh;*/
  width: 100%;
  position: relative;
  overflow: hidden;
  background: #f3f6f9;
}
.fixed-header+.app-main {
  padding-top: 50px;
}
</style>

<style lang="scss">
// fix css style bug in open el-dialog
.el-popup-parent--hidden {
  .fixed-header {
    padding-right: 15px;
  }
}
</style>
