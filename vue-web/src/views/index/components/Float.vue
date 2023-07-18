<template>
  <div class="float" @click="toDoc('kefu')">
    <svg-icon icon-class="ic_kefu" class="icon"></svg-icon>
    <span>联系客服</span>
  </div>
</template>

<script>
export default {
  methods: {
    toDoc(type) {
      let routeData = this.$router.resolve({ name: 'Doc', query: { type: type } })
      window.open(routeData.href, '_blank')
    }
  }
}
</script>
<style lang="scss" scoped>
.float {
  position: fixed;
  right: 0;
  top: 50%;
  margin-top: -80px;
  width: 44px;
  height: 160px;
  border-top-left-radius: 10px;
  border-bottom-left-radius: 10px;
  border: 1px solid #ddd;
  border-right:none;
  overflow: hidden;
  padding: 20px 10px;
  font-size: 16px;
  z-index: 9;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: background 0.1s ease-in-out, color 0.1s ease-in-out;
  .icon {
    font-size: 24px;
    margin-bottom: 5px;
  }
  span {
    line-height: 20px;
    text-align: center;
  }
}
</style>
