<template>
    <view class="container">
        <view class="no-order" v-if="!list || list.length == 0">
            <image src="/static/images/commission/no-order.png" class="no-order-img"></image>
            <view class="text">没有记录</view>
        </view>
        <view class="cu-list record-list" v-else>
            <view class="cu-item flex align-start solid-bottom padding-sm" v-for="(item, index) in list" :key="index">
                <view class="thumb round">
                    <image src="/static/images/commission/ic_income.png" v-if="item.type == 1 || item.type == 4"></image>
                    <image src="/static/images/commission/ic_payout.png" v-else></image>
                </view>

                <view class="info">
                    <view class="flex justify-between">
                        <view class="text-black text-lg">{{ item.title }}</view>
                        <text class="text-green text-xl text-bold" v-if="item.type == 1 || item.type == 4">+￥{{ item.money }}</text>
                        <text class="text-orange text-xl text-bold" v-if="item.type == 2 || item.type == 3">-￥{{ item.money }}</text>
                    </view>
                    <view class="flex justify-between">
                        <text class="text-gray text-sm">{{ item.create_time }}</text>
                        <text class="text-orange text-sm" v-if="item.type == 1 && item.is_lock == 1">冻结中</text>
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
            noMore: 0,
            page: 1,
            type: 'all'
        };
    },
    onLoad: function (options) {
        if (options.type) {
            this.setData({
                type: options.type
            });
        }
        this.getList();
    },
    onReachBottom: function () {
        this.getList();
    },
    onPullDownRefresh: function () {
        this.refreshList();
        setTimeout(() => {
            uni.hideNavigationBarLoading();
            uni.stopPullDownRefresh();
        }, 500);
    },
    methods: {
        getList() {
            let page = this.page;
            app.globalData.util
                .request({
                    url: '/commission/billList',
                    data: {
                        type: this.type,
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

        switchTab: function (e) {
            let type = e.currentTarget.dataset.type;
            this.setData({
                type: type
            });
            this.refreshList();
        },

        refreshList: function () {
            this.setData({
                page: 1,
                list: []
            });
            this.getList();
        }
    }
};
</script>
<style>
page {
    background-color: #f7f7f7;
}
.container {
    width: 100%;
    min-height: 100%;
    overflow-x: hidden;
}

.tab-nav {
    position: fixed;
    top: 0;
    width: 100%;
    height: 88rpx;
    line-height: 88rpx;
    display: flex;
    justify-content: space-around;
    align-items: center;
    background-color: #fff;
    box-sizing: border-box;
    z-index: 99;
    border-top: 1rpx solid #eee;
    border-bottom: 1rpx solid #eee;
}

.tab {
    font-size: 28rpx;
    color: #233445;
    height: 60rpx;
    line-height: 60rpx;
    text-align: center;
    padding: 0 6rpx;
    position: relative;
    border-bottom: 6rpx solid #fff;
}

.active {
    color: #04babe;
    border-bottom: 6rpx solid #04babe;
}

.record-list {
    background-color: #fff;
    padding-top: 20rpx;
}

.record-list .cu-item {
    position: relative;
    display: flex;
    height: auto;
    justify-content: flex-end;
    align-items: flex-start;
    line-height: 1.4;
    padding: 12rpx 30rpx;
    border-bottom: 1px solid #f6f6f6;
}

.record-list .cu-item .thumb {
    border-radius: 10rpx;
    width: 48rpx;
    height: 48rpx;
    margin-right: 20rpx;
    background-size: cover cover;
    background-color: #fff;
}
.record-list .cu-item .thumb image {
    width: 100%;
    height: 100%;
}

.record-list .cu-item .info {
    line-height: 1.4;
    width: calc(100% - 80rpx);
    padding-right: 20rpx;
}

.record-list .cu-item .cu-btn {
    padding: 20rpx;
    width: 80rpx;
    height: 80rpx;
    line-height: 1.4;
}
.justify-between {
    display: flex;
    justify-content: space-between;
}
.text-lg {
    font-size: 28rpx;
}
.text-xl {
    font-size: 32rpx;
}
.text-bold {
    font-weight: bold;
}
.text-black {
    color: #333333;
}
.text-red {
    color: #e54d42;
}
.text-sm {
    font-size: 24rpx;
}
.text-gray {
    color: #8799a3;
}
.text-orange {
    color: #ff8000;
}
.text-green {
    color: #39b54a;
}
.text-blue {
    color: #0081ff;
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
    margin: 20rpx 0 30rpx 0;
    color: #999;
}
</style>
