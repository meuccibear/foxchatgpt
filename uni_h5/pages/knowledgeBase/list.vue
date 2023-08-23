<template>
<!--  <view style="padding: 14px;">-->
  <view >
<!--    <card-list></card-list>-->
    <scroll-view scroll-y="true" class="scroll-Y" >
      <uni-card
          v-for="(item, index) in list"
      >
        <view slot="context" class="slot-content">
          <view slot="">
            <text class="uni-body uni-mt-5 title" >{{item.repo_name}}</text>
          </view>
          <view slot="" class="desc">
            <text class="uni-body uni-mt-5">{{item.repo_desc}}</text>
          </view>
        </view>
        <view slot="actions" class="card-actions">
          <view class="card-actions-item" data-type="addFile" :data-id="item.repo_id" @tap="actionClick">
            <uni-icons type="folder-add" size="18" color="#999"></uni-icons>
            <text class="card-actions-item-text">添加文件</text>
          </view>
          <view class="card-actions-item" data-type="edit" :data-id="item.repo_id" @tap="actionClick">
            <uni-icons type="compose" size="18" color="#999"></uni-icons>
            <text class="card-actions-item-text">编辑</text>
          </view>
          <view class="card-actions-item" data-type="delete" :data-id="item.repo_id" @tap="actionClick">
            <uni-icons type="trash" size="18" color="#999"></uni-icons>
            <text class="card-actions-item-text">删除</text>
          </view>
        </view>
      </uni-card>
    </scroll-view>
    <uni-fab
      ref="fab"
      :pattern="pattern"
      :horizontal="horizontal"
      :vertical="vertical"
      :direction="direction"
      @trigger="trigger"
      @fabClick="fabClick" />
  </view>

</template>

