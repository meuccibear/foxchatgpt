<template>
    <view>
        <!-- <loading v-if="!show">加载中...</loading> -->
        <view class="page commission">
            <view class="user-info">
                <view class="fui-list">
                    <view class="fui-list-media">
                        <image :src="member['avatar']" v-if="member['avatar']"></image>
                        <image src="/static/images/avatar.png" v-else></image>
                    </view>
                    <view class="fui-list-inner">
                        <view class="title">{{ member['nickname'] ? member['nickname'] : '无昵称' }}</view>
                        <!-- <view class="text" v-if="member['commission_puser']">推荐人：{{ member['commission_puser'] }}</view> -->
                        <view class="subtitle">{{ member['commission_title'] }}</view>
                    </view>
                </view>
            </view>
            <view class="userblock">
                <view class="line able">
                    <view class="text">
                        <view class="num">{{ commission['money'] }}</view>
                        <view class="title">可提现佣金(元)</view>
                    </view>
                    <view class="btn btn-warning pull-right" @tap="toWithdraw">申请提现</view>
                </view>
                <view class="fui-cell-group" style="margin-top: 2rpx">
                    <navigator class="fui-cell" url="/pages/commission/withdraw/list" style="padding: 16rpx 24rpx; background: #eefdfd">
                        <image class="icon" src="/static/images/commission/ic_withdraw.png"></image>
                        <view class="fui-cell-text" style="color: #777; font-size: 24rpx">提现记录</view>
                        <image class="icon-r" src="/static/images/ic_arrow_r.png"></image>
                    </navigator>
                </view>
            </view>
            <view class="fui-block-group">
                <navigator class="fui-block-child" url="/pages/commission/bill">
                    <view class="icon" style="color: #ff4357">
                        <image src="/static/images/commission/ic_wallet.png"></image>
                    </view>
                    <view class="text">
                        <view class="title">佣金明细</view>
                        <text>{{ commission['total'] }}</text>
                        元
                    </view>
                </navigator>
                <navigator class="fui-block-child" url="/pages/commission/member/index">
                    <view class="icon" style="color: #ff6e02">
                        <image src="/static/images/commission/ic_invite.png"></image>
                    </view>
                    <view class="text">
                        <view class="title">我的下级</view>
                        <text>{{ commission['member_count'] }}</text>
                        人
                    </view>
                </navigator>
                <navigator class="fui-block-child" url="/pages/commission/member/tuser">
                    <view class="icon" style="color: #9ec9f4">
                        <image src="/static/images/commission/ic_member.png"></image>
                    </view>
                    <view class="text">
                        <view class="title">直推用户</view>
                        <text>{{ commission['tuser_count'] }}</text>
                        人
                    </view>
                </navigator>
                <navigator class="fui-block-child" url="/pages/commission/order/index">
                    <view class="icon" style="color: #9ec9f4">
                        <image src="/static/images/commission/ic_order.png"></image>
                    </view>
                    <view class="text">
                        <view class="title">推广的订单</view>
                        <text>{{ commission['order_count'] }}</text>
                        笔
                    </view>
                </navigator>
            </view>
            <view class="fui-cell-group" style="border-radius: 10rpx">
                <!-- <navigator class="fui-cell" url="/pages/commission/member/invite" v-if="member.commission_pid == 0">
                    <image class="icon" src="/static/images/commission/ic_invite.png"></image>
                    <view class="fui-cell-text">邀请下级推广员</view>
                    <image class="icon-r" src="/static/images/ic_arrow_r.png"></image>
                </navigator> -->
                <navigator class="fui-cell" @tap="showShareTips">
                    <image class="icon" src="/static/images/commission/ic_haibao.png"></image>
                    <view class="fui-cell-text">推广新用户</view>
                    <image class="icon-r" src="/static/images/ic_arrow_r.png"></image>
                </navigator>
            </view>
        </view>
		<view class="share_tips" v-if="shareTipsShow" @click="closeShareTips">
			<image src="/static/images/share_tips.png"></image>
		</view>
		
		<view class="footer">
			<navigator class="agreement" url="/pages/article/article?type=commission" style="color:#04BABE; text-decoration: underline;">《用户推广协议》</navigator>
		</view>
    </view>
</template>

