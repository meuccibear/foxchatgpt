<template>
  <el-scrollbar wrap-class="scrollbar-wrapper">
    <div class="box-draw-setting">
      <div class="header">✳ 图片尺寸</div>
      <div class="size-list">
        <div v-for="item in imageSizes" class="item" :class="{active: size === item}" @click="switchSize(item)" :title="item">
          <div :class="'size-block ' + item"></div>
          <span>{{ item }}</span>
        </div>
        <div style="clear:both;"></div>
      </div>
    </div>
  </el-scrollbar>
</template>

<script>
import { uploadImage } from '@/api/upload'
export default {
  data() {
    return {
      imageSizes: ['256x256', '512x512', '1024x1024'],
      size: ''
    }
  },
  methods: {
    getDrawOptions() {
      return {
        channel: 'lxai',
        image: this.image
      }
    },
    switchSize(size) {
      this.size = size
    },
    showPay(type) {
      this.$emit('showPay', type)
    },
    uploadImage(item) {
      var form = new FormData()
      form.append('image', item.file)
      if (item.data) {
        form.append('data', JSON.stringify(item.data))
      }
      uploadImage(form).then(res => {
        this.image = res.data.path
      })
    }
  }
};
</script>
<style lang="scss" scoped>
.size-list {
  width: 210px;
  .item {
    width: 60px;
    height: 40px;
    border: 1px solid #ddd;
    float: left;
    margin-right: 10px;
  }
}
</style>
