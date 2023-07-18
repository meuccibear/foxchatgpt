<template>
  <div class="app-container">
    <div class="toolbar">
      <div>
        <el-button-group>
          <el-button :type="search.topic_id === 'all' ? 'primary' : 'default'" size="small" @click="changeTopic('all')">全部类别</el-button>
          <el-button v-for="item in topicList" :type="search.topic_id === item.id ? 'primary' : 'default'" size="small" @click="changeTopic(item.id)">
            {{ item.title }}</el-button>
        </el-button-group>
      </div>
      <div>
        <el-button type="primary" icon="el-icon-plus" size="mini" @click="clickAdd">添加模型</el-button>
      </div>
    </div>
    <el-table
      :data="dataList"
      stripe
      size="medium"
      header-cell-class-name="bg-gray"
    >
      <el-table-column prop="weight" label="权重" width="60" />
      <el-table-column prop="topic_title" label="所属类别" width="140" />
      <el-table-column prop="title" label="模型标题" width="200" />
      <el-table-column prop="desc" label="描述" width="350" />
      <el-table-column prop="views" label="点击量" width="100" />
      <el-table-column prop="usages" label="使用量" width="100" />
      <el-table-column prop="votes" label="收藏量" width="100" />
      <el-table-column prop="state" label="启用" width="80">
        <template slot-scope="scope">
          <el-switch
            v-model="scope.row.state"
            :active-value="1"
            :inactive-value="0"
            @change="setState(scope.row.id, $event)"
          />
        </template>
      </el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button-group>
            <el-button type="text" size="mini" icon="el-icon-edit" @click.native.prevent="clickEdit(scope.row.id)">编辑
            </el-button>
            <el-button type="text text-danger" size="mini" icon="el-icon-delete" @click.native.prevent="doDel(scope.row.id)">删除</el-button>
          </el-button-group>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination
      :current-page="page"
      :page-size="pagesize"
      layout="total, prev, pager, next"
      :total="dataTotal"
      @current-change="pageChange"
    />
    <div v-if="form">
      <el-dialog
        custom-class="my-dialog full-dialog"
        :title="formTitle"
        width="800px"
        :visible="true"
        :close-on-click-modal="false"
        :before-close="formClose"
      >
        <el-form ref="form" :model="form" :rules="formRules" label-width="120px">
          <el-form-item label="权重" prop="weight">
            <el-input v-model="form.weight" placeholder="越大越靠前" size="normal" style="width: 110px;" />
            <span style="color: #666; margin-left: 10px;">越大越靠前</span>
          </el-form-item>
          <el-form-item label="所属类别" prop="title">
            <el-select v-model="form.topic_id" placeholder="选择所属类别" size="normal" style="width: 180px;">
              <el-option
                v-for="(item, index) in topicList"
                :key="index"
                :label="item.title"
                :value="item.id"
              />
            </el-select>
          </el-form-item>
          <el-form-item label="模型标题" prop="title">
            <el-input v-model="form.title" placeholder="模型标题" size="normal" style="width: 400px;" />
          </el-form-item>
          <el-form-item label="描述" prop="desc">
            <el-input v-model="form.desc" type="textarea" :rows="3" placeholder="模型描述" size="normal" style="width: 500px;" />
          </el-form-item>
          <el-form-item label="模型内容" prop="prompt">
            <el-input v-model="form.prompt" type="textarea" :rows="6" placeholder="模型内容" size="normal" style="width: 500px;" />
            <p style="margin: 0; line-height: 24px; margin-top: 10px;">变量说明：</p>
            <p style="margin: 0; line-height: 24px; color: #888;">用户输入内容：<span style="color: #04BABE;">[PROMPT]</span></p>
            <p style="margin: 0; line-height: 24px; color: #888;">输出语言：<span style="color: #04BABE;">[TARGETLANGGE]</span></p>
          </el-form-item>
          <el-form-item label="提示文字" prop="hint">
            <el-input v-model="form.hint" type="textarea" :rows="3" placeholder="在输入框里提示用户的文字" size="normal" style="width: 500px;" />
          </el-form-item>
          <el-form-item label="欢迎语" prop="welcome">
            <el-input v-model="form.welcome" type="textarea" :rows="3" placeholder="可留空，默认使用提示文字" size="normal" style="width: 500px;" />
          </el-form-item>
          <el-form-item label="虚拟点击量" prop="fake_views">
            <el-input v-model="form.fake_views" placeholder="" size="normal" style="width: 110px;" />
          </el-form-item>
          <el-form-item label="虚拟使用量" prop="fake_usages">
            <el-input v-model="form.fake_usages" placeholder="" size="normal" style="width: 110px;" />
          </el-form-item>
          <el-form-item label="虚拟收藏量" prop="fake_votes">
            <el-input v-model="form.fake_votes" placeholder="" size="normal" style="width: 110px;" />
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button type="default" icon="el-icon-close" size="small" @click="formClose">取 消</el-button>
          <el-button type="primary" icon="el-icon-check" size="small" @click="doSubmit">提 交</el-button>
        </span>
      </el-dialog>
    </div>
  </div>