<script>
const app = getApp();
export default {
    data() {
        return {
            member: {
                commission_pid: 0
            },
            commission: {},
			shareTipsShow: false
        };
    },
    onShow() {
        this.getData();
    },
    onPullDownRefresh() {
        this.getData();
        setTimeout(() => {
            uni.hideNavigationBarLoading(); //完成停止加载
            uni.stopPullDownRefresh(); //停止下拉刷新
        }, 500);
    },
    methods: {
        getData() {
            app.globalData.util
                .request({
                    url: '/commission/index'
                })
                .then((res) => {
                    if (!res.data) {
                        uni.redirectTo({
                            url: '/pages/commission/apply'
                        });
                        return;
                    }
                    this.setData({
                        member: res.data.member,
                        commission: res.data.commission
                    });
                });
        },

        toWithdraw() {
            let commission = this.commission;
            if (!commission || !commission.money) {
                app.globalData.util.message('暂无可提现佣金');
                return;
            }
            uni.navigateTo({
                url: '/pages/commission/withdraw/index?money=' + commission.money
            });
        },

        showShareTips() {
            this.setData({
        		shareTipsShow: true
        	})
        },
        
        closeShareTips() {
            this.setData({
        		shareTipsShow: false
        	})
        }
    }
};
</script>
<style>
page {
    background: #f7f7f7;
}
.page {
    overflow-x: hidden;
    height: auto;
    min-height: 100%;
    overflow-y: scroll;
    padding: 20rpx;
}
.fui-list {
    position: relative;
    display: flex;
    padding: 30rpx 24rpx;
    transition-duration: 300ms;
    align-items: center;
    overflow: hidden;
}
.fui-list-media {
    display: flex;
    flex-shrink: 0;
    flex-wrap: nowrap;
    box-sizing: border-box;
    align-items: center;
    margin-right: 20rpx;
    color: #333;
    position: relative;
}
.fui-list-inner {
    position: relative;
    flex: 1;
    overflow: hidden;
    box-sizing: border-box;
    display: block;
}

.fui-block-group {
    height: auto;
    overflow: hidden;
    background: #fff;
    position: relative;
    margin-top: 24rpx;
    border-radius: 16rpx;
    overflow: hidden;
}
.fui-block-group .fui-block-child {
    height: auto;
    width: 33.33%;
    float: left;
    padding: 16rpx 0;
    background: #fff;
    transition: background-color 300ms;
    -webkit-transition: background-color 300ms;
    position: relative;
}
.fui-block-group .fui-block-child .icon {
    height: 108rpx;
    padding-top: 40rpx;
    text-align: center;
    font-size: 56rpx;
    line-height: 60rpx;
}
.fui-cell-group {
    margin-top: 24rpx;
    background-color: #fff;
    line-height: 1.4;
    font-size: 32rpx;
    overflow: hidden;
    position: relative;
}

.fui-cell-group .fui-cell {
    position: relative;
    padding: 24rpx;
    display: flex;
    align-items: center;
    border-bottom: 1px solid #f8f8f8;
}
.fui-cell-group .fui-cell:last-child {
    border-bottom: none;
}
.fui-cell-group .fui-cell .icon {
    margin-right: 12rpx;
    width: 32rpx;
    height: 32rpx;
}
.fui-cell-group .fui-cell .fui-cell-text {
    flex: 1;
    color: #444;
    font-size: 28rpx;
}
.fui-cell-group .fui-cell .icon-r {
    margin-right: 8rpx;
    width: 26rpx;
    height: 26rpx;
}

.commission .user-info {
    width: 100%;
    border-bottom: 1px solid #04babe;
    background: #04babe;
    padding: 8rpx 0;
    border-radius: 16rpx;
}

.commission .user-info image {
    border-radius: 50%;
    width: 120rpx;
    height: 120rpx;
    background: #f7f7f7;
}

.commission .fui-list-media {
    margin-right: 28rpx;
}

.commission .user-info .title {
    color: #fff;
    font-size: 30rpx;
    line-height: 40rpx;
    margin-bottom: 10rpx;
    font-weight: bold;
    white-space: nowrap;
    text-overflow: ellipsis;
    overflow: hidden;
}

.commission .user-info .subtitle {
    color: #fff;
    font-size: 22rpx;
    white-space: nowrap;
    text-overflow: ellipsis;
    overflow: hidden;
    width: auto;
    display: inline-block;
    border: 1rpx solid rgb(255, 255, 255);
    border-radius: 30rpx;
    line-height: 36rpx;
    max-width: 100%;
    padding: 0 16rpx;
    box-sizing: border-box;
}

.commission .user-info .text {
    color: #fff;
    font-size: 22rpx;
    line-height: 40rpx;
    white-space: nowrap;
    text-overflow: ellipsis;
    overflow: hidden;
}

.commission .userblock {
    margin-top: 24rpx;
    border-radius: 16rpx;
    overflow: hidden;
}

.commission .userblock .line {
    padding: 15rpx 0 15rpx 0;
}

.commission .userblock .line.total {
    height: 166rpx;
    background: #fff;
    padding: 32rpx 24rpx;
    box-sizing: border-box;
}

.commission .userblock .line.total .title {
    color: #333;
    font-size: 24rpx;
    white-space: nowrap;
    text-overflow: ellipsis;
    overflow: hidden;
}

.commission .userblock .line.total .num {
    font-size: 44rpx;
    color: #04babe;
    line-height: 1.5;
    font-weight: bold;
}

.commission .userblock .line.able {
    font-size: 27rpx;
    height: 166rpx;
    background: #fff;
    padding: 0 24rpx;
    display: -webkit-box;
    display: -webkit-flex;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-align: center;
    -ms-flex-align: center;
    align-items: center;
    position: relative;
    -webkit-box-pack: justify;
    -ms-flex-pack: justify;
    justify-content: space-between;
}

