<template>
  <div class="wrapper" :class="{gold: module === 'chat' && chatModel === 'gpt-4'}">
    <div class="tab-model" v-if="module === 'chat' && hasModel4">
      <div class="tab-item" :class="{active: chatModel === 'default'}" @click="switchChatModel('default')" style="border-top-right-radius: 0; border-bottom-right-radius: 0;">默认</div>
      <div class="tab-item" :class="{active: chatModel === 'gpt-4'}" @click="switchChatModel('gpt-4')" style="border-top-left-radius: 0; border-bottom-left-radius: 0;">{{ model4Name }}</div>
    </div>
    <template v-if="module !== 'knowledge'" >
      <div
        v-if="lists && lists.length > 0"
        class="box-msg-list"
        :class="{'style-chat': module === 'chat' || module === 'cosplay', 'style-write': module === 'write' || module === 'draw'}">
        <el-scrollbar
          ref="msglist"
          wrap-class="scrollbar-wrapper"
        >
          <div class="list">
            <div v-for="(item, index) in lists" class="row" :class="item.user === 'AI'? 'row-ai' : 'row-user'">
              <div v-if="item.user === 'AI'" class="message">
                <div class="avatar">
                  <img :src="aiAvatar">
                </div>
                <div class="text markdown-body">
                  <textComponent
                    :text="item.message"
                  />
                  <div class="tools">
                    <span
                      v-clipboard:copy="textFormat(item.message)"
                      v-clipboard:success="onCopySuccess"
                      v-clipboard:error="onCopyError"
                      class="copy text-primary"
                    >复制内容</span>
                  </div>
                </div>
              </div>
              <div v-else class="message">
                <div class="avatar" style="background: #9aa37e;">
                  <img :src="avatar || '/static/img/ic_user.png'">
                </div>
                <div class="text markdown-body">
                  <textComponent
                    :text="item.message"
                  />
                </div>
              </div>
              <div style="clear: both"></div>
            </div>
            <div v-if="writing || writingText" class="row row-ai">
              <div class="message">
                <div class="avatar"><img :src="aiAvatar"></div>
                <div class="text markdown-body">
                  <textComponent
                    :text="writingText"
                    :writing="!!(writing || writingText)"
                  />
                </div>
              </div>
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
          <div class="tools">
            <div
              v-for="(item, index) in langs"
              class="item"
              :class="{active: userCache.lang.indexOf(item) > -1 }"
              @click="changeLang(item)"
            >
              <a href="javascript:;">{{ item }}</a>
            </div>
          </div>
          <el-input
            v-model="message"
            :placeholder="placeHolder"
            type="textarea"
            :autosize="{ minRows: 1, maxRows: 8 }"
            maxlength="3000"
            @keyup.enter.native="onEnter"
          />
          <el-button
            class="btn-send"
            type="default"
            :loading="writing"
            icon="el-icon-position"
            @click="sendText"
          />
        </div>

        <custom-edit ref="edit" :checkboxData="knowledgeBase" :data="userCache.knowledgeBaseCheckData" @ok="okEdit"/>
        <Copyright />
      </div>
    </template>

    <div v-else >
      <welcome
        :tutorial="false"
        :page-title="page_title"
        @use="quickMessage"
      />
    </div>

  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { getChatHistoryMsg } from '@/api/chat'
import { getWriteHistoryMsg, getPrompt } from '@/api/write'
import { getCosplayHistoryMsg, getRole } from '@/api/cosplay'
import { getToken, getSiteCode } from '@/utils/auth'
import TextComponent from './Message/Text'
import Welcome from './Welcome'
import Copyright from './Copyright'
import { getLibs } from '@/api/retrieval'
import CustomEdit from './Sidebar/customEdit'


import 'katex/dist/katex.min.css'
import '@/styles/lib/tailwind.css'
import '@/styles/lib/highlight.scss'
import '@/styles/lib/github-markdown.scss'
import {saveGroup} from "@/api/group";

var textStacks = []
var textOutputSi = 0

