<template>
    <view class="container">
        <view class="no-order" v-if="list.length <= 0">
            <image src="/static/images/commission/no-order.png" class="no-order-img"></image>
            <view class="text">没有记录</view>
        </view>
        <view v-else class="wrap">
            <view class="box-order" v-for="(item, index) in list" :key="index">
                <view class="order-header">
                    <view class="user">
                        <text>{{ item.create_time }}</text>
                    </view>
                    <view class="status">
                        <view class="pay-status">
                            <text class="text-blue" v-if="item.status == 0">审核中</text>
                            <text class="text-green" v-if="item.status == 1">已完成</text>
                            <text class="text-red" v-if="item.status == 2">被驳回</text>
                        </view>
                    </view>
                </view>

                <view class="order-info">
                    <view class="row">
                        <view class="label">提现方式：</view>
                        <view class="content">{{ item.bank_name }}</view>
                    </view>
                    <view class="row">
                        <view class="label">户名：</view>
                        <view class="content">{{ item.account_name }}</view>
                    </view>
                    <view class="row" v-if="item.bank_name != '微信零钱'">
                        <view class="label">账号：</view>
                        <view class="content">{{ item.account_number }}</view>
                    </view>
                    <view class="row">
                        <view class="label">提现金额：</view>
                        <view class="content">￥{{ item.money }}</view>
                    </view>
                    <view class="row text-red" v-if="item.status == 2 && item.reject_reason">
                        <view class="label">驳回原因：</view>
                        <view class="content">
                            {{ item.reject_reason }}
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
            list: [],
            noMore: 0,
            page: 1
        };
    },
    onLoad(options) {
        this.getList();
    },
    onReachBottom: function () {
        this.getList();
    },
    onPullDownRefresh: function () {
        this.setData({
            page: 1,
            list: []
        });
        this.getList();
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
                    url: '/commission/withdrawList',
                    data: {
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

.default {
    color: #233445;
    border-bottom: 6rpx solid #fff;
}

.no-order {
    width: 100%;
    display: none;
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
    color: #ff0000;
    line-height: 32rpx;
}

.order-header .status .order-status {
    color: #ff3456;
    font-size: 28rpx;
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

.text-red {
    color: #e54d42;
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
</style>
