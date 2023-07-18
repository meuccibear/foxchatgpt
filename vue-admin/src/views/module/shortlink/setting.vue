<template>
  <div class="app-container" style="padding-top: 10px;">
    <el-tabs v-model="tabName" @tab-click="switchTab">
      <el-tab-pane label="基础配置" name="config">
        <el-alert type="warning" size="small" title="需将域名解析到服务器ip，并绑定到本站点" style="width: 430px; margin: 10px 0 20px 20px;" />
        <el-form ref="form" :model="form" :rules="formRules" label-width="120px">
          <el-form-item label="短链域名" prop="host">
            <el-input v-model="form['host']" placeholder="填域名，不带http://" size="small" style="width: 300px;" />
          </el-form-item>
          <el-form-item label="">
            <el-button type="primary" icon="el-icon-check" size="small" @click="doSubmit">保 存</el-button>
          </el-form-item>
        </el-form>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import { getSetting, setSetting } from '@/api/setting'

export default {
  data() {
    return {
      tabName: 'config',
      form: {},
      formRules: {
        'host': [
          { required: true, message: '此项必填', trigger: 'blur' }
        ]
      }
    }
  },
  mounted() {
    this.getSetting()
  },
  methods: {
    getSetting() {
      getSetting({
        name: 'shortlink'
      }).then(res => {
        this.form = res.data
      })
    },
    switchTab() {
      this.getSetting()
    },
    doSubmit() {
      this.$refs['form'].validate((valid) => {
        if (valid) {
          setSetting({
            name: 'shortlink',
            data: JSON.stringify(this.form)
          }).then(res => {
            this.$message({
              message: res.message,
              type: 'success',
              duration: 1500
            })
            this.getSetting()
          })
        } else {
          this.$message({
            message: '请填写必填项',
            type: 'error',
            duration: 1500
          })
        }
      })
    }
  }
}
</script>
