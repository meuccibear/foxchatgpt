<template>
    <el-scrollbar wrap-class="scrollbar-wrapper">
      <div class="box-draw-setting">
        <div class="header">参考图片（可选）</div>
        <div class="options">
          <el-input type="textarea" rows="3" v-model="image" placeholder="输入图片地址或上传图片" size="small" style="width: 210px;" />
          <el-upload
            class="avatar-uploader"
            action=""
            :http-request="uploadImage"
            :show-file-list="false"
            :multiple="false"
            style="margin-top: 15px;"
          >
            <img
              v-if="image"
              :src="image"
              class="avatar"
              style="height: 80px; width: auto;"
            >
            <i
              v-else
              class="el-icon-plus avatar-uploader-icon"
              style="width: 80px; height: 80px; line-height:80px;"
            />
          </el-upload>
          <p style="color: #999; font-size: 13px;">注：限1000x1000像素以内</p>
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
      image: ''
    }
  },
  methods: {
    getDrawOptions() {
      return {
        channel: 'lxai',
        image: this.image
      }
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

