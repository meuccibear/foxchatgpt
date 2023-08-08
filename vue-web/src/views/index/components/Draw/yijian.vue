<template>
    <el-scrollbar wrap-class="scrollbar-wrapper">
      <div class="box-draw-setting">
        <div class="header">✳ 类型设置</div>
        <div class="options">
          <div v-for="item in options.styleDetails" class="option-item" :class="{active: group_name === item.GroupName}" @click="switchGroup(item.GroupName)" style="width: 132px; height: 80px;">
            <img :src="item.ShowImage" :alt="item.GroupName">
            <span>{{ item.GroupName }}</span>
          </div>
          <div style="clear:both;"></div>
        </div>
        <div v-if="styles && styles.length > 0">
          <div class="header">✳ 风格设置</div>
          <div class="options">
            <div v-for="item in styles" class="option-item" :class="{active: engine === item.engine && style === item.value}" @click="switchEngine(item.engine, item.value)" :title="item.text">
              <img :src="item.poster" :alt="item.text">
              <span>{{ item.text }}</span>
            </div>
            <div style="clear:both;"></div>
          </div>
        </div>

        <div v-if="sub_styles && sub_styles.length > 0">
          <div class="header">✳ 选择模式</div>
          <div class="options">
            <div v-for="item in sub_styles" class="option-item" :class="{active: sub_style === item.value}" @click="switchSubStyle(item.value)" :title="item.text">
              <img :src="item.poster" :alt="item.text">
              <span>{{ item.text }}</span>
            </div>
            <div style="clear:both;"></div>
          </div>
        </div>
        <div class="header">✳ 图片比例</div>
        <div class="options">
          <div v-for="item in options.imageSizes" class="size-item" :class="{active: size === item.value}" @click="switchSize(item.value)" :title="item.desc">
            <div :class="'size-block size' + item.value"></div>
            <span>{{ item.text }}</span>
          </div>
          <div style="clear:both;"></div>
        </div>
        <div class="header">✳ 参考图片（可选）</div>
        <div class="options">
          <el-input type="textarea" rows="2" v-model="image" placeholder="输入图片地址或上传图片" size="small" style="width: 410px;" />
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
import { uploadImage } from '@/api/upload';