<script>
import CardList from './card.vue'
const app = getApp();
export default {
  data() {
    return {
      title: 'nav-button',
      list: [],
      swipeList: [
        {
          id: 1,
          options: [
            {
              text: '置顶'
            },
            {
              text: '删除',
              style: {
                backgroundColor: 'rgb(255,58,49)'
              }
            }
          ],
          content: 'item2'
        },
        {
          id: 2,
          options: [{
            text: '置顶'
          },
            {
              text: '标记为已读',
              style: {
                backgroundColor: 'rgb(254,156,1)'
              }
            },
            {
              text: '删除',
              style: {
                backgroundColor: 'rgb(255,58,49)'
              }
            }
          ],
          content: 'item3'
        }
      ],
      status: {
        swipeChangeStatus: 'none',
        oldSwipeChangeStatus: 'none'
      },
      horizontal: 'right',
      vertical: 'bottom',
      direction: 'horizontal',
      pattern: {
        color: '#7A7E83',
        backgroundColor: '#fff',
        selectedColor: '#04babe',
        buttonColor: '#04babe',
        iconColor: '#fff'
      },
      loading: true
    };
  },
  components: {
    CardList
  },
  onLoad(options) {
    const type = options.type
    this.setData({
      type: type
    })
    this.init()
  },
  onShow() {
    uni.$on('item', (obj) => {
      console.log('obj:', obj)
    })
    let $this = this
    uni.$on('isRefresh',function(data){
      console.log('监听到事件来自返回的参数：' + data);
      // TODO 下面执行刷新的方法
      $this.init()
    })
  },
  methods: {
    init() {
      app.globalData.util.request({
        url: '/Retrieval/getAllLibs',
        method: 'GET'
      }).then(res => {
        this.setData({
          list: res.data
        })
      })
    },
    actionClick(e) {
      const id = e.currentTarget.dataset.id
      const type = e.currentTarget.dataset.type
      switch (type) {
        case 'edit':
          uni.navigateTo({
            url: '/pages/knowledgeBase/knowledgeBase?id=' + id
          })
          break
        case 'delete':
          app.globalData.util.request({
            url: '/Retrieval/delLib',
            data: { repo_id : id}
          })
          .then((res) => {
            // this.goBackPage(1)
            app.globalData.util.message(res.message, 'error', this.init);
          });
          // uni.showToast({
          //   title: `校验通过`
          // })
          // this.goBackPage(1)
          break
        case 'addFile':
          uni.chooseFile({
            count: 1,
            extension: ['docx', 'txt', 'pdf', 'doc'],
            success: (res) => {
              uni.showNavigationBarLoading();
              uni.showLoading({
                title: '加载中'
              });
              // console.log('选择文件成功，临时路径为', res.tempFilePaths[0])
              var imageSrc = res.tempFilePaths[0]
              uni.uploadFile({
                // url: 'http://165.154.36.236:8010/uploadfiles/',
                url: 'https://api.i.sale:8010/uploadfiles/',
                filePath: imageSrc,
                fileType: 'image',
                formData: {
                  'repoid': id
                },
                name: 'files',
                success: (res) => {
                  const data = JSON.parse(res.data)
                  if (data.message.length === 0) {
                    uni.showToast({
                      title: '上传成功',
                      icon: 'success',
                      duration: 1000
                    })
                  } else {
                    uni.showModal({
                      content: data.message,
                      showCancel: false
                    });
                  }
                  uni.hideLoading();
                  uni.hideNavigationBarLoading();
                  // this.imageSrc = imageSrc
                },
                fail: (err) => {
                  console.log('uploadImage fail', err);
                  uni.showModal({
                    content: err.errMsg,
                    showCancel: false
                  });
                  uni.hideLoading();
                  uni.hideNavigationBarLoading();
                }
              });
            },
            fail: (err) => {
              console.log('chooseImage fail', err)
              // #ifdef MP
              uni.getSetting({
                success: (res) => {
                  let authStatus = res.authSetting['scope.album'];
                  if (!authStatus) {
                    uni.showModal({
                      title: '授权失败',
                      content: 'Hello uni-app需要从您的相册获取图片，请在设置界面打开相关权限',
                      success: (res) => {
                        if (res.confirm) {
                          uni.openSetting()
                        }
                      }
                    })
                  }
                }
              })
              // #endif
            }
          })
          break
      }
    },
    toArticle(e) {
      const id = e.currentTarget.dataset.id
      wx.navigateTo({
        url: '/pages/article/article?type=' + this.type + '&id=' + id
      })
    },
    swipeChange(e, index) {
      this.status.oldSwipeChangeStatus = this.status.swipeChangeStatus
      this.status.swipeChangeStatus = e

      console.log('swipeChange:\n返回：', e, '当前索引：', index);
    },
    contentClick() {
      console.log('contentClick:\n', this.status.oldSwipeChangeStatus);

      if (this.status.oldSwipeChangeStatus === 'none') {
        console.log('点击内容');
        uni.showToast({
          title: '点击内容',
          icon: 'none'
        })
      }
    },
    swipeClick(e, index) {
      let {
        content
      } = e;
      if (content.text === '删除') {
        uni.showModal({
          title: '提示',
          content: '是否删除',
          success: res => {
            if (res.confirm) {
              this.swipeList.splice(index, 1);
            } else if (res.cancel) {
              console.log('用户点击取消');
            }
          }
        });
      } else if (content.text === '添加') {
        if (this.swipeList.length < 10) {
          this.swipeList.push({
            id: new Date().getTime(),
            options: [{
              text: '置顶'
            },
              {
                text: '标记为已读',
                style: {
                  backgroundColor: 'rgb(254,156,1)'
                }
              },
              {
                text: '删除',
                style: {
                  backgroundColor: 'rgb(255,58,49)'
                }
              }
            ],
            content: '新增' + new Date().getTime()
          });
          uni.showToast({
            title: `添加了一条数据`,
            icon: 'none'
          });
        } else {
          uni.showToast({
            title: `最多添加十条数据`,
            icon: 'none'
          });
        }
      } else {
        debugger
        uni.showToast({
          title: `点击了${e.content.text}按钮`,
          icon: 'none'
        });
      }
    },
    trigger(e) {
      console.log(e)
      this.content[e.index].active = !e.item.active
      uni.showModal({
        title: '提示',
        content: `您${this.content[e.index].active ? '选中了' : '取消了'}${e.item.text}`,
        success: function (res) {
          if (res.confirm) {
            console.log('用户点击确定')
          } else if (res.cancel) {
            console.log('用户点击取消')
          }
        }
      })
    },
    fabClick() {
      uni.navigateTo({
        url: '/pages/knowledgeBase/knowledgeBase'
      })
      // uni.showToast({
      //   title: '点击了悬浮按钮',
      //   icon: 'none'
      // })
    }
  },
  watch: {
    '$route'() {
      this.init()
      // console.log("a")
      // 若路由产生变换（退出或提交成功切换回上一页时），将页面数据重置为初始值
      // Object.assign(this.$data, this.$options.data())
      // 此处别忘了加上created里需要执行的请求，因为在keep-alive的单页面中切换路由不会执行created钩子
    }
  }
};
</script>
<style lang="scss">
  page {
    background: #f2f2f2;
  }

  .card-actions {
    display: flex;
    flex-direction: row;
    justify-content: space-around;
    align-items: center;
    height: 45px;
    border-top: 1px #eee solid;
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

  .cover-image {
    flex: 1;
    height: 150px;
  }

  .no-border {
    border-width: 0;
  }

  .scroll-Y {
    height: 300 rpx;
  }

  .scroll-view_H {
    white-space: nowrap;
    width: 100%;
  }

  .scroll-view-item {
  //height: 300rpx;
  //line-height: 300rpx;
    text-align: center;
    font-size: 36 rpx;
  }

  .scroll-view-item_H {
    display: inline-block;
    width: 100%;
    height: 300 rpx;
    line-height: 300 rpx;
    text-align: center;
    font-size: 36 rpx;
  }

  .slot-content {
    .title {
    //font-weight: bold;
      font-size: 18px;
    }
    .desc {
      color: #9b9b9b;
      padding-top: 5px;
    //font-weight: bold;
      font-size: 14px;
    }
  }
</style>
