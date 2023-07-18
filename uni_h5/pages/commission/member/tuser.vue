<template>
    <view>
		<view class="tab-nav">
			<view class="tab" :class="{active: curTab == 1}" @tap="switchTab" data-index="1">直接推荐</view>
			<view class="tab" :class="{active: curTab == 2}" @tap="switchTab" data-index="2">间接推荐</view>
		</view>
        <view class="no-order" v-if="!list || list.length == 0">
            <image src="/static/images/commission/no-order.png" class="no-order-img"></image>
            <view class="text">没有记录</view>
        </view>
        <view class="page navbar com-down" v-else>
            <view class="fui-list-group">
                <view class="fui-list" v-for="(item, index) in list" :key="index">
                    <view class="fui-list-media">
                        <image :src="item.avatar"></image>
                    </view>

                    <view class="fui-list-inner">
                        <view class="row">
                            <view class="row-text">
                                {{ item.nickname || '无昵称' }}
                                <text style="font-size: 24rpx; color: #666" v-if="item.id">(MID:{{ item.id }})</text>
                            </view>
                        </view>
                        <view class="subtitle">注册时间: {{ item.create_time }}</view>
                    </view>

                    <view class="row-remark">
                        <view>
                            共消费
                            <text style="color: red; margin: 0 4rpx">{{ item.order_count }}</text>
                            笔
                        </view>
                    </view>
                </view>
            </view>
            <view v-if="noMore" class="no-more">没有更多了~</view>
        </view>
    </view>
</template>

<script>
const app = getApp();
export default {
    data() {
        return {
            list: [],
            page: 1,
            noMore: 0,
			curTab: 1
        };
    },
    onLoad() {
        this.getList();
    },
    onReachBottom() {
        this.getList();
    },
    onPullDownRefresh() {
        this.setData({
            page: 1,
            list: [],
            noMore: 0
        });
        this.getList();
    },
    methods: {
        getList() {
            let page = this.page;
			let curTab = this.curTab
            app.globalData.util
                .request({
                    url: '/commission/tuserList',
                    data: {
						type: curTab,
                        page: page
                    }
                })
                .then((res) => {
                    if (res.data.length > 0) {
                        this.setData({
                            list: this.list.concat(res.data),
                            noMore: 0,
                            page: page + 1
                        });
                    } else {
                        this.setData({
                            noMore: 1
                        });
                    }
                });
        },
		
		switchTab(e) {
			const index = e.currentTarget.dataset.index
			this.setData({
				curTab: index,
				page: 1,
				list: [],
				noMore: 0
			})
			this.getList()
		},
    }
};
</script>
<style>
page {
    background-color: #f7f7f7;
    padding-top: 88rpx;
}
.tab-nav {
    position: fixed;
    top: 0;
    width: 100%;
    height: 88rpx;
    line-height: 88rpx;
    background-color: #fff;
    box-sizing: border-box;
    z-index: 99;
    border-top: 1rpx solid #eee;
    border-bottom: 1rpx solid #eee;
    overflow: hidden;
    display: flex;
}

.tab {
    font-size: 28rpx;
    color: #233445;
    width: 50%;
    height: 88rpx;
    line-height: 88rpx;
    text-align: center;
    padding: 0 6rpx;
    position: relative;
    box-sizing: border-box;
    border-bottom: 6rpx solid #fff;
}

.tab.active {
    color: #04babe;
    border-bottom: 6rpx solid #04babe;
}
.fui-list {
    position: relative;
    display: flex;
    padding: 16rpx 24rpx;
    transition-duration: 300ms;
    align-items: center;
    overflow: hidden;
    background-color: #fff;
}
.fui-list-media {
    display: flex;
    flex-shrink: 0;
    flex-wrap: nowrap;
    box-sizing: border-box;
    align-items: center;
    margin-right: 20rpx;
    color: #000;
    position: relative;
}
.fui-list-inner {
    position: relative;
    flex: 1;
    overflow: hidden;
    box-sizing: border-box;
    display: block;
}

.com-down .subtitle {
    font-size: 24rpx;
    margin-top: 10rpx;
    color: #999;
}

.com-down .image-32 {
    width: 32rpx;
    height: 32rpx;
}

image {
    vertical-align: top;
}

.com-down .fui-list-media image {
    width: 80rpx;
    height: 80rpx;
    border: 1px solid #f2f2f2;
    background: #f7f7f7;
}

.com-down .fui-list-inner .row {
    font-size: 28rpx;
}

.com-down .row-remark {
    text-align: right;
    position: relative;
    flex-shrink: 0;
    padding-left: 25rpx;
    min-width: 150rpx;
    color: #000;
    font-size: 24rpx;
}

.no-order {
    width: 100%;
    position: absolute;
    bottom: 0;
    top: 88rpx;
    left: 0;
    right: 0;
    text-align: center;
    padding-top: 203rpx;
    display: block;
}
.no-order-img {
    width: 100rpx;
    height: 100rpx;
    margin-bottom: 30rpx;
}

.no-order .text {
    font-size: 30rpx;
    color: #999;
    text-align: center;
    margin-bottom: 30rpx;
}
.no-more {
    text-align: center;
    font-size: 28rpx;
    padding: 20rpx 0 30rpx 0;
    color: #999;
}
</style>
