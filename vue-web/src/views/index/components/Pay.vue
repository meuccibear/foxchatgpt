<template>
  <div>
      <el-dialog
        custom-class="my-dialog pay-dialog"
        title=""
        :visible="true"
        width="780px"
        :close-on-click-modal="false"
        :before-close="closePay"
      >
        <div class="tabs">
          <div class="tab-item" :class="{active: type === 'vip'}" @click="switchType('vip')">开通VIP会员</div>
          <div class="tab-item" :class="{active: type === 'goods'}" @click="switchType('goods')">充值对话次数</div>
          <div class="tab-item" :class="{active: type === 'draw'}" @click="switchType('draw')">充值绘画次数</div>
          <div class="tab-item" v-if="hasModel4" :class="{active: type === 'gpt4'}" @click="switchType('gpt4')">充值{{ model4Name }}字数</div>
        </div>
        <div class="box-pay" v-if="goodsList && goodsList.length > 0">
          <div class="goods-list">
            <div class="goods" :class="{active: item.id === goods_id}" v-for="(item,index) in goodsList" @click="chooseGoods(item.id)">
              <div class="hint" v-if="item.hint">{{ item.hint }}</div>
              <div class="title">
                <span class="num">{{item.num}}</span>
                <span class="unit" v-if="type === 'vip'">个月</span>
                <span class="unit" v-if="type === 'goods'">次</span>
                <span class="unit" v-if="type === 'gpt4'">万字</span>
                <span class="unit" v-if="type === 'draw'">张</span>
              </div>
              <div class="price">
                <span class="unit">￥</span>{{ item.price / 100 }}
              </div>
              <div class="market_price" v-if="item.market_price > 0">￥{{item.market_price / 100}}</div>
            </div>
            <div style="clear: both;"></div>
          </div>
          <div class="info">
            <div class="pay">
              <div v-if="pay_url" class="box-qrcode">
                <div class="qrcode">
                  <vue-qr :text="pay_url" :size="160" />
                </div>
                <div class="qrcode-desc" style="text-align: center;">
                  <div class="title">请支付</div>
                  <div class="price">
                    <span class="unit">￥</span>
                    <span>{{ totalFee / 100 }}</span>
                  </div>
                  <div class="paytype">
                    <svg-icon class="icon" icon-class="ic_wxpay"></svg-icon>
                    <span>微信扫码付款</span>
                  </div>
                </div>
              </div>

              <div v-else>
                <el-button class="btn-pay" type="primary" :disabled="!goods_id" @click="createOrder">立即支付</el-button>
                <div class="agreement">
                  <el-checkbox v-model="isAgree" color="#666">请认真阅读并同意<a @click="toDoc('service')">《服务协议》</a></el-checkbox>
                </div>
              </div>
            </div>

            <div class="desc" v-if="curGoods && curGoods.desc && curGoods.desc.length > 0">
              <ul>
                <li v-for="item in curGoods.desc" v-if="item">
                  <svg-icon class="icon" icon-class="ic_pay_check"></svg-icon>
                  <span>{{ item }}</span>
                </li>
              </ul>
            </div>

          </div>
        </div>
      </el-dialog>
    </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { getGoodsList, createOrder, checkPay } from '@/api/order'
import vueQr from 'vue-qr'