export default {
  name: 'Main',
  components: {CustomEdit, TextComponent, Welcome, Copyright },
  data() {
    let userCache = {
      lang: [],
      knowledgeBaseCheckData: []
    }
    return {
      inputB: true,
      module: 'chat',
      chatModel: 'default',
      group_id: 0,
      lists: [],
      message: '',
      writingText: '',
      writing: false,
      page: 1,
      pagesize: 10,
      prompt_id: 0,
      writePrompt: {},
      role_id: 0,
      cosplayRole: {},
      userCache: userCache,
      knowledgeBase: [],
      langs: ['联网', '知识库'],
      formRules: {
        title: [
          { required: true, message: '此项必填', trigger: 'blur' }
        ],
        desc: [
          { required: true, message: '此项必填', trigger: 'blur' }
        ]
      }
    }
  },
  computed: {
    ...mapGetters([
      'avatar',
      'nickname',
      'page_title',
      'hasModel4',
      'model4Name'
    ]),
    aiAvatar() {
      var avatar = '/static/img/ic_ai.png'
      if (this.module === 'cosplay') {
        avatar = this.cosplayRole.thumb || '/static/img/avatar_cosplay.png'
      }
      return avatar
    },
    placeHolder() {
      var placeholder = '输入您的问题，按 Ctrl+回车 发送'
      if (this.module === 'write') {
        if (this.writePrompt && this.writePrompt.hint) {
          placeholder = this.writePrompt.hint
        }
      } else if (this.module === 'cosplay') {
        if (this.cosplayRole && this.cosplayRole.hint) {
          placeholder = this.cosplayRole.hint
        }
      }
      return placeholder
    }
  },
  created (){
    getLibs().then(response => {
      this.knowledgeBase =  response.data
      console.log('this.knowledgeBase:', JSON.stringify(this.knowledgeBase))
    })
    let userCache = localStorage.getItem('UserCache');
    if(userCache){
      this.userCache = JSON.parse(userCache)
    }
  },
  methods: {
    okEdit (val) {
      if(val){
        this.userCache.knowledgeBaseCheckData = val
        console.log(val)
        this.cache()
        this.changeLang()
      }
    },
    saveKnowledgeBaseEdit(group) {
      console.log("group", group)
    },
    changeLang(lang) {
      if (lang) {
        if (this.langs[1] === lang) {
          this.$refs.edit.visible = true
          return
        }
        const index = this.userCache.lang.indexOf(lang)
        if ( index > -1) {
          this.userCache.lang.splice(index, 1)
        } else {
          this.userCache.lang.push(lang)
        }
        // this.inputShow = true
      } else {
        const lan = this.langs[1]
        const index = this.userCache.lang.indexOf(lan)
        if (this.userCache.knowledgeBaseCheckData.length != 0){
          if (index === -1){
            console.log('添加了')
            this.userCache.lang.push(lan)
          }
        } else if (index > -1) {
          this.userCache.lang.splice(index, 1)
        }
      }
      this.cache()
    },
    cache: function (){
      console.log('cache:', JSON.stringify(this.userCache))
      localStorage.setItem('UserCache', JSON.stringify(this.userCache))
      // uni.setStorage({
      //   key: 'UserCache',
      //   data: this.userCache
      // })
    },
    async sendText() {
      if (this.writing || this.writingText) {
        return
      }
      const message = this.trim(this.message)
      if (!message) {
        this.$message.error('请输入您的问题')
        this.message = ''
        return
      }

      console.log('checkedItem:', this.userCache)
      let to = []
      for (let item in this.userCache.lang) {
        if (this.userCache.lang[item] === this.langs[0]) {
          to.push('internetsearch')
        } else {
          for (let itemSon in this.userCache.knowledgeBaseCheckData) {
            to.push('repodb:' + this.userCache.knowledgeBaseCheckData[itemSon])
          }
        }
      }

      if (textOutputSi) {
        clearInterval(textOutputSi)
        textOutputSi = 0
        textStacks = []
      }

      this.lists.push({
        user: '我',
        message: message
      })
      this.message = ''
      this.writing = true
      this.scrollBottom()

      const headers = new Headers()
      headers.append('Content-Type', 'application/json')
      headers.append('X-token', getToken() || '')
      headers.append('X-site', getSiteCode() || '')
      const url = process.env.VUE_APP_BASE_API + '/chat/sendText'
      const data = {
        message: message,
        tools: to
      }
      if (this.module === 'chat') {
        data.group_id = this.group_id
        data.model = this.chatModel
      } else if (this.module === 'write') {
        data.prompt_id = this.prompt_id
      } else if (this.module === 'cosplay') {
        data.role_id = this.role_id
      }
      const response = await fetch(url, {
        method: 'POST',
        headers: headers,
        body: JSON.stringify(data)
      })
      if (!response.ok) {
        this.writing = false
        this.$message.error(response.statusText)
        return
      }
      const reader = response.body.getReader()
      const decoder = new TextDecoder('utf-8')
      let done = false
      const curAiMsg = ''

      // eslint-disable-next-line require-atomic-updates
      textOutputSi = setInterval(() => {
        if (textStacks.length > 0) {
          this.writingText += textStacks.shift()
          this.scrollBottom()
        } else if (!this.writing) {
          clearInterval(textOutputSi)
          textOutputSi = 0
          if (this.writingText) {
            this.lists.push({
              user: 'AI',
              message: this.writingText
            })
          }
          this.writingText = ''
          this.scrollBottom()
        }
      }, 35)

      while (!done) {
        this.scrollBottom()
        const { value, done: readerDone } = await reader.read()
        if (value) {
          const char = decoder.decode(value)
          if (char === '\n' && curAiMsg.endsWith('\n')) {
            continue
          }
          if (char) {
            if (char.indexOf('[error]') !== -1) {
              this.writing = false
              this.writingText = ''
              this.lists.pop()
              const error = char.replace('[error]', '')
              if (error.indexOf('请登录') !== -1) {
                this.$emit('showlogin')
                setTimeout(() => {
                  this.$message.error(error)
                }, 500)
              } else if (error.indexOf('请充值') !== -1) {
                this.$emit('showPay', 'vip')
                setTimeout(() => {
                  this.$message.error(error)
                }, 500)
              } else {
                this.$alert(error, '系统提示')
              }
              break
            }
            // char = char.replaceAll("\n", "<br>");
            this.writing = true
            // this.writingText += char;
            for (var i = 0; i < char.length; i++) {
              textStacks.push(char[i])
            }
            // console.log(textStacks)
          }
        }
        done = readerDone
      }
      this.writing = false
    },
    switchChatModel(name) {
      if (this.chatModel === name) {
        this.scrollTop += 1;
        return;
      }
      if (this.writing) {
        this.$message.warning('输出中，请稍等')
        return;
      }
      if (name === 'gpt-4') {
        this.$confirm(this.model4Name + '功能更强大，但成本很高，所以单独计费，可在个人中心查看余额或充值', '提示', {
          confirmButtonText: '我已知悉，继续使用',
          showClose: false,
          showCancelButton: false,
          type: 'warning'
        }).then(() => {
          this.chatModel = name;
          this.page = 1
          this.getHistoryMsg()
        })
      } else {
        this.chatModel = name;
        this.page = 1
        this.getHistoryMsg()
      }
    },
    setGroupId(group_id) {
      this.module = 'chat'
      this.group_id = group_id
      this.page = 1
      this.getHistoryMsg()
    },
    setPromptId(prompt_id) {
      this.module = 'write'
      this.prompt_id = prompt_id
      this.page = 1
      this.getPrompt()
      this.getHistoryMsg()
    },
    setRoleId(role_id) {
      this.module = 'cosplay'
      this.role_id = role_id
      this.page = 1
      this.getRole()
      this.getHistoryMsg()
    },
    setKnowledgeId(group_id) {
      this.module = 'knowledge'
      this.group_id = group_id
      this.page = 1
      this.getHistoryMsg()
    },
    getHistoryMsg() {
      if (this.module === 'chat') {
        this.getChatHistoryMsg()
      } else if (this.module === 'write') {
        this.getWriteHistoryMsg()
      } else if (this.module === 'cosplay') {
        this.getCosplayHistoryMsg()
      } else if (this.module === 'knowledge'){
        this.lists = []
        this.inputB = false
      }
    },
    getChatHistoryMsg() {
      getChatHistoryMsg({
        group_id: this.group_id,
        model: this.chatModel,
        page: this.page,
        pagesize: this.pagesize
      }).then(res => {
        this.lists = res.data.list
        this.$nextTick(() => {
          this.scrollBottom()
        })
      })
    },
    getWriteHistoryMsg() {
      getWriteHistoryMsg({
        prompt_id: this.prompt_id,
        page: this.page,
        pagesize: this.pagesize
      }).then(res => {
        this.lists = res.data
        this.$nextTick(() => {
          this.scrollBottom()
        })
      })
    },
    getCosplayHistoryMsg() {
      getCosplayHistoryMsg({
        role_id: this.role_id,
        page: this.page,
        pagesize: this.pagesize
      }).then(res => {
        this.lists = res.data
        this.$nextTick(() => {
          this.scrollBottom()
        })
      })
    },
    getPrompt() {
      getPrompt({
        prompt_id: this.prompt_id
      }).then(res => {
        this.writePrompt = res.data
      })
    },
    getRole() {
      getRole({
        role_id: this.role_id
      }).then(res => {
        this.cosplayRole = res.data
      })
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
    onEnter(e) {
      if (e.ctrlKey) {
        this.message = this.trim(this.message)
        this.sendText()
      }
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
    }
  }
}
</script>
<style lang="scss">
.scrollbar-wrapper {
  height: 100%;
  overflow-x: hidden;
}
// fix css style bug in open el-dialog
.el-popup-parent--hidden {
  .fixed-header {
    padding-right: 15px;
  }
}
.input .el-textarea__inner {
  padding: 10px 60px 10px 15px;
  letter-spacing: 1px;
  transition: all 0.1s ease-in-out;
  font-size: 16px;
}

.input .tools__inner {
  padding: 10px 60px 10px 15px;
  letter-spacing: 1px;
  transition: all 0.1s ease-in-out;
  font-size: 16px;
}

</style>

<style lang="scss">
.markdown-body {
  display: block;
  width: 100%;
  background-color: transparent;
  font-size: 14px;
  box-sizing: border-box;

  p {
    white-space: pre-wrap;
    text-align: left;
    &:last-child {
      margin-bottom: 0;
    }
  }

  img[alt=cursor] {
    width: 5px;
    height: 20px;
    position: relative;
    top: 4px;
    left: 2px;
  }

  ol {
    list-style-type: decimal;
  }

  ul {
    list-style-type: disc;
  }

  pre code,
  pre tt {
    line-height: 1.6;
    font-size: 16px;
  }

  .highlight pre,
  pre {
    //background-color: #fff;
    background-color: #edeff2;
    margin-top: 16px;
    transition: background 0.1s ease-in-out;
  }

  code.hljs {
    padding: 0;
  }

  .code-block {
    &-wrapper {
      position: relative;
      padding-top: 24px;
    }

    &-header {
      position: absolute;
      top: 5px;
      right: 0;
      width: 100%;
      padding: 0 1rem;
      display: flex;
      justify-content: flex-end;
      align-items: center;
      color: #b3b3b3;

      &__copy {
        cursor: pointer;
        margin-left: 0.5rem;
        user-select: none;

        &:hover {
          color: #65a665;
        }
      }
    }
  }

  .code-block-wrapper {
    display: block;
    width: 100%
  }

}

.input .tools {
  width: 100%;
  height: 46px;
  //margin-bottom: 4px;
  box-sizing: border-box;
  //padding-top: 10px;
  padding: 10px 10px;
}

.input .tools .item {
  width: auto;
  //height: 46px;
  line-height: 26px;
  background: #fff;
  font-size: 14px;
  border-radius: 10px;
  border: 1px solid #ddd;
  color: #444;
  float: left;
  margin-right: 5px;
  position: relative;
  overflow: visible;
  padding: 0 10px;
}

.box-input .tools .item .ic_sj {
  width: 24rpx;
  height: 12rpx;
  position: absolute;
  left: 50%;
  margin-left: -12rpx;
  bottom: -12rpx;
  display: none;
}

.box-input .tools .item.active {
  border-color: #04BABE;
}

.box-input .tools .item.active .ic_sj {
  display: block;
}

.box-input .tools .item:active {
  background-color: #fafafa;
}

.box-input .tools .close {
  float: right;
  margin-right: 0;
  background: none;
  border: none;
  transform: rotate(180deg);
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.5s;
}

</style>
