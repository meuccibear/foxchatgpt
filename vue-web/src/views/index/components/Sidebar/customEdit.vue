<template>
    <el-dialog
      custom-class="my-dialog"
      :title="title"
      width="440px"
      :visible="visible"
      :close-on-click-modal="false"
      :append-to-body="true"
      :before-close="closeForm"
    >
      <div class="cu-title">
        <span>请选择知识库</span>
      </div>
      <el-checkbox-group v-model="checkedItem" >
        <ul class="infinite-list" v-infinite-scroll="load" style="overflow:auto">
          <li v-for="item in checkboxData"  class="infinite-list-item">
              <el-checkbox :label="item.repo_name" :key="item.repo_id" border >{{item.repo_name}}</el-checkbox>
          </li>
        </ul>
      </el-checkbox-group>
      <span slot="footer" class="dialog-footer">
        <el-button type="default" icon="el-icon-close" size="small" @click="closeForm">取 消</el-button>
        <el-button type="primary" icon="el-icon-check" size="small" @click="doSubmit">提 交</el-button>
      </span>
    </el-dialog>
</template>

<script>
export default {
  props: {
    checkboxData: {
      type: Array,
      default: []
    },
    data: {
      type: Array,
      default: []
    }
  },
  data() {
    const cityOptions = ['上海', '北京', '广州', '深圳', '上海', '北京', '广州', '深圳', '上海', '北京', '广州', '深圳', '上海', '北京', '广州', '深圳'];
    return {
      visible: false,
      title: '',
      // checkboxData: null,
      count: 0,
      // checkAll: false,
      checkedItem: [],
      cities: cityOptions
      // isIndeterminate: true
    }
  },
  created() {
    this.checkedItem = this.data
  },
  methods: {
    load () {
      this.count += 2
    },
    closeForm() {
      this.visible = false
    },
    doSubmit() {
      this.visible = false
      console.log(this.checkboxData)
      this.$emit('ok', this.checkedItem)
    }
  }
}
</script>
<style lang="scss" scoped>
  .tips {
    margin-left: 10px;
    color: #999;
  }

  .cu-title{
    color: #909399;
    text-align: center;
    font-size: 16px;
    padding-bottom: 20px;
    font-weight: 500;
  }

  .infinite-list {
    height: 300px;
    padding: 0;
    margin: 0;
    list-style: none
  }

  .infinite-list-item {

    margin-right: 10px;

    label {
      width: 100% !important;
      margin-top: 10px
    }

    .el-checkbox .is-bordered {
      padding: 9px 20px 9px 10px;
      border-radius: 4px;
      border: 1px solid #DCDFE6;
      -webkit-box-sizing: border-box;
      box-sizing: border-box;
      line-height: normal;
      height: 40px;
    }

    //.is-checked {
    //  background: #1f6feb ;
    //}
  }


</style>
