<template>
  <div>
    <el-dialog
      custom-class="my-dialog"
      title="个人中心"
      :visible="true"
      width="600px"
      :close-on-click-modal="true"
      :before-close="closeUserInfo"
    >
      <div class="userinfo">
        <el-form ref="form" label-width="120px">
          <el-form-item label="MID" prop="num">
            <span>{{ userinfo.user_id }}</span>
          </el-form-item>
          <el-form-item label="头像" prop="avatar">
            <el-upload
              class="user-avatar"
              action=""
              :before-upload="uploadCheck"
              :http-request="uploadAvatar"
              :show-file-list="false"
              :multiple="false"
            >
              <img :src="userinfo.avatar || '/static/img/no_avatar.png'" style="height: 50px; width: 50px; float: left;" />
            </el-upload>
          </el-form-item>
          <el-form-item label="昵称" prop="nickname">
            <el-input v-model="userinfo.nickname" placeholder="请输入昵称" style="width: 220px;">
              <el-button slot="append" type="default" @click="setUserNickname">保存</el-button>
            </el-input>
          </el-form-item>
          <el-form-item label="VIP会员">
            <div v-if="userinfo.vip_expire_time" class="balance">
              <span>{{ userinfo.vip_expire_time }} 到期</span>
              <el-button type="text" size="small" @click="showPay('vip')">续费</el-button>
            </div>
            <div v-else class="balance">
              <span>未开通</span>
              <el-button type="text" size="small" @click="showPay('vip')">立即开通</el-button>
            </div>
          </el-form-item>
          <el-form-item label="对话次数">
            <div class="balance">
              <span>{{ userinfo.balance }} 次</span>
              <el-button type="text" size="small" @click="showPay('goods')">充值</el-button>
            </div>
          </el-form-item>
          <el-form-item label="绘画次数">
            <div class="balance">
              <span>{{ userinfo.balance_draw }} 张</span>
              <el-button type="text" size="small" @click="showPay('draw')">充值</el-button>
            </div>
          </el-form-item>
          <el-form-item v-if="hasModel4" :label="model4Name + '余额'">
            <div class="balance">
              <span>{{ userinfo.balance_gpt4 }} 万字</span>
              <el-button type="text" size="small" @click="showPay('gpt4')">充值</el-button>
            </div>
          </el-form-item>
        </el-form>
        <div class="logout">
          <el-button type="danger" size="small" @click="logout">退出登录</el-button>
        </div>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { getInfo, setUserAvatar, setUserNickname } from '@/api/user'
import { uploadImage } from '@/api/upload'
export default {
  name: 'Userinfo',
  data() {
    return {
      userinfo: {}
    }
  },
  computed: {
    ...mapGetters([
      'hasModel4',
      'model4Name'
    ])
  },
  created() {
    this.getUserInfo()
  },
  methods: {
    getUserInfo() {
      getInfo().then(res => {
        this.userinfo = res.data
      })
    },
    closeUserInfo() {
      this.$emit('close')
    },
    showPay(type) {
      this.$emit('showPay', type)
    },
    async logout() {
      await this.$store.dispatch('user/logout')
      this.closeUserInfo()
      window.location.reload()
    },
    uploadAvatar(item) {
      var form = new FormData()
      form.append('image', item.file)
      if (item.data) {
        form.append('data', JSON.stringify(item.data))
      }
      uploadImage(form).then(res => {
        if (!res.data.path) {
          this.$message.error('上传失败')
          return
        }
        setUserAvatar({
          avatar: res.data.path
        }).then(() => {
          this.getUserInfo()
          this.$message.success('修改成功')
        })
      })
    },
    setUserNickname() {
      setUserNickname({
        nickname: this.userinfo.nickname
      }).then(() => {
        this.$message.success('保存成功')
      })
    },
    uploadCheck(field) {
      var ext = ''
      var arr = field.name.split('.')
      if (arr.length > 1) {
        ext = arr[arr.length - 1].toLowerCase()
      }
      if (!['png', 'jpg', 'jpeg', 'gif'].includes(ext)){
        this.$message.error('不支持的图片格式');
        return false
      }
    }
  }
}
</script>

<style lang="scss" scoped>
  .userinfo {
    letter-spacing: 1px;
    padding-bottom: 10px;
    .user-avatar {
      img {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        float: left;
      }
    }
    .balance {
      display: flex;
      align-items: center;
      span {
        margin-right: 10px;
      }
    }

    .logout {
      padding: 30px 0 0 0;
      text-align: center;
    }
  }
</style>
<style>
.userinfo .el-form-item__label {
  font-weight: normal;
  color: #999;
}
.userinfo .el-form-item__content {
  padding-left: 20px !important;
}
</style>
