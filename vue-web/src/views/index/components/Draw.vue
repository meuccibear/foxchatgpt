<template>
  <div :class="{'size-big': drawSetting['channel'] === 'yijian', 'size-small': drawSetting['channel'] !== 'yijian'}">
    <div class="draw-setting">
      <div class="module-body">
        <drawYijian
          ref="drawSetting"
          v-if="drawSetting['channel'] === 'yijian'"
          :options="drawSetting['options']"
          @showPay="showPay"
        ></drawYijian>
        <drawLxai
          ref="drawSetting"
          v-if="drawSetting['channel'] === 'lxai'"
          @showPay="showPay"
        ></drawLxai>
        <drawOpenai
          ref="drawSetting"
          v-if="drawSetting['channel'] === 'openai' || drawSetting['channel'] === 'api2d'"
          @showPay="showPay"
        ></drawOpenai>
      </div>
      <div class="module-footer">
        <div class="box-wallet" @click="showPay('draw')">
          <div class="desc">
            <svg-icon class="icon" icon-class="ic_mod_draw"></svg-icon>
            当前绘画余额<span>{{ user_balance_draw }}</span>张
          </div>
        </div>
      </div>
    </div>


    <div class="wrapper">
      <div v-if="lists && lists.length > 0" class="box-msg-list style-write">
        <el-scrollbar ref="msglist" wrap-class="scrollbar-wrapper">
          <div class="list">
            <div v-for="(item, index) in lists" class="row">
              <div class="message row-user" style="padding-bottom: 15px;">
                <div class="avatar" style="background: #9aa37e;">
                  <img :src="avatar || '/static/img/ic_user.png'">
                </div>
                <div class="text markdown-body" style="padding-top: 3px;">
                  {{ item.message }}
                </div>
              </div>
              <div class="message row-ai" style="padding-top: 15px;">
                <div class="avatar">
                  <img src="/static/img/ic_ai.png">
                </div>
                <div class="text markdown-body">
                  <imageComponent
                    :item="item"
                    @retry="retryDraw"
                    @mjCtrl="mjCtrl"
                  />
                </div>
              </div>
              <div style="clear: both"></div>
            </div>
          </div>
        </el-scrollbar>
      </div>

      <welcome
        v-else
        :page-title="page_title"
        @use="quickMessage"
      />

      <div class="box-input">
        <div class="input">
          <el-input
            v-model="message"
            placeholder="输入画面描述，按回车发送"
            type="textarea"
            :autosize="{ minRows: 1, maxRows: 8 }"
            maxlength="3000"
            @keyup.enter.native="submitTask"
          />
          <el-button
            class="btn-send"
            type="default"
            icon="el-icon-position"
            @click="submitTask"
          />
        </div>

        <Copyright />
      </div>
    </div>
  </div>

</template>

<script>
import { mapGetters } from 'vuex'
import { getUserBalance } from '@/api/user'
import { submitTask, mjCtrl, getHistoryMsg, getDrawResult, getDrawSetting } from '@/api/draw'
import ImageComponent from './Message/Image'
import Welcome from './Welcome'
import Copyright from './Copyright'
import drawYijian from './Draw/yijian'
import drawLxai from './Draw/lxai'
import drawOpenai from './Draw/openai'

