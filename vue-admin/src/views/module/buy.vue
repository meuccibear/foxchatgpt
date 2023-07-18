<template>
  <div class="app-container">
    <div class="mod-panel">
      <div class="mod-item">
        <div class="icon">
          <svg-icon :icon-class="info.icon" class="text-green" />
        </div>
        <div class="title">{{ info.title }}</div>
        <div class="desc">{{ info.desc }}</div>
        <div class="price">
          <span class="text-price">限时￥{{ info.price / 100 }}</span>
          <span class="text-market-price">￥{{ info.market_price / 100 }}</span>
        </div>
        <div class="footer">
          <el-button type="primary" size="normal" @click="toBuy">立即开通</el-button>
        </div>
      </div>
    </div>

    <div v-if="kefuShow">
      <el-dialog
        custom-class="my-dialog"
        title="微信扫码 - 联系客服开通"
        :visible="true"
        width="360px"
        :close-on-click-modal="false"
        :before-close="closeKefu"
      >
        <el-row style="text-align: center;">
          <img :src="kefuQrcode" style="width: 300px;">
        </el-row>
      </el-dialog>
    </div>
  </div>
</template>

<script>
import { getModule } from '@/api/module/index'
export default {
  data() {
    return {
      module: '',
      info: '',
      kefuShow: false,
      kefuQrcode: 'https://console.ttk.ink/static/kefu.jpg'
    }
  },
  computed: {
    roles() {
      return this.$store.getters.roles
    }
  },
  created() {
    if (this.$route.query && this.$route.query.module) {
      this.module = this.$route.query.module
      this.getModule()
    }
  },
  methods: {
    getModule() {
      getModule({
        module: this.module
      }).then(res => {
        this.info = res.data
      })
    },
    toBuy() {
      this.kefuShow = true
    },
    closeKefu() {
      this.kefuShow = false
    }
  }
}
</script>

<style lang="scss" scoped>
  .mod-panel {
    width: 100%;
    max-width: 1330px;
    padding: 20px;
    margin-bottom: 20px;
    background-color: #fff;

    .mod-item {
      width: 600px;
      padding: 13px 20px 13px 13px;
      border-radius: 5px;
      margin: 50px auto;
      overflow: hidden;
      text-align: center;
      .icon {
        width: 180px;
        height: 100%;
        font-size: 48px;
        line-height: 50px;
        box-sizing: border-box;
        margin: 0 auto;
      }
      .title {
        font-size: 16px;
        font-weight: bold;
        margin: 20px 0;
      }
      .desc {
        font-size: 14px;
        color: #8d8d8d;
        line-height: 18px;
      }
      .price {
        margin-top: 60px;
        margin-bottom: 25px;
        .text-price {
          font-size: 18px;
          font-weight: bold;
          color: #d81e06;
          margin-right: 10px;
        }
        .text-market-price {
          font-size: 16px;
          color: #888;
          text-decoration: line-through;
        }
      }

      .btn-yes {

      }

      .text-orange {
        color: #f19405;
      }
      .text-green {
        color: #06b13c;
      }
      .text-blue {
        color: #0e86f5;
      }
      .text-red {
        color: #d81e06;
      }
    }
  }
</style>
