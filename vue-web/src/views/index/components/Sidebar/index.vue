<template>
  <div>
    <div class="module-list">
      <div class="avatar" @click="showUserInfo">
        <img :src="avatar || '/static/img/no_avatar.png'" :title="nickname || '无昵称'">
      </div>
      <div class="module-item" :class="{active: module === 'chat'}" @click="switchModule('chat')">
        <svg-icon class="icon" icon-class="ic_mod_chat" style="font-size: 26px;" />
        <span>对话</span>
      </div>
      <div class="module-item" :class="{active: module === 'write'}" @click="switchModule('write')">
        <svg-icon class="icon" icon-class="ic_mod_write" style="font-size: 28px;" />
        <span>创作</span>
      </div>
      <div class="module-item" :class="{active: module === 'cosplay'}" @click="switchModule('cosplay')">
        <svg-icon class="icon" icon-class="ic_mod_cosplay" style="font-size: 27px;" />
        <span>模拟</span>
      </div>
      <div class="module-item" :class="{active: module === 'draw'}" @click="switchModule('draw')">
        <svg-icon class="icon" icon-class="ic_mod_draw" style="font-size: 23px;" />
        <span>绘画</span>
      </div>
      <div class="menu-bottom">
        <div class="module-item" @click="toDoc('help')">
          <svg-icon class="icon" icon-class="ic_doc" style="font-size: 24px;" />
          <span>教程</span>
        </div>
        <div v-if="theme === 'light'" class="module-item" title="切换为夜间模式" @click="setTheme('dark')">
          <svg-icon class="icon" icon-class="ic_dark" style="font-size: 18px;" />
        </div>
        <div v-if="theme === 'dark'" class="module-item" title="切换为日间模式" @click="setTheme('light')">
          <svg-icon class="icon" icon-class="ic_light" style="font-size: 22px;" />
        </div>
      </div>
    </div>
    <div class="sub-module">
      <div v-if="module === 'chat'" class="module-chat">
        <div class="module-header">
          <div class="module-title">
            <div class="btn-group-add" @click="editGroup(0)">
              <i class="icon el-icon-plus" />
              <span>创建新会话</span>
            </div>
          </div>
        </div>
        <div class="module-body">
          <el-scrollbar wrap-class="scrollbar-wrapper">
            <div class="group-chat">
              <div v-for="(item, index) in groupList" class="group-item" :class="{active: item.id===activeGroupId}">
                <div class="group-title" @click="changeGroup(item.id)">
                  <i class="icon el-icon-chat-dot-square" />
                  <span>{{ item.title }}</span>
                </div>
                <el-dropdown trigger="click">
                  <span class="el-dropdown-link">
                    <i class="btn-dropdown el-icon-more" />
                  </span>
                  <el-dropdown-menu slot="dropdown">
                    <el-dropdown-item @click.native.stop="editGroup(item.id)">编辑</el-dropdown-item>
                    <el-dropdown-item class="text-danger" @click.native.stop="delGroup(item.id)">删除</el-dropdown-item>
                  </el-dropdown-menu>
                </el-dropdown>
              </div>
            </div>
          </el-scrollbar>
        </div>
      </div>
      <div v-if="module === 'write'" class="module-write">
        <div class="module-header">
          <div class="search">
            <el-input v-model="searchKeyword" placeholder="搜索模型" prefix-icon="el-icon-search" size="large" :clearable="true" autocomplete />
          </div>
        </div>
        <div class="module-body">
          <el-scrollbar wrap-class="scrollbar-wrapper">
            <!--            <div class="group-write">
              <div class="topic-title" v-if="writeVoteList && writeVoteList.length > 0 && !writeVoteHidden">
                <span>我的收藏</span>
              </div>
              <div class="prompt-list" v-if="writeVoteList && writeVoteList.length > 0 && !writeVoteHidden">
                <div class="prompt-item" v-for="prompt in writeVoteList" @click="changePrompt(prompt.id)" :class="{active: activePromptId === prompt.id, hidden: prompt.hidden}">
                  <div class="prompt-title">{{ prompt.title }}</div>
                  <div class="prompt-desc">{{ prompt.desc }}</div>
                  <div class="prompt-ops">
                    <div class="op-item" title="点击量">
                      <svg-icon class="icon" icon-class="ic_view" />
                      {{ prompt.views }}
                    </div>
                    <div class="op-item" title="使用量">
                      <svg-icon class="icon" icon-class="ic_usage" />
                      {{ prompt.usages }}
                    </div>
                    <div class="op-item" title="收藏" @click.stop="doPromptVote(prompt.id)">
                      <svg-icon class="icon" icon-class="ic_vote_active" />
                    </div>
                  </div>
                </div>
              </div>
            </div>-->
            <div v-for="topic in writeTopicList" class="group-write">
              <div v-if="topic.prompts && topic.prompts.length > 0 && !topic.hidden" class="topic-title">
                <span>{{ topic.title }}</span>
              </div>
              <div v-if="topic.prompts && topic.prompts.length > 0 && !topic.hidden" class="prompt-list">
                <div v-for="prompt in topic.prompts" class="prompt-item" :class="{active: activePromptId === prompt.id, hidden: prompt.hidden}" @click="changePrompt(prompt.id)">
                  <div class="prompt-title">{{ prompt.title }}</div>
                  <div class="prompt-desc">{{ prompt.desc }}</div>
                  <div class="prompt-ops">
                    <div class="op-item" title="点击量">
                      <svg-icon class="icon" icon-class="ic_view" />
                      {{ prompt.views }}
                    </div>
                    <div class="op-item" title="使用量">
                      <svg-icon class="icon" icon-class="ic_usage" />
                      {{ prompt.usages }}
                    </div>
                    <div class="op-item" title="收藏" @click.stop="doPromptVote(prompt.id)">
                      <svg-icon v-if="prompt.isVote === 1" class="icon" icon-class="ic_vote_active" />
                      <svg-icon v-else class="icon" icon-class="ic_vote" />
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </el-scrollbar>
        </div>
      </div>
      <div v-if="module === 'cosplay'" class="module-cosplay">
        <div class="module-header">
          <div class="search">
            <el-input v-model="searchKeyword" placeholder="搜索角色" prefix-icon="el-icon-search" size="large" :clearable="true" autocomplete />
          </div>
        </div>
        <div class="module-body">
          <el-scrollbar wrap-class="scrollbar-wrapper">
            <div v-for="group in cosplayRoleList" class="group-cosplay">
              <div v-if="group.roles && group.roles.length > 0 && !group.hidden" class="type-title">
                <span>{{ group.title }}</span>
              </div>
              <div v-if="group.roles && group.roles.length > 0 && !group.hidden" class="role-list">
                <div v-for="role in group.roles" class="role-item" :class="{active: activeRoleId === role.id, hidden: role.hidden}" @click="changeRole(role.id)">
                  <div class="thumb">
                    <img v-if="role.thumb" :src="role.thumb" alt="">
                    <img v-else src="/static/img/avatar_cosplay.png" alt="">
                  </div>
                  <div>
                    <div class="role-title">{{ role.title }}</div>
                    <div class="role-ops">
                      <div class="op-item" title="点击量">
                        <svg-icon class="icon" icon-class="ic_view" />
                        {{ role.views }}
                      </div>
                      <div class="op-item" title="使用量">
                        <svg-icon class="icon" icon-class="ic_usage" />
                        {{ role.usages }}
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </el-scrollbar>
        </div>
      </div>
      <div v-if="module === 'draw'" class="module-draw">
        <div class="module-body">
          <el-scrollbar wrap-class="scrollbar-wrapper">
            <drawSetting ref="drawSetting"></drawSetting>
          </el-scrollbar>
        </div>
      </div>
      <div class="module-footer">
        <div class="box-vip" @click="showPay('vip')">
          <img class="icon" src="@/assets/ic_vip.png" />
          <div class="title" v-if="vip_expire_time">已开通会员</div>
          <div class="title" v-else>开通会员</div>
          <div class="desc" v-if="vip_expire_time">{{ vip_expire_time }} 到期</div>
          <div class="desc" v-else>高速通道 无限对话</div>
        </div>
      </div>
    </div>
    <group-edit v-if="group" :group="group" @close="closeGroupEdit" @submit="saveGroup" />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { getGroupList, getGroup, saveGroup, delGroup } from '@/api/group'
