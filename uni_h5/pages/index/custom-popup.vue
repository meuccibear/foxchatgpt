<template>

  <view v-show="show">

    <view class="popup-bg" @click.stop="close"></view>

    <view class="popup-content">

      <!-- 弹出层内容 -->

      <slot></slot>

    </view>

  </view>

</template>

<script>

export default {

  props: {

    show: {

      type: Boolean,

      default: false

    }

  },

  methods: {

    close() {

      this.$emit('close');

    }

  }

};

</script>

<style>



.popup-bg {

  position: fixed;

  top: 0;

  right: 0;

  bottom: 0;

  left: 0;

  background: rgba(0, 0, 0, 0.5);

}

.popup-content {

  position: fixed;

  top: 50%;

  left: 50%;

  transform: translate(-50%, -50%);

  background: #fff;

  padding: 20px;

  border-radius: 5px;

  box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);

}

</style>