</template>

<script>
import { getTopicList, getPromptList, savePrompt, getPrompt, delPrompt, setPromptState } from '@/api/write'

export default {
  data() {
    return {
      form: null,
      formType: null,
      dataList: [],
      dataTotal: 0,
      topicList: [],
      page: 1,
      pagesize: 10,
      search: {
        topic_id: 'all'
      },
      formRules: {
        title: [
          { required: true, message: '此项必填', trigger: 'blur' }
        ],
        desc: [
          { required: true, message: '此项必填', trigger: 'blur' }
        ],
        prompt: [
          { required: true, message: '此项必填', trigger: 'blur' }
        ],
        hint: [
          { required: true, message: '此项必填', trigger: 'blur' }
        ]
      }
    }
  },
  computed: {
    formTitle() {
      return this.formType === 'add' ? '添加模型' : '编辑'
    }
  },
  mounted() {
    this.getTopicList()
    this.getList()
  },
  methods: {
    getTopicList() {
      getTopicList().then(res => {
        this.topicList = res.data
      })
    },
    getList() {
      getPromptList({
        page: this.page,
        pagesize: this.pagesize,
        topic_id: this.search.topic_id
      }).then(res => {
        this.dataList = res.data.list
        this.dataTotal = res.data.count
      })
    },
    pageChange(page) {
      this.page = page
      this.getList()
    },
    clickAdd() {
      this.formType = 'add'
      this.form = {
        weight: 100
      }
    },
    clickEdit(id) {
      getPrompt({ id: id }).then(res => {
        this.formType = 'edit'
        this.form = res.data
      })
    },
    formClose() {
      this.form = null
      this.formType = ''
    },
    doSubmit() {
      this.$refs.form.validate((valid) => {
        if (valid) {
          savePrompt(this.form).then(res => {
            this.getList()
            this.$message({
              message: res.message,
              type: 'success',
              duration: 1500
            })
            this.formClose()
          })
        } else {
          console.log('请填写必填项')
        }
      })
    },
    doDel(id) {
      this.$confirm('删除后不可回复，确定删除吗?', '提示', {
        confirmButtonText: '确定删除',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        delPrompt({ id: id }).then(res => {
          this.getList()
          this.$message({
            message: res.message,
            type: 'success',
            duration: 1500
          })
        })
      })
    },
    setState(id, state) {
      setPromptState({
        id: id,
        state: state
      }).then(res => {
        this.getList()
        this.$message({
          message: res.message,
          type: 'success',
          duration: 1500
        })
      })
    },
    changeTopic(topic_id) {
      this.search.topic_id = topic_id
      this.page = 1
      this.getList()
    }
  }
}
</script>
<style scoped>
  .toolbar {
    display: flex;
    align-items: center;
    justify-content: space-between;
  }
</style>