import { getAllPrompt, votePrompt } from '@/api/write'
import { getAllRoles } from '@/api/cosplay'
import groupEdit from './groupEdit'

export default {
  components: { groupEdit },
  data() {
    return {
      page: 1,
      pagesize: 20,
      groupList: [],
      activeGroupId: 0,
      msgList: [],
      module: 'chat',
      group: null,
      writeTopicList: [],
      writeVoteList: [],
      writeVoteHidden: false,
      activePromptId: 0,
      cosplayRoleList: [],
      activeRoleId: 0,
      searchKeyword: ''
    }
  },
  computed: {
    ...mapGetters([
      'sidebar',
      'avatar',
      'nickname',
      'vip_expire_time',
      'balance',
      'theme'
    ]),
    isCollapse() {
      return !this.sidebar.opened
    },
    showLogo() {
      return this.$store.state.settings.sidebarLogo
    },
    routeName() {
      return this.$route.name ? this.$route.name : 'chat'
    }
  },
  watch: {
    searchKeyword() {
      this.filterList()
    }
  },
  mounted() {
    this.getUserInfo()
    this.getSystemInfo()
    this.getGroupList(true)
  },
  methods: {
    switchModule(module) {
      if (this.module === module) {
        return
      }
      if (module === 'chat') {
        if (this.activeGroupId) {
          this.$emit('changeGroupId', this.activeGroupId)
        }
      } else if (module === 'write') {
        if (!this.writeTopicList || this.writeTopicList.length === 0) {
          this.activePromptId = 0
          this.getAllPrompt()
        }
        if (this.activePromptId) {
          this.$emit('changePromptId', this.activePromptId)
        }
      } else if (module === 'cosplay') {
        if (!this.cosplayRoleList || this.cosplayRoleList.length === 0) {
          this.activeRoleId = 0
          this.getAllRoles()
        }
        if (this.activeRoleId) {
          this.$emit('changeRoleId', this.activeRoleId)
        }
      } else if (module === 'draw') {
        this.$message.warning('PC端绘画即将上线')
        return false
      }
      this.module = module
      this.searchKeyword = ''
      this.filterList()
    },
    filterList() {
      const keyword = this.searchKeyword
      if (this.module === 'write') {
        var topicList = this.writeTopicList
        topicList.forEach((topic, index1) => {
          if (topic && topic['prompts'] && topic['prompts'].length > 0) {
            var topicHidden = true
            topic['prompts'].forEach((prompt, index2) => {
              const promptHidden = prompt.title.indexOf(keyword) === -1
              topic['prompts'][index2].hidden = promptHidden
              if (!promptHidden) {
                topicHidden = false
              }
            })
            topic.hidden = topicHidden
            topicList[index1] = topic
          }
        })
        this.writeTopicList = topicList
        this.writeVoteHidden = !!keyword
      } else if (this.module === 'cosplay') {
        var roleList = this.cosplayRoleList
        roleList.forEach((group, index1) => {
          if (group && group['roles'] && group['roles'].length > 0) {
            var groupHidden = true
            group['roles'].forEach((role, index2) => {
              const roleHidden = role.title.indexOf(keyword) === -1
              group['roles'][index2].hidden = roleHidden
              if (!roleHidden) {
                groupHidden = false
              }
            })
            group.hidden = groupHidden
            roleList[index1] = group
          }
        })

        console.log('ss', roleList)
        this.cosplayRoleList = roleList
      }
    },
    changeGroup(group_id) {
      this.activeGroupId = group_id
      this.$emit('changeGroupId', group_id)
    },
    getGroupList(change = false) {
      getGroupList({ page: this.page, pagesize: this.pagesize }).then(res => {
        if (change && res.data.list.length > 0) {
          this.groupList = []
          this.changeGroup(res.data.list[0].id)
        }
        this.groupList = res.data.list
        this.groupTotal = res.data.count
      }).catch(res => {
        if (res.errno === 403) {
          this.$emit('showlogin')
        }
      })
    },
    editGroup(group_id = 0) {
      if (group_id) {
        getGroup({
          id: group_id
        }).then(res => {
          this.group = res.data
        }).catch(res => {
          if (res.errno === 403) {
            this.$emit('showlogin')
          }
        })
      } else {
        this.group = {
          title: '新的会话'
        }
      }
    },
    closeGroupEdit() {
      this.group = null
    },
    saveGroup(group) {
      saveGroup(group).then(res => {
        if (!this.group.id) {
          this.page = 1
          this.getGroupList(true)
        } else {
          for (var i in this.groupList) {
            if (this.groupList[i].id === group.id) {
              this.groupList[i].title = group.title
              break
            }
          }
        }
        this.$forceUpdate()

        this.$message({
          message: res.message,
          type: 'success',
          duration: 1500
        })
        this.closeGroupEdit()
      }).catch(res => {
        if (res.errno === 403) {
          this.$emit('showlogin')
        }
      })
    },
    delGroup(group_id) {
      this.$confirm('删除后不可恢复，确认删除吗?', '提示', {
        confirmButtonText: '确定删除',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        delGroup({
          id: group_id
        }).then(res => {
          for (var i in this.groupList) {
            if (this.groupList[i].id === group_id) {
              this.groupList.splice(i, 1)
              this.$forceUpdate()
              break
            }
          }

          this.getGroupList()
          this.$message({
            message: res.message,
            type: 'success',
            duration: 1500
          })
        }).catch(res => {
          if (res.errno === 403) {
            this.$emit('showlogin')
          }
        })
      })
    },
    getSystemInfo() {
      this.$store.dispatch('user/getSystemInfo')
    },
    showUserInfo() {
      this.$emit('showUserInfo')
    },
    getUserInfo() {
      this.$store.dispatch('user/getInfo').then((res) => {
        if (res.errno) {
          this.$message({
            message: res.message,
            type: 'error'
          })
        }
      }).catch((error) => {
        if (error.errno === 403) {
          this.$emit('showlogin')
          return
        }
        this.$message.error('获取用户信息失败')
      })
    },
    setTheme(theme) {
      this.$store.dispatch('user/setTheme', theme)
    },
    getAllPrompt() {
      getAllPrompt().then(res => {
        this.writeTopicList = res.data

        // 筛选出收藏的prompt
        var voteList = []
        this.writeTopicList.forEach(topic => {
          if (topic.prompts && topic.prompts.length > 0) {
            topic.prompts.forEach(prompt => {
              if (prompt.isVote) {
                voteList.push(prompt)
              }
            })
          }
        })
        this.writeVoteList = voteList
      })
    },
    doPromptVote(prompt_id) {
      votePrompt({
        prompt_id: prompt_id
      }).then(res => {
        this.$message.success(res.message)
        var topicList = this.writeTopicList
        topicList.forEach((topic, index1) => {
          if (topic && topic['prompts'] && topic['prompts'].length > 0) {
            topic['prompts'].forEach((prompt, index2) => {
              if (prompt.id === prompt_id) {
                topic['prompts'][index2].isVote = prompt.isVote ? 0 : 1
              }
            })
            topicList[index1] = topic
          }
        })
        this.writeTopicList = topicList
        this.$forceUpdate()
      })
    },
    changePrompt(prompt_id) {
      this.activePromptId = prompt_id
      this.$emit('changePromptId', prompt_id)
    },
    getAllRoles() {
      getAllRoles().then(res => {
        this.cosplayRoleList = res.data
      })
    },
    changeRole(role_id) {
      this.activeRoleId = role_id
      this.$emit('changeRoleId', role_id)
    },
    toDoc(type) {
      let routeData = this.$router.resolve({ name: 'Doc', query: { type: type } })
      window.open(routeData.href, '_blank')
    },
    showPay(type) {
      this.$emit('showPay', type)
    },
    getDrawSetting() {
      return this.$refs.drawSetting.getSetting()
    },
  }
}
</script>
