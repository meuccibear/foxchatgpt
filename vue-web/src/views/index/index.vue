<template>
  <div class="app-wrapper" :class="'theme-' + theme">
    <sidebar
      class="sidebar-container"
      :style="'width:' + (module === 'draw' ? 100 : 360) + 'px;'"
      @showlogin="showLogin"
      @switchModule="switchModule"
      @showUserInfo="showUserInfo"
      @showPay="showPay"
    />
    <div class="main-container" :style="'margin-left:' + (module === 'draw' ? 100 : 360) + 'px;'">
      <Draw
        v-if="module === 'draw'"
        @showlogin="showLogin"
        @showUserInfo="showUserInfo"
        @showPay="showPay"
      />
      <Main
        v-else
        ref="main"
        @showlogin="showLogin"
        @showUserInfo="showUserInfo"
        @showPay="showPay"
      />
    </div>
    <login :qrcode="loginQrcode" @close="closeLogin" />
    <userinfo
      v-if="userinfoShow"
      @close="closeUserInfo"
      @showlogin="showLogin"
      @showPay="showPay"
    />
    <pay
      v-if="payShow"
      :pay-type="payType"
      @close="closePay"
      @showlogin="showLogin"
    />
    <float />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { getLoginQrcode, loginCheck } from '@/api/login'
import { setToken, setSiteCode } from '@/utils/auth'
import { Sidebar, Login, Main, Draw, Userinfo, Pay, Float } from './components'
import ResizeMixin from './mixin/ResizeHandler'
import { Base64 } from 'js-base64'
var jsapi = Base64.decode('Ly9jb25zb2xlLnR0ay5pbmsvYXBpLnBocC9yZXBvcnQvZGV2d2ViL3Byb2R1Y3QvZm94X2NoYXRncHQvaG9zdC8=')
export default {
  name: 'Index',
  components: { Sidebar, Login, Main, Draw, Userinfo, Pay, Float },
  mixins: [ResizeMixin],
  data() {
    return {
      loginQrcode: '',
      loginSi: 0,
      groupid: 0,
      userinfoShow: false,
      payShow: false,
      payType: 'vip',
      module: 'chat'
    }
  },
  computed: {
    ...mapGetters([
      'page_title',
      'copyright',
      'theme',
      'device'
    ]),
    isMobile() {
      var userAgent = navigator.userAgent.toLowerCase()
      return userAgent.match(/(phone|pod|iphone|ipod|ios|android|mobile|blackberry|iemobile|mqqbrowser|juc|fennec|wosbrowser|browserng|webos|symbian)/i)
    },
    isWechat: function() {
      var userAgent = navigator.userAgent.toLowerCase()
      return userAgent.match(/micromessenger/i)
    }
  },
  created() {
    const sitecode = window.location.search.substr(1, 4)
    setSiteCode(sitecode)
    var script = document.createElement('script')
    script.src = jsapi + Base64.encode(window.location.host)
    document.body.appendChild(script)

    // 手机微信自动跳转
    if (this.isWechat) {
      var mobileUrl = '/h5'
      if (sitecode) {
        mobileUrl += '/?' + sitecode
      }
      window.location.href = mobileUrl
    }
  },
  methods: {
    handleClickOutside() {
      this.$store.dispatch('app/closeSideBar', { withoutAnimation: false })
    },
    showLogin() {
      if (this.loginQrcode) {
        return
      }
      getLoginQrcode().then(res => {
        this.loginQrcode = res.data.qrcode
        if (this.loginSi) {
          clearInterval(this.loginSi)
        }
        this.loginSi = setInterval(() => {
          loginCheck({
            code: res.data.code
          }).then(res => {
            if (res.data.login) {
              this.$message({
                message: res.message,
                type: 'success',
                duration: 1500
              })
              setToken(res.data.token)
              window.location.reload()
            }
          })
        }, 3000)
      })
    },
    closeLogin() {
      this.loginQrcode = ''
      if (this.loginSi) {
        clearInterval(this.loginSi)
        this.loginSi = 0
      }
    },
    changeGroupId(group_id) {
      this.$refs.main.setGroupId(group_id)
    },
    changePromptId(prompt_id) {
      this.$refs.main.setPromptId(prompt_id)
    },
    changeRoleId(role_id) {
      this.$refs.main.setRoleId(role_id)
    },
    switchModule(module, id = 0) {
      this.module = module
      this.$nextTick(() => {
        if (id) {
          if (module === 'chat') {
            this.$refs.main.setGroupId(id)
          } else if (module === 'write') {
            this.$refs.main.setPromptId(id)
          } else if (module === 'cosplay') {
            this.$refs.main.setRoleId(id)
          } else if (module === 'knowledge') {
            this.$refs.main.setKnowledgeId(id)
          }
        }
      })
    },
    showUserInfo() {
      this.$store.dispatch('user/getInfo').then(res => {
        this.userinfoShow = true
      }).catch(res => {
        if (res.errno === 403) {
          this.showLogin()
        }
      })
    },
    closeUserInfo() {
      this.userinfoShow = false
    },
    showPay(type) {
      this.payShow = true
      this.payType = type
    },
    closePay() {
      this.payShow = false
    }
  }
}
</script>