.commission .userblock .line.able .num {
    font-size: 44rpx;
    color: #04babe;
    line-height: 1.5;
    font-weight: bold;
}

.commission .userblock .line .text {
    padding-right: 230rpx;
}

.commission .userblock .line .btn {
    width: auto;
    padding: 0 24rpx;
    border: 1px solid #fff;
    border-radius: 56rpx;
    height: 56rpx;
    line-height: 54rpx;
    margin-right: 0;
    font-size: 26rpx;
}
.btn-warning {
    background: #04babe;
    color: #fff;
    border: 1px solid #04babe;
}

.commission .userblock .line.able:after {
    content: ' ';
    position: absolute;
    left: 20rpx;
    right: 20rpx;
    top: -1px;
    height: 1px;
    border-top: 1px solid #ebebeb;
    color: #d9d9d9;
    -ms-transform-origin: 0 0;
    transform-origin: 0 0;
    -ms-transform: scaleY(0.5);
    transform: scaleY(0.5);
}

.commission .fui-block-group {
}

.commission .fui-block-group:after {
    content: ' ';
    position: absolute;
    left: 20rpx;
    right: 20rpx;
    top: 50%;
    height: 1px;
    border-top: 1px solid #ebebeb;
    color: #d9d9d9;
    -ms-transform-origin: 0 0;
    transform-origin: 0 0;
    -ms-transform: scaleY(0.5);
    transform: scaleY(0.5);
}

.commission .fui-block-group:before {
    content: ' ';
    position: absolute;
    top: 20rpx;
    bottom: 20rpx;
    left: 50%;
    width: 1px;
    border-left: 1px solid #ebebeb;
    color: #d9d9d9;
    -ms-transform-origin: 0 0;
    transform-origin: 0 0;
    -ms-transform: scaleX(0.5);
    transform: scaleX(0.5);
    z-index: 2;
}

.commission .fui-block-group .fui-block-child {
    width: 50%;
    display: -webkit-box;
    display: -webkit-flex;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-align: center;
    -ms-flex-align: center;
    align-items: center;
    -webkit-box-pack: start;
    -ms-flex-pack: start;
    justify-content: flex-start;
    padding-left: 24rpx;
    height: 148rpx;
    box-sizing: border-box;
}

.fui-block-group .fui-block-child::after {
    display: none;
}

.fui-block-group .fui-block-child::before {
    display: none;
}

.commission .fui-block-group .fui-block-child .icon {
    height: auto;
    padding: 0;
}

.fui-block-group .fui-block-child .icon i {
    font-size: 52rpx;
}

.commission .fui-block-group .fui-block-child .icon image {
    width: 70rpx;
    height: 70rpx;
}

.commission .fui-block-group .fui-block-child .text {
    height: auto;
    line-height: 1.5;
    margin-left: 24rpx;
    font-size: 24rpx;
    color: #999;
    text-align: left;
}

.commission .fui-block-group .fui-block-child .title {
    height: auto;
    line-height: normal;
    font-size: 28rpx;
    color: #333;
    text-align: left;
}

.commission .fui-block-group .fui-block-child .text text {
    color: #999;
}

.edtion {
    width: 100%;
    position: fixed;
    bottom: 100rpx;
    color: #999999;
    font-size: 28rpx;
    text-align: center;
    padding: 20rpx 0;
}

.li-wrap {
    display: flex;
    align-items: center;
    margin-bottom: 2rpx;
    background: #fff;
    flex-direction: column;
    padding-left: 30rpx;
}

.li-wrap .list {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
    height: 100rpx;
    box-sizing: border-box;
    border-bottom: 1rpx solid #f1f1f1;
    padding-right: 30rpx;
}

.li-wrap .list:last-child {
    border-bottom: none;
}

.li-wrap .list .list-l {
    display: flex;
    justify-content: flex-start;
    align-items: center;
}

.li-wrap .list .list-l .icon {
    width: 40rpx;
    height: 40rpx;
    margin-right: 20rpx;
    /* background: #f1f1f1; */
}

.li-wrap .list .list-l .icon .img {
    width: 40rpx;
    height: 40rpx;
}

.li-wrap .list .list-l .text {
    font-size: 32rpx;
    color: #333333;
}

.li-wrap .list .arrow {
    width: 26rpx;
    height: 26rpx;
    /* border-top: 4rpx solid #ccc;
    border-right: 4rpx solid #ccc;
    transform: rotate(45deg); */
}
.li-wrap .list .arrow image {
    width: 26rpx;
    height: 26rpx;
}
.share_tips {
	position: fixed;
	width: 100%;
	height: 100%;
	left: 0;
	top: 0;
	z-index: 999;
	background: rgba(0, 0, 0, 0.8);
}
.share_tips image {
	width: 500rpx;
	height: 400rpx;
	margin: 0 auto;
	float: right;
	margin-right: 20px;
}

.footer {
    font-size: 26rpx;
    margin: 60rpx 0;
    text-align: center;
    width: 100%;
}
.footer navigator {
    display: inline;
}
</style>
