<template>
  <view stype="padding: 30rpx;">
    <view class="panel">
      <!-- 基础用法，不包含校验规则 -->
      <uni-forms ref="baseForm" :model="baseFormData" labelWidth="80px">
        <uni-easyinput v-model="baseFormData.name" placeholder="知识库名称"/>
        <uni-easyinput type="textarea" v-model="baseFormData.introduction" placeholder="说明"/>
        <!--          <uni-zp-icons type="upload" size="18" color="#999" @upload="upload"/>-->

      </uni-forms>
      <view class="example-body">
        <uni-file-picker limit="5" file-mediatype="all" title="最多选择5个文件" style="padding-bottom:10px;"></uni-file-picker>
        <view class="uni-file-picker__header" >
          <text class="file-title">已上传文件：</text>
        </view>
        <uni-upload-file
          :list-styles="listStyles"
          :files-list="filesList"
          :showType="'list'"
          :delIcon="false"
          @delFile="delFile">
        </uni-upload-file>
      </view>
    </view>
    <view class="button-content">
      <button type="primary" @click="submit('baseForm')">提交</button>
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
        name: '',
        introduction: ''
      },
      listStyles: {
        // 是否显示边框
        border: true,
        // 是否显示分隔线
        dividline: true,
        // 线条样式
        borderStyle: {}
      },
      filesList: [
        {
          "name": "java_error_in_idea.hprof1",
          "uuid": 1690196966927
        },
        {
          "name": "java_error_in_idea.hprof",
          "uuid": 1690196966927
        },
        {
          "name": "java_error_in_idea.hprof",
          "uuid": 1690196966927
        },
        {
          "name": "java_error_in_idea.hprof",
          "uuid": 1690196966927
        },
        {
          "name": "java_error_in_idea.hprof",
          "uuid": 1690196966927
        },
        {
          "name": "java_error_in_idea.hprof",
          "uuid": 1690196966927
        },
        {
          "name": "java_error_in_idea.hprof",
          "uuid": 1690196966927
        },
        {
          "name": "java_error_in_idea.hprof",
          "uuid": 1690196966927
        },
        {
          "name": "java_error_in_idea.hprof",
          "uuid": 1690196966927
        },
        {
          "name": "java_error_in_idea.hprof",
          "uuid": 1690196966927
        },
        {
          "name": "java_error_in_idea.hprof",
          "uuid": 1690196966927
        }
      ]
    }
  },
  onLoad(options) {
    var type = options.type
    var title = '文章内容'
    switch (options.type) {
      case 'about':
        title = '关于我们';
        break;
      case 'kefu':
        title = '联系客服';
        break;
      case 'privacy':
        title = '隐私政策';
        break;
      case 'service':
        title = '服务协议';
        break;
      case 'notice':
        title = '通知公告';
        break;
      case 'legal':
        title = '免责声明';
        break;
      case 'commission':
        title = '推广协议';
        break;
    }
    uni.setNavigationBarTitle({
      title: title
    })
    var data = {
      type: type
    }
    if (type == 'help' && options.id) {
      data.id = options.id
    }
    // app.globalData.util.request({
    //   url: '/article/getArticle',
    //   data: data
    // }).then((res) => {
    //   if (res.data.title) {
    //     uni.setNavigationBarTitle({
    //       title: res.data.title
    //     })
    //   }
    //   this.setData({
    //     content: res.data.content
    //   });
    // });
  },
  methods: {
    submit(ref) {
      console.log(this.baseFormData);
      this.$refs[ref].validate().then(res => {
        console.log('success', res);
        uni.showToast({
          title: `校验通过`
        })
        // this.goBackPage(1)
      }).catch(err => {
        console.log('err', err);
      })
    },
    goBackPage(data) {
      uni.$emit('item', data)
      uni.navigateBack();
    },
    upload() {
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