export default {
  props: {
    options: {
      type: Object,
      default() {
        return {}
      }
    }
  },
  data() {
    return {
      group_name: '',
      size: 0,
      style: '',
      engine: '',
      sub_style: '',
      image: '',
      styles: []
    }
  },
  watch: {
    group_name() {
      this.options.styleDetails.forEach(item => {
        if (this.group_name === item.GroupName) {
          this.styles =  item.Styles
          // 默认选第一个
          if (item.Styles.length > 0) {
            this.engine = item.Styles[0].engine
            this.style = item.Styles[0].value
          } else {
            this.engine = ''
            this.style = ''
          }
        }
      })
    }
  },
  computed: {
    sub_styles() {
      var sub_styles = []
      this.styles.forEach(item => {
        if (this.engine === item.engine && this.style === item.value) {
          // 默认选第一个
          if (item.sub_styles.length > 0) {
            this.sub_style = item.sub_styles[0].value
          } else {
            this.sub_style = ''
          }
          sub_styles= item.sub_styles
        }
      })
      return sub_styles
    }
  },
  created() {
    var groups = []
    this.options.styleDetails.forEach((item, index) => {
      groups.push({
        title: item.GroupName,
        poster: item.ShowImage
      })
      if (index === 0) {
        this.group_name = item.GroupName
      }
    })
    this.groups = groups
  },
  methods: {
    switchGroup(group_name) {
      this.group_name = group_name
    },
    switchEngine(engine, style) {
      this.engine = engine
      this.style = style
    },
    switchSubStyle(sub_style) {
      this.sub_style = sub_style
    },
    switchSize(size) {
      this.size = size
    },
    getDrawOptions() {
      return {
        channel: 'yijian',
        engine: this.engine,
        style: this.style,
        sub_style: this.sub_style,
        size: this.size,
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
<style lang="scss" scoped>
.draw-setting {
  width: 450px;
  position: absolute;
  left: 15px;
  top: 15px;
  background: #f7f7f8;
  bottom: 15px;
  border-radius: 10px;
  overflow: hidden;
  transition: background-color 0.1s ease-in-out;

  .module-body {
    position: absolute;
    left: 0;
    right: 0;
    top: 0;
    bottom: 60px;
    padding: 0;

    .scrollbar-wrapper {
      overflow-x: hidden !important;
    }

    .el-scrollbar__bar.is-vertical {
      right: 0;
      width: 3px;
    }

    .el-scrollbar {
      height: 100%;
    }

    .box-draw-setting {
      width: 450px;
      padding: 20px;
      padding-right: 0;
      box-sizing: border-box;
      //transform: scale(0.88);
      .header {
        font-size: 16px;
        color: #333;
        margin-bottom: 22px;
        margin-top: 16px;
        vertical-align: middle;
        letter-spacing: 1px;
      }
      .options {
        width: 100%;
        .option-item {
          width: 76px;
          height: 76px;
          float: left;
          margin-bottom: 8px;
          margin-right: 8px;
          border-radius: 10px;
          display: flex;
          align-items: center;
          justify-content: center;
          box-sizing: border-box;
          position: relative;
          overflow: hidden;
          cursor: pointer;
          transition: all .2s;
          background-clip: padding-box, border-box;
          background-origin: padding-box, border-box;
          border: 3px solid transparent;
          &.active {
            background-image: linear-gradient(to right,#333333, #333333),linear-gradient(270deg,#FF5CE4 0%, #36C2FF 100%);
          }
          img {
            width: 100%;
            height: 100%;
          }
          span {
            position: absolute;
            left: 0;
            bottom: 0;
            width: 100%;
            height: 36px;
            line-height: 44px;
            white-space: nowrap;
            text-align: center;
            z-index: 9;
            color: #fff;
            font-size: 12px;
            font-weight: 500;
            background: linear-gradient(180deg, rgba(0,0,0,0) 0%, #000000 100%)
          }
        }
      }
      .size-item {
        width: 76px;
        height: 110px;
        float: left;
        margin-bottom: 8px;
        margin-right: 8px;
        border-radius: 10px;
        box-sizing: border-box;
        position: relative;
        overflow: hidden;
        cursor: pointer;
        text-align: center;
        transition: all .2s;
        background-clip: padding-box, border-box;
        background-origin: padding-box, border-box;
        border: 2px solid #e2e2e2;
        padding: 10px;
        background-color: #fff;
        &.active {
          border-color: transparent;
          background-image: linear-gradient(to right,#fff, #fff), linear-gradient(270deg, #FF5CE4 0%, #36C2FF 100%);
          .size-block {
            background-image: linear-gradient(270deg,#ff5ce4 0%,#36c2ff 100%);
          }
        }
        .size-block {
          margin: 0 auto;
          background-image: linear-gradient(to right,#ddd, #ddd);
          border-radius: 4px;
          transition: all .2s;
          &.size0 {
            width: 52px;
            height: 39px;
          }
          &.size1 {
            width: 39px;
            height: 52px;
          }
          &.size2 {
            width: 52px;
            height: 52px;
          }
          &.size3 {
            width: 52px;
            height: 29px;
          }
          &.size4 {
            width: 29px;
            height: 52px;
          }
        }
        span {
          position: absolute;
          left:0;
          bottom: 0;
          display: block;
          width: 100%;
          height: 32px;
          line-height: 32px;
          color: #333;
          font-size: 14px;
        }
      }
    }

  }
  .module-footer {
    position: absolute;
    left: 0;
    bottom: 0;
    right: 0;
    height: 73px;
    .box-wallet {
      width: 430px;
      height: 40px;
      background: linear-gradient(30deg, #f7debe, #f4c384);
      border-radius: 5px;
      margin: 10px;
      padding: 8px 10px 5px 15px;
      box-sizing: border-box;
      color: #9a5b12;
      transition: opacity 0.1s ease-in-out;
      cursor: pointer;
      font-size: 14px;
      letter-spacing: 1px;
      display: flex;
      align-items: center;

      &:hover {
        opacity: 0.8;
      }

      .icon {
        font-size: 18px;
        margin-right: 5px;
      }
      span {
        font-size: 16px;
        font-weight: bold;
        margin: 0 5px;
      }
    }
  }
}


</style>

