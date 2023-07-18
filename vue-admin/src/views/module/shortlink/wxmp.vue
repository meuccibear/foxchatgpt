<template>
  <div class="app-container">
    <div class="toolbar">
      <el-button type="primary" icon="el-icon-plus" size="mini" @click="clickCreate()">公众号转短链</el-button>
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
        :title="form.id ? '编辑' : '创建 - 微信公众号转短链'"
        width="550px"
        :visible="true"
        :close-on-click-modal="false"
        :before-close="closeForm"
      >
        <el-form ref="form" :model="form" :rules="rules" label-width="120px">
          <el-form-item label="公众号链接" prop="h5link">
            <el-input v-model="form.h5link" type="textarea" :rows="3" placeholder="请输入公众号链接" size="small" style="width: 300px;" />
            <p style="padding: 0; margin: 0;"><el-button type="text" size="small" @click="showGetWxmpHome">获取公众号主页链接</el-button></p>
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
    <div v-if="wxmpForm">
      <el-dialog
        custom-class="my-dialog"
        title="获取公众号主页链接"
        :visible="true"
        width="650px"
        :close-on-click-modal="false"
        :append-to-body="true"
        :before-close="closeGetWxmpHome"
      >
        <el-form :model="wxmpForm" label-width="100px">
          <el-form-item label="文章链接" prop="link">
            <el-input v-model="wxmpForm.link" type="textarea" :rows="2" placeholder="该公众号下任意一篇文章链接" size="small" />
            <p style="margin: 0; font-size: 13px;">微信打开公众号文章 -> 右上角三个点 -> 复制链接，然后将链接粘贴在此处</p>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button type="default" size="small" @click="closeGetWxmpHome">关闭</el-button>
          <el-button type="primary" size="small" @click="getWxmpHome">确定</el-button>
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
import { getList, getInfo, saveInfo, del, getWxmpHome } from '@/api/module/shortlink'
import vueQr from 'vue-qr'

export default {
  components: { vueQr },
  data() {
    return {
      type: 'wxmp',
      form: null,
      dataList: [],
      dataTotal: 0,
      currentPage: 1,
      pagesize: 10,
      rules: {
        h5link: [
          { required: true, message: '此项必填', trigger: 'blur' }
        ]
      },
      bigQrcodeUrl: '',
      wxmpForm: null
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
    showGetWxmpHome() {
      this.wxmpForm = {}
    },
    closeGetWxmpHome() {
      this.wxmpForm = null
    },
    getWxmpHome() {
      getWxmpHome(this.wxmpForm).then(res => {
        this.$message({
          message: res.message,
          type: 'success',
          duration: 1500
        })
        this.$set(this.form, 'h5link', res.data)
        this.closeGetWxmpHome()
      })
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
            h5link: this.form.h5link,
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
    }
  }
}
</script>
<style scoped>
  .el-input{
    width: 300px;
  }
</style>
