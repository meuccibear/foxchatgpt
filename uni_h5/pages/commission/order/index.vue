<template>
    <view class="container">
        <view class="no-order" v-if="!orderList || orderList.length == 0">
            <image src="/static/images/commission/no-order.png" class="no-order-img"></image>
            <view class="text">没有记录</view>
        </view>
        <view class="wrap" v-else>
            <view class="box-order" v-for="(item, index) in orderList" :key="index">
                <view class="order-header">
                    <view class="user">
                        <image :src="item.avatar"></image>
                        <text>{{ item.nickname }}</text>
                    </view>
                    <view class="status">
                        <view class="pay-status">
                            <text>已付款</text>
                        </view>
                    </view>
                </view>

                <view class="order-info">
                    <view class="row">
                        <view class="label">订单编号：</view>
                        <view class="content">{{ item.out_trade_no }}</view>
                    </view>
                    <view class="row">
                        <view class="label">付款时间：</view>
                        <view class="content">{{ item.pay_time }}</view>
                    </view>
                    <view class="row">
                        <view class="label">订单金额：</view>
                        <view class="content">￥{{ item.total_fee }}</view>
                    </view>
                    <view class="row">
                        <view class="label">推荐人：</view>
                        <view class="content">
                            <view class="user" v-if="item.commission1">
                                <image :src="item.commission1.avatar"></image>
                                <text>{{ item.commission1.nickname }}</text>
                                <text class="fee">（佣金￥{{ item.commission1.fee }}）</text>
                            </view>
                            <view class="user" v-if="item.commission2" style="margin-top: 10rpx">
                                <image :src="item.commission2.avatar"></image>
                                <text>{{ item.commission2.nickname }}</text>
                                <text class="fee">（佣金￥{{ item.commission2.fee }}）</text>
                            </view>
                        </view>
                    </view>
                </view>
            </view>
            <view v-if="noMore" class="no-more-order">没有更多了~</view>
        </view>
    </view>
</template>

<script>
const app = getApp();
export default {
    data() {
        return {
            orderList: [],
            noMore: 0,
            page: 1,
            showStatus: 'all'
        };
    },
    onLoad(options) {
        if (options.status) {
            this.setData({
                showStatus: options.status
            });
        }
        this.getOrderList();
    },
    onPullDownRefresh() {
        this.refreshList();
        setTimeout(() => {
            uni.hideNavigationBarLoading();
            uni.stopPullDownRefresh();
        }, 500);
    },
    onReachBottom() {
        this.getOrderList();
    },
    methods: {
        getOrderList() {
            let page = this.page;
            let orderList = this.orderList;
            app.globalData.util
                .request({
                    url: '/commission/orderList',
                    data: {
                        page: page
                    }
                })
                .then((res) => {
                    if (res.data.length > 0) {
                        this.setData({
                            orderList: orderList.concat(res.data),
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
            let showStatus = e.currentTarget.dataset.status;
            this.setData({
                showStatus: showStatus
            });
            this.refreshList();
        },

        refreshList: function () {
            this.setData({
                page: 1,
                orderList: []
            });
            this.getOrderList();
        }
    }
};
</script>
<style>
page {
    background-color: #f7f7f7;
    height: 100%;
}

.container {
    width: 100%;
    min-height: 100%;
    overflow-x: hidden;
    position: relative;
}

.tab-nav {
    position: fixed;
    top: 0rpx;
    width: 100%;
    height: 88rpx;
    line-height: 88rpx;
    display: flex;
    justify-content: space-around;
    align-items: center;
    background-color: #fff;
    /* padding: 0 24rpx; */
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

.list-num {
    position: absolute;
    top: -2rpx;
    right: -12rpx;
    width: 30rpx;
    height: 30rpx;
    font-size: 20rpx;
    background: #ff3456;
    color: #fff;
    /* border: 1rpx solid #ff3456; */
    border-radius: 30rpx;
    text-align: center;
    line-height: 30rpx;
}

.active {
    color: #ff3456;
    border-bottom: 6rpx solid #ff3456;
}

.default {
    color: #233445;
    border-bottom: 6rpx solid #fff;
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

.wrap {
    height: auto;
    width: 100%;
    padding-bottom: 50rpx;
}

.box-order {
    background: #fff;
    margin: 30rpx 20rpx 0rpx 20rpx;
    border-radius: 10rpx;
    padding-bottom: 30rpx;
}

.user {
    font-size: 28rpx;
    font-weight: 500;
    color: #333333;
    line-height: 32rpx;
    display: flex;
    justify-content: flex-end;
    align-items: center;
}

.user image {
    width: 48rpx;
    height: 48rpx;
    border-radius: 50%;
    margin-right: 10rpx;
}

.user .fee {
    font-size: 24rpx;
    color: #ff3456;
}

.order-header {
    height: 90rpx;
    padding: 0 24rpx;
    line-height: 90rpx;
    display: flex;
    justify-content: space-between;
    /* border-bottom: 1rpx solid #f4f4f4; */
}
.order-header .status {
    display: flex;
    justify-content: flex-end;
    align-items: center;
}

.order-header .status .pay-status {
    padding: 8rpx 20rpx;
    height: 28rpx;
    font-size: 28rpx;
    font-weight: 500;
    color: #04babe;
    line-height: 32rpx;
}

.order-info {
    padding: 20rpx 30rpx;
    border-radius: 10rpx;
    background-color: #fafafa;
    margin: 0 30rpx;
    font-size: 28rpx;
    color: #666;
}

.order-info .row {
    display: flex;
    justify-content: space-between;
    width: 100%;
    padding: 8rpx 0;
}

.order-info .row .label {
    min-width: 160rpx;
}

.order-info .row .goods-price {
    color: #ff5151;
    font-size: 30rpx;
}

.order-info .row .goods-num {
    font-size: 28rpx;
    color: #666;
    height: 48rpx;
    line-height: 48rpx;
}

.order-info .row .content .user {
    font-size: 24rpx;
}
.order-info .row .content .user image {
    width: 36rpx;
    height: 36rpx;
}

.no-more-order {
    text-align: center;
    font-size: 28rpx;
    margin: 20rpx 0 30rpx 0;
    color: #999;
}
</style>
