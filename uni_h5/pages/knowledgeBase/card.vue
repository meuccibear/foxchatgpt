<template>
	<view class="container">
    <scroll-view :scroll-top="scrollTop" scroll-y="true" class="scroll-Y" @scroll="scroll">
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
          <view class="card-actions-item" @tap="actionsClick('编辑')">
            <uni-icons type="compose" size="18" color="#999"></uni-icons>
            <text class="card-actions-item-text">编辑</text>
          </view>
          <view class="card-actions-item" @tap="actionsClick('删除')">
            <uni-icons type="trash" size="18" color="#999"></uni-icons>
            <text class="card-actions-item-text">删除</text>
          </view>
        </view>
      </uni-card>
    </scroll-view>
	</view>
</template>

<script>
	export default {
		components: {},
		data() {
			return {
        scrollTop: 0,
				cover: 'https://web-assets.dcloud.net.cn/unidoc/zh/shuijiao.jpg',
				avatar: 'https://web-assets.dcloud.net.cn/unidoc/zh/unicloudlogo.png',
				extraIcon: {
					color: '#4cd964',
					size: '22',
					type: 'gear-filled'
				},
        list: [
          {
            name: '知识库1',
            desc: '新塘镇陈家林路翡翠绿洲森林半岛6期73栋904',
            def: "额外"
          }, {
            name: '知识库1',
            desc: '说明'
          }, {
            name: '知识库1',
            desc: '说明'
          }, {
            name: '知识库1',
            desc: '说明'
          }
        ]
			}
		},
		methods: {
			actionsClick(text) {
				uni.showToast({
					title: text,
					icon: 'none'
				})
			}
		}
	}
</script>

<style lang="scss">
	.container {
		overflow: hidden;
	}

	//.custom-cover {
	//	flex: 1;
	//	flex-direction: row;
	//	position: relative;
	//}
  //
	//.cover-content {
	//	position: absolute;
	//	bottom: 0;
	//	left: 0;
	//	right: 0;
	//	height: 40px;
	//	background-color: rgba($color: #000000, $alpha: 0.4);
	//	display: flex;
	//	flex-direction: row;
	//	align-items: center;
	//	padding-left: 15px;
	//	font-size: 14px;
	//	color: #fff;
	//}

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
