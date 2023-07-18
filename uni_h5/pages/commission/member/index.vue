<template>
    <view>
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
                            </view>
                        </view>
                        <view class="subtitle">加入时间: {{ item.commission_time }}</view>
                    </view>

                    <view class="row-remark">
                        <view>已推{{ item.order_count }}笔订单</view>
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
            noMore: 0
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
            app.globalData.util
                .request({
                    url: '/commission/memberList',
                    page: page
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
    margin: 20rpx 0 30rpx 0;
    color: #999;
}
</style>
