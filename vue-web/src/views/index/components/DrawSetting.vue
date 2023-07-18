<template>
  <div>
    <div class="box-draw-setting">
      <div class="header">✳ 类型设置（单选）</div>
      <div class="options">
        <div class="option-item">
          <img src="https://app.yjai.art:30108/ai-painting-control/type_style1.jpg" alt="通用设计">
          <span>通用设计</span>
        </div>
        <div class="option-item">
          <img src="https://app.yjai.art:30108/ai-painting-control/type_style2.jpg" alt="动漫设计">
          <span>动漫设计</span>
        </div>
        <div class="option-item">
          <img src="https://app.yjai.art:30108/ai-painting-control/type_style3.jpg" alt="现实设计">
          <span>现实设计</span>
        </div>
      </div>
    </div>
    <div class="draw-params">
      <div class="heading">✳ 类型设置（单选）</div>
      <div class="el-row style-options">
        <div class="el-col el-col-8 is-guttered">
          <div class="selected-style-option-item style-option-item type-options flex-center !rounded-2xl overflow-hidden">
            <img src="https://app.yjai.art:30108/ai-painting-control/type_style1.jpg" alt="通用设计">
            <span class="!text-lg !font-medium tracking-[1px]">通用设计</span>
          </div>
        </div>
        <div class="el-col el-col-8 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item type-options flex-center !rounded-2xl overflow-hidden">
            <!----><img src="https://app.yjai.art:30108/ai-painting-control/type_style2.jpg" alt="动漫设计"
                       ><span class="!text-lg !font-medium tracking-[1px]"
                                                >动漫设计</span></div>
        </div>
        <div class="el-col el-col-8 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item type-options flex-center !rounded-2xl overflow-hidden">
            <!----><img src="https://app.yjai.art:30108/ai-painting-control/type_style3.jpg" alt="现实设计"
                       ><span class="!text-lg !font-medium tracking-[1px]"
                                                >现实设计</span></div>
        </div>
      </div>
      <div class="heading">✳ 风格设置（单选）</div>
      <div class="el-row style-options" style="margin-left: -5px; margin-right: -5px;">
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center"><!----><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/ZN.png" alt="智能"
           ><span>智能</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center"><!----><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/bxd.png" alt="不限定"
           ><span>不限定</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center"><span class="tip-word flex-center"
                                                                             >新</span><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/lbxzs.png" alt="六边形战士"
           ><span>六边形战士</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center"><span class="tip-word flex-center"
                                                                             >热</span><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/ysgqh.png" alt="艺术感强化"
           ><span>艺术感强化</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center"><span class="tip-word flex-center"
                                                                             >新</span><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/3d_jmfg.png" alt="3D建模风格"
           ><span>3D建模风格</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center"><span class="tip-word flex-center"
                                                                             >新</span><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/youxi_icon.jpg" alt="游戏卡通"
           ><span>游戏卡通</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center"><span class="tip-word flex-center"
                                                                             >新</span><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/pksf.png" alt="皮克斯风"
           ><span>皮克斯风</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center"><!----><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/yh.png" alt="油画"
           ><span>油画</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center"><!----><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/xhyq.png" alt="虚幻引擎渲染"
           ><span>虚幻引擎渲染</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center"><!----><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/qbsm.png" alt="铅笔素描"
           ><span>铅笔素描</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center" style=""><!----><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/schh.png" alt="水彩绘画"
           ><span>水彩绘画</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center" style=""><!----><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/1950nd.png"
            alt="1950年代纸浆科幻封面"><span>1950年代纸浆科幻封面</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center" style=""><!----><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/xhc.png" alt="新海诚"
           ><span>新海诚</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center" style=""><!----><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/Victo_Ngai.png" alt="倪传婧"
           ><span>倪传婧</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center" style=""><!----><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/xsh.png" alt="像素画"
           ><span>像素画</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center" style=""><!----><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/zgf.png" alt="中国画"
           ><span>中国画</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center" style=""><!----><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/sbpk.png" alt="赛博朋克"
           ><span>赛博朋克</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center" style=""><!----><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/jpl.png" alt="吉卜力"
           ><span>吉卜力</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="selected-style-option-item style-option-item flex-center" style=""><!----><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/zqb.png" alt="蒸汽波"
           ><span>蒸汽波</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center" style=""><!----><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/yxzy.png" alt="印象主义"
           ><span>印象主义</span></div>
        </div>
      </div>
      <div class="flex-center" style="height: 30px;">
        <button class="style-more-btn flex-center rotate"><i class="el-icon">
          <svg viewBox="0 0 1024 1024" xmlns="http://www.w3.org/2000/svg">
            <path fill="currentColor"
                  d="M104.704 338.752a64 64 0 0 1 90.496 0l316.8 316.8 316.8-316.8a64 64 0 0 1 90.496 90.496L557.248 791.296a64 64 0 0 1-90.496 0L104.704 429.248a64 64 0 0 1 0-90.496z"></path>
          </svg>
        </i></button>
      </div><!----><!----><!---->
      <div class="heading"> ✳ 画家设置（单选）</div>
      <div class="el-row style-options" style="margin-left: -5px; margin-right: -5px;">
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="selected-style-option-item style-option-item flex-center"><!----><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/bxd.png" alt="不限定"
           ><span>不限定</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center"><!----><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/msr_xjr.png" alt="马塞尔·夏加尔"
           ><span>马塞尔·夏加尔</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center"><!----><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/csl.png" alt="村上隆"
           ><span>村上隆</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center"><!----><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/mx.png" alt="穆夏"
           ><span>穆夏</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center"><!----><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/bjs.png" alt="毕加索"
           ><span>毕加索</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center"><!----><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/fg.png" alt="梵高"
           ><span>梵高</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center"><!----><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/nm.png" alt="莫奈"
           ><span>莫奈</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center"><!----><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/bl_ss.png" alt="保罗·塞尚"
           ><span>保罗·塞尚</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center"><!----><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/tms_kr.png" alt="托马斯·科尔"
           ><span>托马斯·科尔</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="style-option-item flex-center"><!----><img
            src="https://yijian-painting-prod.cdn.bcebos.com/static/styles/style_type1/mbws.png" alt="莫比乌斯"
           ><span>莫比乌斯</span></div>
        </div>
      </div><!----><!---->
      <div class="heading flex-between"> ✳ 画面描述</div>
      <form class="el-form el-form--default el-form--label-right">
        <div class="el-form-item is-error is-required asterisk-left" style="margin-bottom: 50px;">
          <!--v-if-->
          <div class="el-form-item__content">
            <div class="el-textarea el-input--suffix"><!-- input --><!-- textarea --><textarea
              class="el-textarea__inner" maxlength="1024" tabindex="0" autocomplete="off"
              placeholder="请输入您对画面的描述词" id="el-id-7281-11"
              style="min-height: 139.2px; height: 139.2px;"></textarea><span class="el-input__count">0 / 1024</span>
            </div>
            <div class="el-form-item__error">请输入描述</div>
          </div>
        </div>
        <div class="w-full absolute -bottom-12 flex justify-end">
          <div class="px-4 bg-base-100 text-base-200 text-sm py-[6px] rounded-full mr-4 cursor-pointer tracking-[1px]"
              >水晶球城堡
          </div>
          <div class="px-4 bg-base-100 text-base-200 text-sm py-[6px] rounded-full mr-4 cursor-pointer tracking-[1px]"
              >美貌少年
          </div>
          <div class="px-4 bg-base-100 text-base-200 text-sm py-[6px] rounded-full mr-4 cursor-pointer tracking-[1px]"
              >壮丽的树
          </div>
          <div class="px-4 bg-base-100 text-base-200 text-sm py-[6px] rounded-full mr-4 cursor-pointer tracking-[1px]"
              >半机械马
          </div><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!---->
          <!----><!---->
          <button
            class="el-button iconfont icon-refresh !text-2xl !bg-transparent !border-none hover:!text-white focus:!text-white"
            aria-disabled="false" type="button"><!--v-if--><!--v-if--></button>
        </div>
      </form>
      <div class="heading flex-between !mt-32">✳ 图片比例</div>
      <div class="el-row is-justify-space-between size-options"
           style="margin-left: -16px; margin-right: -16px;">
        <div class="el-col el-col-48 is-guttered" style="padding-right: 16px; padding-left: 16px;">
          <div class="selected-size-option-item size-options-item text-center">
            <div class="w-full h-[80px] flex justify-center items-center p-2">
              <div class="rounded-md bg-[#333333] w-full colorful-bg"
                   style="aspect-ratio: 1.33333 / 1;"></div>
            </div>
            <span class="h-[50px] mt-auto flex justify-center items-center text-base tracking-[1px] colorful-text"
                 >4:3</span></div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 16px; padding-left: 16px;">
          <div class="size-options-item text-center">
            <div class="w-full h-[80px] flex justify-center items-center p-2">
              <div class="rounded-md bg-[#333333] h-full" style="aspect-ratio: 0.75 / 1;"></div>
            </div>
            <span class="h-[50px] mt-auto flex justify-center items-center text-base tracking-[1px]">3:4</span>
          </div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 16px; padding-left: 16px;">
          <div class="size-options-item text-center">
            <div class="w-full h-[80px] flex justify-center items-center p-2">
              <div class="rounded-md bg-[#333333] h-full" style="aspect-ratio: 1 / 1;"></div>
            </div>
            <span class="h-[50px] mt-auto flex justify-center items-center text-base tracking-[1px]">1:1</span>
          </div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 16px; padding-left: 16px;">
          <div class="size-options-item text-center">
            <div class="w-full h-[80px] flex justify-center items-center p-2">
              <div class="rounded-md bg-[#333333] w-full" style="aspect-ratio: 1.77778 / 1;"></div>
            </div>
            <span class="h-[50px] mt-auto flex justify-center items-center text-base tracking-[1px]">16:9</span>
          </div>
        </div>
        <div class="el-col el-col-48 is-guttered" style="padding-right: 16px; padding-left: 16px;">
          <div class="size-options-item text-center">
            <div class="w-full h-[80px] flex justify-center items-center p-2">
              <div class="rounded-md bg-[#333333] h-full" style="aspect-ratio: 0.5625 / 1;"></div>
            </div>
            <span class="h-[50px] mt-auto flex justify-center items-center text-base tracking-[1px]">9:16</span>
          </div>
        </div>
      </div>
      <div class="heading flex-between">✳ 清晰度</div>
      <div class="el-row size-options" style="margin-left: -5px; margin-right: -5px;">
        <div class="el-col el-col-8 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="uiverse flex-center"><span class="text-sm tracking-[1px]"
                                                                   >普通</span></div>
        </div>
        <div class="el-col el-col-8 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="uiverse flex-center"><span class="text-sm tracking-[1px]">高清 丨 +1积分</span>
          </div>
        </div>
        <div class="el-col el-col-8 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="isSelected uiverse flex-center"><span
            class="text-sm tracking-[1px] colorful-text">精绘 丨 +4积分</span></div>
        </div>
        <div class="el-col el-col-8 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="uiverse flex-center"><span class="text-sm tracking-[1px]">超精绘 丨 +15积分</span>
          </div>
        </div>
      </div>
      <div class="small-title flex-between tracking-[1px]"> 专家模式 <label class="switch"
                                                                                              ><input
        type="checkbox"><span class="slider"><span class="circle"
                                                                                        ></span></span></label>
      </div><!---->
      <div class="heading w-full flex justify-between"> 作品数量</div>
      <div class="el-row size-options" style="margin-left: -5px; margin-right: -5px;">
        <div class="el-col el-col-8 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="uiverse flex-center"><span class="text-base">1</span></div>
        </div>
        <div class="el-col el-col-8 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="uiverse flex-center"><span class="text-base">2</span></div>
        </div>
        <div class="el-col el-col-8 is-guttered" style="padding-right: 5px; padding-left: 5px;">
          <div class="isSelected uiverse flex-center"><span class="text-base colorful-text"
                                                                              >4</span></div>
        </div>
      </div>
      <div class="heading">通道设置</div>
      <div class="passage-options flex-start tracking-[1px]">
        <div class="passage-options-item flex-between colorful-border"><span
         >常规通道</span><span> 暂无排队</span></div>
        <div class="passage-options-item flex-between"><span>VIP通道</span><span
         >+2积分一次/暂无排队</span></div>
      </div>
      <div class="text-base text-base-200 mt-4"> *使用意间AI绘画服务表示您已同意<a
        class="colorful-text" href="http://www.yjai.art/agreement.html" target="_blank"
       >《意间AI用户协议》</a></div>
      <div class="text-base text-base-200 mb-8">
        *生成的图片已部署追踪码，仅限娱乐使用，严禁用于非法途径。
      </div>
      <div class="submit">
        <div class="el-row" style="margin-left: -5px; margin-right: -5px; height: 48px;">
          <div class="el-col el-col-12 is-guttered" style="padding-right: 5px; padding-left: 5px;">
            <div class="flex items-center text-lg h-full tracking-[1px]"> 消耗 20 <img
              class="w-6 h-6 ml-1" src="/assets/crown-007e5c38.svg" alt=""></div>
          </div>
          <div class="el-col el-col-12 is-guttered" style="padding-right: 5px; padding-left: 5px;">
            <button class="button">
              <div class="button-wrapper"><span class="tracking-[1px] text-lg"> 开始绘画 </span>
              </div>
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {mapGetters} from 'vuex'
import {getGoodsList, createOrder, checkPay} from '@/api/order'
import vueQr from 'vue-qr'
import Text from "@/views/index/components/Text.vue";

export default {
  components: {Text, vueQr},
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

    i, span {
      position: absolute;
      bottom: 0;
      display: none;
      width: 20px;
      height: 20px;
      background: #454f64;
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

      i, span {
        display: block;
        background: #fff;
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

    ul, li {
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
      display: flex;

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
            position: relative;
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

  .el-checkbox__input.is-checked + .el-checkbox__label {
    color: #606266;
  }

  .el-checkbox__inner:hover {
    border-color: #10a37f;
  }
}
</style>
