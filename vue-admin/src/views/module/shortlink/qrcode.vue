<template>
  <div class="app-container">
    <div class="toolbar">
      <el-button type="primary" icon="el-icon-plus" size="mini" @click="clickCreate()">二维码转活码</el-button>
    </div>
    <el-table
      :data="dataList"
      element-loading-text="加载中..."
      stripe
      size="medium"
      header-cell-class-name="bg-gray"
    >
      <el-table-column prop="add_time" label="创建时间" width="180" />
      <el-table-column prop="shortlink" label="短链接" />
      <el-table-column label="短链二维码" width="100">
        <template slot-scope="scope">
          <div style="float: left;" @click="showBigQrcode(scope.row.shortlink)">
            <vue-qr :text="scope.row.shortlink" :size="40" />
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="views" label="访问量" width="100" />
      <el-table-column prop="remark" label="备注" width="240" />
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button-group>
            <el-button type="text" size="mini" icon="el-icon-edit" @click.native.prevent="clickEdit(scope.row.id)">编辑</el-button>
            <el-button type="text text-danger" size="mini" icon="el-icon-delete" @click.native.prevent="clickDel(scope.row.id)">删除</el-button>
          </el-button-group>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination
      :current-page="currentPage"
      :page-size="pagesize"
      layout="total, prev, pager, next"
      :total="dataTotal"
      @current-change="currentPageChange"
    />
    <div v-if="form">
      <el-dialog
        custom-class="my-dialog"
        :title="form.id ? '编辑' : '创建 - 二维码转活码'"
        width="550px"
        :visible="true"
        :close-on-click-modal="false"
        :before-close="closeForm"
      >
        <el-form ref="form" :model="form" :rules="rules" label-width="120px">
          <el-form-item label="二维码" prop="qrcode">
            <el-upload
              class="avatar-uploader"
              action=""
              :data="{type: 'qrcode'}"
              :http-request="uploadImage"
              :show-file-list="false"
              :multiple="false"
            >
              <img v-if="form.qrcode" :src="form.qrcode" class="avatar" style="height: 80px; width: auto;">
              <i v-else class="el-icon-plus avatar-uploader-icon" style="width: 80px; height: 80px; line-height:80px;" />
            </el-upload>
          </el-form-item>
          <el-form-item label="引导语" prop="qrcode_tips">
            <el-input v-model="form.qrcode_tips" placeholder="如：请长按图片，识别二维码" size="small" />
          </el-form-item>
          <el-form-item label="备注" prop="remark">
            <el-input v-model="form.remark" type="textarea" placeholder="请输入备注" size="small" style="width: 300px;" />
          </el-form-item>
        </el-form>
        <span
          slot="footer"
          class="dialog-footer"
        >
          <el-button type="default" icon="el-icon-close" size="small" @click="closeForm">取 消</el-button>
          <el-button type="primary" icon="el-icon-check" size="small" @click="clickSubmit">提 交</el-button>
        </span>
      </el-dialog>
    </div>
    <div v-if="bigQrcodeUrl">
      <el-dialog
        custom-class="my-dialog"
        title="查看二维码"
        :visible="true"
        width="360px"
        :before-close="closeBigQrcode"
      >
        <el-row style="text-align: center;">
          <vue-qr :text="bigQrcodeUrl" :size="300" />
        </el-row>
      </el-dialog>
    </div>
  </div>
</template>

<script>
import { getList, getInfo, saveInfo, del } from '@/api/module/shortlink'
import { uploadImage } from '@/api/upload'
import vueQr from 'vue-qr'

export default {
  components: { vueQr },
  data() {
    return {
      type: 'qrcode',
      form: null,
      dataList: [],
      dataTotal: 0,
      currentPage: 1,
      pagesize: 10,
      rules: {
        qrcode: [
          { required: true, message: '此项必填', trigger: 'blur' }
        ]
      },
      bigQrcodeUrl: ''
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      getList({
        type: this.type,
        page: this.currentPage,
        pagesize: this.pagesize
      }).then(res => {
        this.dataList = res.data.list
        this.dataTotal = res.data.count
      })
    },
    currentPageChange(currentPage) {
      this.currentPage = currentPage
      this.getList()
    },
    showBigQrcode(url) {
      this.bigQrcodeUrl = url
    },
    closeBigQrcode(url) {
      this.bigQrcodeUrl = ''
    },
    clickCreate() {
      this.form = { id: '' }
    },
    clickEdit(id) {
      getInfo({
        type: this.type,
        id: id
      }).then(res => {
        this.form = res.data
      })
    },
    closeForm() {
      this.form = null
    },
    clickSubmit() {
      this.$refs['form'].validate((valid) => {
        if (valid) {
          saveInfo({
            id: this.form.id,
            type: this.type,
            qrcode: this.form.qrcode,
            qrcode_tips: this.form.qrcode_tips,
            remark: this.form.remark
          }).then(res => {
            this.$message({
              message: res.message,
              type: 'success',
              duration: 1500
            })
            this.closeForm()
            this.getList()
          })
        } else {
          console.log('请填写必填项')
        }
      })
    },
    clickDel(id) {
      this.$confirm('删除后不可恢复，链接立即失效，确认删除吗?', '提示', {
        confirmButtonText: '确定删除',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        del({ id: id }).then(res => {
          this.getList()
          this.$message({
            message: res.message,
            type: 'success',
            duration: 1500
          })
        })
      })
    },
    uploadImage(item) {
      var form = new FormData()
      form.append('file', item.file)
      if (item.data) {
        form.append('data', JSON.stringify(item.data))
      }
      uploadImage(form).then(res => {
        if (item.data.type === 'qrcode') {
          this.$set(this.form, 'qrcode', res.data.path)
        }
        this.$message.success('上传成功')
      })
    }
  }
}
</script>
<style scoped>
  .el-input{
    width: 300px;
  }
</style>