export default {
  components: {vueQr},
  props: {
    payType: {
      type: String,
      default: 'vip'
    }
  },
  data() {
    return {
      type: 'vip',
      goodsList: [],
      goods_id: 0,
      order_id: '',
      pay_url: '',
      checkPaySi: 0,
      isAgree: true
    }
  },
  computed: {
    ...mapGetters([
      'hasModel4',
      'model4Name'
    ]),
    totalFee() {
      var totalFee = 0
      if (this.goods_id) {
        this.goodsList.forEach((item, index) => {
          if (item['id'] === this.goods_id) {
            totalFee = item['price']
          }
        })
      }
      return totalFee
    },
    curGoods() {
      var curGoods = null
      if (this.goods_id) {
        this.goodsList.forEach((item, index) => {
          if (item['id'] === this.goods_id) {
            curGoods = item
          }
        })
      }
      return curGoods
    }
  },
  created() {
    this.type = this.payType
    this.getGoodsList()
  },
  methods: {
    getGoodsList() {
      getGoodsList({type: this.type}).then(res => {
        const goodsList = res.data
        this.goodsList = goodsList
        if (goodsList && goodsList.length > 0) {
          for (var i = 0; i < goodsList.length; i++) {
            if (goodsList[i].is_default) {
              this.chooseGoods(goodsList[i].id)
              break;
            }
          }
        }
      }).catch(res => {
        if (res.errno === 403) {
          this.showLogin()
        }
      })
    },
    switchType(type) {
      this.type = type
      this.goods_id = 0
      this.goodsList = null
      this.getGoodsList()
    },
    chooseGoods(goods_id) {
      this.goods_id = goods_id
      this.stopCheckPay()
      this.pay_url = ''
    },
    createOrder() {
      if (!this.goods_id) {
        this.$message.error('请选择套餐')
        return
      }
      if (!this.isAgree) {
        this.$message.error('请先阅读并同意《服务协议》')
        return
      }
      createOrder({
        type: this.type,
        goods_id: this.goods_id
      }).then(res => {
        this.order_id = res.data.order_id
        this.pay_url = res.data.pay_url
        this.checkPaySi = setInterval(() => {
          this.checkPay()
        }, 3000)
      }).catch(res => {
        if (res.errno === 403) {
          this.showLogin()
        }
      });
    },
    stopCheckPay() {
      if (this.checkPaySi) {
        clearInterval(this.checkPaySi)
        this.checkPaySi = 0
      }
    },
    closePay() {
      this.stopCheckPay()
      this.$emit('close')
    },
    checkPay() {
      checkPay({
        order_id: this.order_id
      }).then(res => {
        if (res.data.ispay) {
          this.$message.success('付款成功')
          window.location.reload()
        }
      }).catch(res => {
        if (res.errno === 403) {
          this.showLogin()
        }
      })
    },
    toDoc(type) {
      let routeData = this.$router.resolve({name: 'Doc', query: {type: type}})
      window.open(routeData.href, '_blank')
    }
  }
};
</script>
<style lang="scss" scoped>
.tabs {
  width: 100%;
  background: #293141;
  padding-top: 10px;
  padding-left: 30px;
  .tab-item {
    display: inline-block;
    padding: 12px 30px;
    background: #454f64;
    color: #fff;
    cursor: pointer;
    font-size: 15px;
    letter-spacing: 1px;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
    position: relative;
    z-index: 2;
    margin-right: 10px;
    i,span {
      position: absolute;
      bottom: 0;
      display: none;
      width:20px;
      height:20px;
      background:#454f64;
    }
    i {
      left: -10px;
    }
    span {
      right: -10px;
    }

    &:hover {
      background: #727e96;
    }
    &.active {
      background: linear-gradient(to bottom, #fff9f2, #fff);
      color: #000;
      padding-top: 18px;
      font-weight: bold;
      z-index: 1;
      i,span {
        display: block;
        background:#fff;
      }
    }
    &:first-child {
      border-bottom-left-radius: 0 !important;
      i {
        background: #454f64 !important;
      }
    }
    &:last-child {
      border-bottom-right-radius: 0 !important;
    }
  }
}

.box-title {
  width: 100%;
  height: 36px;
  line-height: 36px;
  font-size: 16px;
  color: #333;
  font-weight: bold;
  .desc {
    font-weight: normal;
    color: #999;
    font-size: 14px;
    margin-left: 10px;
  }
}
.box-pay {
  padding: 40px 60px;
  box-sizing: border-box;
  min-height: 300px;
  background: #fff;
}
.goods-list {
  .goods {
    background: #f7f7f9;
    width: 150px;
    height: 120px;
    text-align: center;
    padding: 15px 0;
    float: left;
    margin-right: 15px;
    box-sizing: border-box;
    margin-bottom: 15px;
    cursor: pointer;
    border-radius: 10px;
    position: relative;

    .hint {
      background: #fb6a32;
      color: #fff;
      position: absolute;
      top: -12px;
      left: 0;
      font-size: 13px;
      padding: 4px 10px;
      border-radius: 4px;
    }

    .title {
      font-size: 15px;
      display: flex;
      align-items: baseline;
      justify-content: center;
      color: #333;
      margin-top: 5px;
      .unit {
        font-weight: normal;
        margin-left: 3px;
      }
    }
    .price {
      font-size: 32px;
      margin: 10px 0;
      font-weight: bold;
      color: #444e63;
      .unit {
        font-size: 14px;
        font-weight: normal;
        position: relative;
        top: -2px;
        margin-right: 3px;
      }
    }
    .market_price {
      color: #999;
      text-decoration: line-through;
      font-size: 14px;
    }
    &.active {
      background: #fadfbb;
      .price {
        color: #522a19;
      }
      .market_price {
        color: #a88e7d;
      }
    }
  }
}
.info {
  width: 100%;
  display: flex;
  justify-content: space-between;
  margin-top: 10px;
  .desc {
    width: 340px;
    ul,li {
      list-style: none;
      margin: 0;
      padding: 0;
    }
    li {
      width: 100%;
      height: 32px;
      line-height: 32px;
      white-space: nowrap;
      display: flex;
      align-items: center;
      font-size: 16px;
      color: #444;
      margin: 8px 0;
      letter-spacing: 1px;
      .icon {
        font-size: 20px;
        margin-right: 10px;
        color: #f6a944;
      }
    }
  }
  .pay {
    width: 300px;
    .btn-pay {
      background-color: #454f64 !important;
      margin-top: 15px;
      &:hover {
        opacity: 0.8;
      }
    }
    .agreement {
      width: 100%;
      font-size: 14px;
      line-height: 32px;
      margin-top: 15px;
      color: #999;
    }
    .box-qrcode {
      margin: 10px 20px 15px 0;
      border-radius: 10px;
      display:flex;
      .qrcode {
        text-align: center;
        border-radius: 10px;
        overflow: hidden;
        width: 140px;
        height: 140px;
        margin-right: 15px;

        img {
          position: relative;
          left: -10px;
          top: -10px;
        }
      }
      .qrcode-desc {
        text-align: center;
        padding: 15px 0;
        box-sizing: border-box;
        .title {
          font-size: 16px;
          color: #666;
        }
        .price {
          font-size: 36px;
          color: #fa554c;
          font-weight: bold;
          margin: 13px 0;
          .unit {
            font-size: 14px;
            margin-right: 5px;
            position:relative;
            top: -2px;
          }
        }
        .paytype {
          display: flex;
          align-items: center;
          font-size: 14px;
          margin-top: 20px;
          color: #666;
          .icon {
            font-size: 16px;
            margin-right: 5px;
            color: #56c505;
          }
        }
      }

    }
  }
  .el-radio {
    margin-right: 0;
  }
}

</style>
<style lang="scss">
.box-pay {
  .el-checkbox__input.is-checked .el-checkbox__inner, .el-checkbox__input.is-indeterminate .el-checkbox__inner {
    background-color: #293141;
    border-color: #293141;
  }
  .el-checkbox__input.is-checked+.el-checkbox__label {
    color: #606266;
  }
  .el-checkbox__inner:hover {
    border-color: #10a37f;
  }
}
</style>
