<template>
  <view stype="padding: 30rpx;">
    <view class="panel">
      <!-- 基础用法，不包含校验规则 -->
      <uni-forms ref="baseForm" :model="baseFormData" labelWidth="80px">
        <uni-easyinput v-model="baseFormData.repo_name" placeholder="知识库名称"/>
        <uni-easyinput type="textarea" v-model="baseFormData.repo_desc" placeholder="说明"/>
      </uni-forms>
      <view class="example-body" v-if="baseFormData.repo_id">
        <view class="uni-file-picker__header" >
          <text class="file-title">已上传文件：</text>
        </view>
        <uni-upload-file
          :list-styles="listStyles"
          :files-list="filesList"
          :showType="'list'"
          @delFile="delFile">
        </uni-upload-file>
      </view>
    </view>
    <view class="button-content">
      <button type="primary" style="background: #04babe;" @click="submit('baseForm')">提交</button>
    </view>
  </view>
</template>

<script>
const app = getApp();
import Easyinput from "./easyinput.vue";

export default {
  components: {
    Easyinput
  },
  data() {
    return {
      // 基础表单数据
      baseFormData: {
        repo_id: undefined,
        repo_name: '',
        repo_desc: ''
      },
      listStyles: {
        // 是否显示边框
        border: true,
        // 是否显示分隔线
        dividline: true,
        // 线条样式
        borderStyle: {}
      },
      filesList: []
    }
  },
  onLoad(options) {
    if (options.id) {
      app.globalData.util.request({
        url: '/Retrieval/getLibs',
        method: 'GET',
        data: {
          repo_id: options.id
        }
      }).then((res) => {
        this.setData({
          baseFormData: res.data
        });
      });
      app.globalData.util.request({
        url: '/Retrieval/getFileListForLib',
        method: 'GET',
        data: {
          repo_id: options.id
        }
      }).then((res) => {
        let files = []
        let itemData = undefined
        // for(let item in res.data) {
        //   itemData = res.data[item]
        //   files.push({
        //     'uuid': itemData.file_id,
        //     'name': itemData.file_name
        //   })
        // }
        this.setData({
          filesList: res.data
        });
      });
    } else {
      console.log('')
    }
  },
  methods: {
    submit(ref) {
      this.$refs[ref].validate().then(res => {
        let status = this.baseFormData.repo_id ? true : false
        const $this = this
        app.globalData.util.request({
          url: status ? '/Retrieval/updateLib' : '/Retrieval/addLib',
          data: this.baseFormData
        })
        .then((res) => {
          app.globalData.util.message(res.message, 'error', function () {
            if (!status) {
              $this.goBackPage('isRefresh')
            }
          });
        });
      }).catch(err => {
        console.log('err', err);
      })
    },
    goBackPage(key) {
      uni.$emit(key)
      uni.navigateBack({
        delta: 1
      });
    },
    /**
     * 删除文件
     * @param {Object} index
     */
    delFile(index) {
      console.log(index)
      // this.$emit('delete', {
      //   tempFile: this.files[index],
      //   tempFilePath: this.files[index].url
      // })
      this.filesList.splice(index, 1)
      // this.$nextTick(() => {
      //   this.setEmit()
      // })
    },
  }
};
</script>
<style lang="scss">
page {
  box-sizing: border-box;
  background: #f7f7f7;
}

.panel {
  //margin: 30rpx;
  padding: 30rpx;
  background: #fff;
  border-radius: 20rpx;
}

.example {
  padding: 15px;
  background-color: #fff;
}

.segmented-control {
  margin-bottom: 15px;
}

.button-group {
  margin-top: 15px;
  display: flex;
  justify-content: space-around;
}

.form-item {
  display: flex;
  align-items: center;
  flex: 1;
}

.button {
  display: flex;
  align-items: center;
  height: 35px;
  line-height: 35px;
  margin-left: 10px;
}

.button-content {
  /* padding: 10px; *//* display: flow-root; *//* border-bottom: groove; */
  width: 100%;
  float: inherit;
  bottom: 10px;
  position: absolute;

  button {
    margin: 10px;
  }

}


.card-actions-item {
  display: flex;
  flex-direction: row;
  align-items: center;
}

.card-actions-item-text {
  font-size: 12px;
  color: #666;
  margin-left: 5px;
}
</style>
