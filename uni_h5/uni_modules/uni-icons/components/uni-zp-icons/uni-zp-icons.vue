<template>
  <view class="icon-content" @tap="upload">
    <uni-icons type="upload" size="18" color="#999"></uni-icons>
    <text class="icon-content-text">编辑</text>
  </view>
</template>

<script>
const app = getApp();
export default {
  name: 'UniZpIcons',
  data() {
    return {}
  },
  onLoad(options) {},
  methods: {
    upload(){
      this.$emit('upload')
    }
  }
};
</script>
<style lang="scss">
  .icon-content {
    display: flex;
    flex-direction: row;
    align-items: center;
  }

  .icon-content-text {
    font-size: 19px;
    color: #666;
    margin-left: 5px;
  }
</style>