export default {
  name: 'Draw',
  components: { drawYijian, drawLxai, drawOpenai, ImageComponent, Welcome, Copyright },
  data() {
    return {
      lists: [],
      message: '',
      page: 1,
      pagesize: 10,
      drawSetting: {},
      user_balance_draw: 0
    }
  },
  computed: {
    ...mapGetters([
      'avatar',
      'nickname',
      'page_title'
    ])
  },
  created() {
    this.getDrawSetting()
    this.getHistoryMsg()
    this.getUserBalance()
  },
  methods: {
    getDrawSetting() {
      getDrawSetting().then(res => {
        this.drawSetting = res.data
      })
    },
    getUserBalance() {
      getUserBalance().then(res => {
        this.user_balance_draw = res.data.balance_draw
      })
    },
    submitTask() {
      var message = this.trim(this.message)
      if (!message) {
          this.$message.error('请输入画面描述')
          return
      }

      var options = this.getDrawOptions()
      if (!options || !options.channel) {
        this.$message.error('参数错误')
        return
      }

      this.message = ''
      this.scrollBottom()

      submitTask({
        message: message,
        options: JSON.stringify(options)
      }).then(res => {
        this.lists.push({
          state: 0,
          draw_id: res.data.draw_id,
          message: message
        });

        this.startLoopResult(res.data.draw_id)
        this.getUserBalance()

        setTimeout(() => {
          this.scrollBottom()
        }, 500)
      }).catch(err => {
        if (err.message.indexOf('请充值') !== -1) {
          this.showPay('draw')
          setTimeout(() => {
            this.$message.error(err.message)
          }, 500)
        }
      });
    },

    startLoopResult(draw_id) {
      var si = setInterval(() => {
        getDrawResult({
          draw_id: draw_id
        }).then(res => {
          var lists = this.lists
          lists.forEach((item, index) => {
            if (item.draw_id === draw_id) {
              var state = res.data.state
              lists[index].state = state
              if (state !== 0) {
                clearInterval(si)
                if (state === 1) {
                  lists[index].response = res.data.images
                }
                else if (state === 2) {
                  lists[index].errmsg = res.data.message
                }
                this.lists = lists
                setTimeout(() => {
                  this.scrollBottom()
                  this.getUserBalance()
                }, 300)
              }
            }
          })
        })
      }, 5000)
    },

    retryDraw(draw_id) {
      submitTask({
        draw_id: draw_id
      }).then(res => {
        var lists = this.lists
        lists.forEach((item, index) => {
          if (item.draw_id === draw_id) {
            lists[index].state = 0
            lists[index].errmsg = ''
            lists[index].response = ''
            this.startLoopResult(draw_id)
          }
        })
        this.lists = lists
        this.getUserBalance()
      })
    },
    mjCtrl(draw_id, type, index) {
      mjCtrl({
        draw_id: draw_id,
        type: type,
        index: index
      }).then(res => {

      })
    },
    getHistoryMsg() {
      getHistoryMsg({
        page: this.page,
        pagesize: this.pagesize
      }).then(res => {
        if (res.data.length > 0) {
          var lists = res.data
          this.lists = lists
          if (lists) {
            lists.forEach((item, index) => {
              if (item.state === 0) {
                this.startLoopResult(item.draw_id);
              }
            })
          }
        }
        setTimeout(() => {
          this.scrollBottom();
        }, 500)
      })
    },
    getDrawOptions() {
      if (this.$refs.drawSetting) {
        return this.$refs.drawSetting.getDrawOptions();
      } else {
        return null
      }
    },
    quickMessage(text) {
      this.message = text
    },
    onCopySuccess() {
      this.$message.success('已复制')
    },
    onCopyError() {
      this.$message.error('复制失败')
    },
    trim(str) {
      if (str) {
        str = str.replace(/(^\s*)|(\s*$)/g, '')
      }
      return str
    },
    textFormat(str) {
      str = this.trim(str)
      if (str && typeof str.replaceAll === 'function') {
        str = str.replaceAll('<br>', '\n').replaceAll('&nbsp', ' ')
      }
      return str
    },
    scrollBottom() {
      this.$nextTick(() => {
        if (this.$refs['msglist']) {
          const container = this.$refs['msglist'].wrap;
          setTimeout(() => {
            container.scrollTop = container.scrollHeight
          }, 200)
        }
      })
    },
    toDoc(type) {
      let routeData = this.$router.resolve({ name: 'Doc', query: { type: type }})
      window.open(routeData.href, '_blank')
    },
    showPay(type) {
      this.$emit('showPay', type)
    }
  }
}
</script>
