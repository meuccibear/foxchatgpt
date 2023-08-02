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
            <text class="uni-body uni-mt-5 title" >{{item.name}}</text>
          </view>
          <view slot="" class="desc">
            <text class="uni-body uni-mt-5">{{item.desc}}</text>
          </view>
        </view>
        <view slot="actions" class="card-actions">
          <!--          <view class="card-actions-item" @click="actionsClick('分享')">-->
          <!--            <uni-icons type="redo" size="18" color="#999"></uni-icons>-->
          <!--            <text class="card-actions-item-text">分享</text>-->
          <!--          </view>-->
          <view class="card-actions-item" data-type="edit" :data-id="item.id" @tap="actionClick">
            <uni-icons type="compose" size="18" color="#999"></uni-icons>
            <text class="card-actions-item-text">编辑</text>
          </view>
          <view class="card-actions-item" data-type="delete" :data-id="item.id" @tap="actionClick">
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
      type: 'help',
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
        selectedColor: '#007AFF',
        buttonColor: '#007AFF',
        iconColor: '#fff'
      }
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
    if (type == 'help') {
      uni.setNavigationBarTitle({
        title: '使用教程'
      })
    }
    // app.globalData.util.request({
    // 	url: '/article/getList',
    // 	data: {
    // 		type: type
    // 	}
    // }).then(res => {
    //   res = {"errno":0,"message":"","data":{"list":[{"id":7,"title":"\u767b\u5f55\u5e73\u53f0"},{"id":9,"title":"\u5bf9\u8bdd\u6a21\u5757"},{"id":10,"title":"\u521b\u4f5c\u6a21\u5757"},{"id":11,"title":"\u6a21\u62df\u6a21\u5757"},{"id":12,"title":"\u7ed8\u753b\u6a21\u5757"}]}}
    //   console.log(res)
    // 	this.setData({
    // 		list: res.data.list
    // 	})
    // })
    const res = {
      "errno": 0,
      "message": "",
      "data": {
        "list": [
          {
            id: 1,
            name: '知识库1',
            desc: '新塘镇陈家林路翡翠绿洲森林半岛6期73栋904',
            def: "额外"
          }, {
            id: 2,
            name: '知识库1',
            desc: '说明'
          }, {
            id: 3,
            name: '知识库1',
            desc: '说明'
          }, {
            id: 4,
            name: '知识库1',
            desc: '说明'
          }
        ]
      }
    }
    console.log(res)
    this.setData({
      list: res.data.list
    })
  },
  onShow() {
    uni.$on('item', (obj) => {
      console.log('obj:', obj)
    })
    uni.$on('isRefresh',function(data){
      console.log('监听到事件来自返回的参数：' + data);
      // TODO 下面执行刷新的方法
    })
  },
  methods: {
    actionClick(e) {
      const id = e.currentTarget.dataset.id
      const type = e.currentTarget.dataset.type
      console.log('actionClick', e, e.currentTarget.dataset.id)
      switch (type) {
        case 'edit':
          uni.navigateTo({
            url: '/pages/knowledgeBase/knowledgeBase?type=' + this.type + '&id=' + id
          })
          break
        case 'delete':

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
      uni.showToast({
        title: '点击了悬浮按钮',
        icon: 'none'
      })
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
