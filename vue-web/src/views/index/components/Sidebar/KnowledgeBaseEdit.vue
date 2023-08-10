<template>
  <div v-if="form">
    <el-dialog
      custom-class="my-dialog"
      :title="group.repo_id ? '编辑知识库' : '创建知识库'"
      width="440px"
      :visible="true"
      :close-on-click-modal="false"
      :append-to-body="true"
      :before-close="closeForm"
    >
      <el-form ref="form" :model="form" :rules="formRules" label-width="100px" >
        <el-form-item label="名称" prop="num">
          <el-input v-model="form.repo_name" placeholder="名称" size="normal" style="width: 240px;" />
        </el-form-item>
      </el-form>
      <el-form ref="form" :model="form" :rules="formRules" label-width="100px">
        <el-form-item label="说明" prop="num">
          <el-input type="textarea" v-model="form.repo_desc" placeholder="说明" size="normal" style="width: 240px;" />
        </el-form-item>
      </el-form>
      <div v-if="group.repo_id">
        <span>已上传文件:</span>
        <div style="border-width: 1px; border-style: solid; border-color: rgb(238, 238, 238); border-radius: 5px; margin-top: 5px;">
          <div class="infinite-list" style="overflow:auto; height: 200px;">
            <div v-for="(item ,index) in filesList"  class=" uni-file-picker__item" :class="{ 'files-border':index !== 0 }">
              <div class="files__name">{{item.file_name}}</div>
              <div class="icon-del-box icon-files">
<!--                <svg-icon class="icon" icon-class="ic_usage" />-->
                <i :class="item.state==1 ? 'el-icon-success' : 'el-icon-loading'" style="color: rgb(4, 186, 190);"></i>
<!--                <uni-icons :class="{'App-logo': item.state == 0}" color="rgb(4, 186, 190)" :type="item.state == 1 ? 'checkbox-filled':'spinner-cycle'"></uni-icons>-->
              </div>
            </div>
          </div>
        </div>
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button type="default" icon="el-icon-close" size="small" @click="closeForm">取 消</el-button>
        <el-button type="primary" icon="el-icon-check" size="small" @click="doSubmit">提 交</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { getFileListForLib } from '@/api/retrieval'

export default {
  props: {
    group: {
      type: Object,
      default: null
    }
  },
  data() {
    return {
      form: null,
      formRules: {
        repo_name: [
          { required: true, message: '此项必填', trigger: 'blur' }
        ],
        repo_desc: [
          { required: true, message: '此项必填', trigger: 'blur' }
        ]
      },
      filesList: []
    }
  },
  created() {
    this.form = this.group
    console.log('this.group.repo_id', this.group.repo_id)
    getFileListForLib({
      repo_id: this.group.repo_id
    }).then(res => {
      this.filesList = res.data
    })
  },
  methods: {
    closeForm() {
      this.$emit('close')
    },
    doSubmit() {
      this.$refs.form.validate((valid) => {
        if (valid) {
          this.$emit('submit', this.form)
        } else {
          this.$message.error('请填写必填项')
        }
      })
    }
  }
}
</script>
<style lang="scss" scoped>
  .tips {
    margin-left: 10px;
    color: #999;
  }

  .uni-file-picker__item {
    /* #ifndef APP-NVUE */
    display: flex;
    /* #endif */
    align-items: center;
    padding: 8px 5px 8px 10px;
  }

  .files__name {
    flex: 1;
    font-size: 14px;
    color: #666;
    margin-right: 25px;
    /* #ifndef APP-NVUE */
    word-break: break-all;
    word-wrap: break-word;
    /* #endif */
  }

  .icon-del-box {
    /* #ifndef APP-NVUE */
    display: flex;
    margin: auto 0;
    /* #endif */
    align-items: center;
    justify-content: center;
    position: absolute;
    top: 0px;
    bottom: 0;
    right: 5px;
    height: 26px;
    width: 26px;
    // border-radius: 50%;
    // background-color: rgba(0, 0, 0, 0.5);
    z-index: 2;
    //transform: rotate(-45deg);
  }

  .icon-files {
    /* #ifndef APP-NVUE */
    position: static;
    background-color: initial;
    /* #endif */
  }

  .files-border {
    border-top: 1px #eee solid;
  }
</style>
