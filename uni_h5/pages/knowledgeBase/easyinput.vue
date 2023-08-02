<template>
  <view class="item">
    <view class="label">
      <span>知识库名称</span>
    </view>
    <input />
  </view>
</template>

<script>
const app = getApp();
export default {
  data() {
    return {}
  },
  onLoad(options) {},
  methods: {}
};
</script>
<style lang="scss">
.item {
  border-bottom: 1px solid #e52424;
  .label {
    height: .32rem;
    font-size: .22rem;
    line-height: .32rem;
    color: #4a4a4a;
    opacity: .5;
    span {
      position: relative;
      font-size: .3rem;
      top: .44rem;
      -webkit-transition: all .1s linear;
      transition: all .1s linear
    }
  }
}
</style>
