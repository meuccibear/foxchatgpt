<template>
  <div class="my-extend">
    <a title="源码下单地址" href="https://www.kt8.cn/item/view1856.html" target="_blank">
      <i class="el-icon-link"></i>
      源码下单地址
    </a>
  </div>
</template>

<script>

</script>

<style lang="scss" scoped>
  .my-extend {
    width: 100%;
    height: 54px;
    line-height: 54px;
    cursor: pointer;
    transition: background .3s;
    -webkit-tap-highlight-color:transparent;
    position: absolute;
    left: 0;
    bottom: 54px;
    background: rgba(0, 0, 0, .05);
    font-size: 14px;
    text-align: center;
    overflow: hidden;

    &:hover {
      background: rgba(0, 0, 0, .2)
    }
  }
</style>
