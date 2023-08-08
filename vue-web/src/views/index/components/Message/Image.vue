<template>
  <div>
    <div v-if="item.state === 0" class="writing">
      <draw-loading title="生成中，预计需要1-3分钟左右" color="#04BABE" />
    </div>
    <div v-else-if="item.state === 1">
      <div style="overflow: hidden; border-radius: 10px; width: 260px;">
        <el-image
          v-for="(image, index) in item.response"
          class="image"
          :class="{small: item.response.length > 1}"
          :src="image"
          :preview-src-list="item.response"
          title="点击放大"
        />
      </div>

<!--      <div v-if="item.channel === 'lxai'" class="mj-ctrl">
        <div class="title">放大：</div>
        <div>
          <span title="放大左上" @click="mjCtrl(item.draw_id, 'upscale', 1)">U1</span>
          <span title="放大右上" @click="mjCtrl(item.draw_id, 'upscale', 2)">U2</span>
          <span title="放大左下" @click="mjCtrl(item.draw_id, 'upscale', 3)">U3</span>
          <span title="放大右下" @click="mjCtrl(item.draw_id, 'upscale', 4)">U4</span>
        </div>
        <div class="title">变换：</div>
        <div>
          <span title="变换左上" @click="mjCtrl(item.draw_id, 'variation', 1)">V1</span>
          <span title="变换右上" @click="mjCtrl(item.draw_id, 'variation', 2)">V2</span>
          <span title="变换左下" @click="mjCtrl(item.draw_id, 'variation', 3)">V3</span>
          <span title="变换右下" @click="mjCtrl(item.draw_id, 'variation', 4)">V4</span>
        </div>
      </div>-->
    </div>
    <div v-else-if="item.state === 2" class="writing fail">
      <div class="errmsg">
        <i class="el-icon-error"></i>
        <span style="max-width: 200px;">生成失败: {{ item.errmsg }} </span>
      </div>
      <div><span @click="retry(item.draw_id)" class="btn-retry">重新生成</span></div>
    </div>
  </div>
</template>

<script>
import drawLoading from './drawLoading'
export default {
  components: { drawLoading },
  props: {
    item: {
      type: Object,
      default() {
        return {}
      }
    }
  },
  watch: {
    item: {
      handler(val) {
        console.log('val', val)
      },
      deep: true
    }
  },
  methods: {
    previewImage(image) {
      this.$emit('preview', image)
    },
    retry(draw_id) {
      this.$emit('retry', draw_id)
    },
    mjCtrl(draw_id, type, index = 1) {
      this.$emit('mjCtrl', draw_id, type, index)
    },
  }
}
</script>
<style lang="scss" scoped>
.image {
  width: 100%;
  box-sizing: border-box;
  float: left;
  max-width: 262px;
  transition: all 0.1s;
  &:hover {
    opacity: 0.88;
  }
  &.small {
    width: 130px;
  }
}

.mj-ctrl {
  float: left;
  width: 140px;
  margin-left: 20px;
  .title {
    line-height: 40px;
    color: #666;
    font-size: 14px;
  }
  span {
    display: inline-block !important;
    width: 48px;
    height: 32px;
    line-height: 32px;
    text-align: center;
    background: #e6e6e6;
    border-radius: 4px;
    margin-right: 10px;
    margin-bottom: 10px;
    cursor: pointer;
    color: #666;
    transition: all 0.1s;
    &:hover {
      opacity: 0.75;
    }
  }
}

.writing {
  width: 262px;
  height: 262px;
  background: #eee;
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 10px;
}

.fail {
  flex-direction: column;
}

.fail .errmsg {
  color: #666;
  font-size: 14px;
  display: flex;
  align-items: flex-start;
  line-height: 22px;
  padding: 15px 0;
  overflow: hidden;
  max-height: 105px;
}
.fail .errmsg i {
  font-size: 18px;
  margin-right: 5px;
  position: relative;
  top: 3px;
  color: #dd0000;
}
.fail .btn-retry {
  color: #666;
  padding: 5px 12px;
  background: #fff;
  border-radius: 5px;
  margin-top: 10px;
  font-size: 12px;
  cursor: pointer;
  &:hover {
    opacity: 0.8;
  }
}
</style>
