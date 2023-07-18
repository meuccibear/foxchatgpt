<template>
    <view class="wrap">
        <view class="wallet">
			<view class="box-vip">
				<view class="body">
					<view style="display: flex; align-items: center">
						<image class="icon" src="/static/images/user/ic_vip.png"></image>
						<text>VIP会员</text>
						<view class="line"></view>
						<text v-if="vip_expire_time">{{ vip_expire_time }} 到期</text>
						<text v-else>未开通</text>
					</view>
				</view>
				<image class="bg" src="/static/images/user/bg-vip.png"></image>
			</view>
        </view>
		
		<view class="box" style="padding-right: 0; margin-top: 40rpx;" v-if="vipList && vipList.length > 0">
			<view class="box-title">
				<text>开通VIP会员</text>
				<text class="desc">高速通道，无限对话</text>
			</view>
			<view class="goods-list">
				<view :class="'goods ' + (item.id == goods_id ? 'active' : '')" @tap="chooseVip" :data-id="item.id" v-for="(item, index) in vipList" :key="index">
					<view class="title">
						<text class="num">{{ item.num }}</text>
						<text class="unit">个月</text>
					</view>

					<view class="price">
						特价
						<text>{{ item.price / 100 }}</text>
						元
					</view>

					<view class="market_price" v-if="item.market_price > 0">原价{{ item.market_price / 100 }}元</view>
				</view>
				<view style="clear: both"></view>
			</view>
			<button class="btn-pay" @tap="doPayVip" :disabled="!goods_id || paying">立即开通会员</button>
		</view>
    </view>
</template>

<script>
const app = getApp();
export default {
    data() {
        return {
            pageIsLoad: false,
            is_ios_pay: 0,
            system: '',
            vip_expire_time: '',
            vipList: [],
			type: 'vip',
            goods_id: 0,
            paying: false
        };
    },
    onLoad: function (options) {
        this.setData({
            system: app.globalData.system
        });
        app.globalData.util.checkLogin().then(() => {
            this.getGoodsList();
			this.getBalance();
            this.setData({
                pageIsLoad: true
            });
        });
    },
    onShow() {
        if (this.pageIsLoad) {
            this.getBalance();
        }
    },
    methods: {
		getGoodsList() {
            app.globalData.util
                .request({
                    url: '/order/getGoodsList',
					data: {
						type: 'vip'
					}
                })
                .then((res) => {
                    const vipList = res.data;
                    vipList.forEach((item) => {
                        if (item.is_default) {
                            this.setData({
                                goods_id: item.id
                            });
                        }
                    });
                    this.setData({
                        vipList: vipList
                    });
                });
        },

        getBalance() {
            app.globalData.util
                .request({
                    url: '/h5/getBalance',
                    loading: false
                })
                .then((res) => {
                    this.setData({
                        vip_expire_time: res.data.vip_expire_time
                    });
                });
        },

        chooseVip(e) {
            const id = e.currentTarget.dataset.id;
            this.setData({
                goods_id: id
            });
        },

        doPayVip: function () {
            if (this.paying) {
                return false;
            }
            var goods_id = this.goods_id;
            if (goods_id == 0) {
                app.globalData.util.message('请选择VIP套餐');
                return false;
            }
            this.setData({
                paying: true
            });
            setTimeout(() => {
                this.setData({
                    paying: false
				});
			}, 2000);
            app.globalData.util
                .request({
                    url: '/h5/createOrder',
                    data: {
						type: 'vip',
                        goods_id: goods_id
                    }
                })
                .then((res) => {
					app.globalData.jssdk.chooseWXPay({
						timestamp: res.data.timeStamp,
						nonceStr: res.data.nonceStr,
						package:res.data.package,
						signType: res.data.signType,
						paySign: res.data.paySign,
						success: function (res) {
							app.globalData.util.message('支付成功', 'error', function () {
								uni.redirectTo({
									url: '/pages/user/index'
								});
							});
						},
					    fail: function (res) {
					        app.globalData.util.message('发起支付失败', 'error');
					    }
					});
                });
        }
    }
};
</script>
<style>
page {
    margin: 0;
    padding: 0;
    background-color: #f7f7f7;
    font-family: '微软雅黑';
    padding-bottom: 30rpx;
}
.mod-title {
    padding: 30rpx 30rpx;
    font-size: 32rpx;
}
.mod-title text {
    padding-left: 16rpx;
    border-left: 8rpx solid #04babe;
    line-height: 24rpx;
    height: 30rpx;
}
.wallet {
    height: 180rpx;
    background: #333;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    color: #fff;
    text-align: center;
}

.box-vip {
    width: 690rpx;
    height: 100%;
    margin: 0 auto;
    border-style: none;
    border-width: 0;
    border: none;
    position: relative;
}

.box-vip .bg {
    position: absolute;
    left: 0;
    bottom: -10rpx;
    width: 100%;
    height: 94rpx;
    z-index: 1;
}

.box-vip .body {
    position: absolute;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    z-index: 2;
    font-size: 30rpx;
    color: #eed196;
    display: flex;
    align-items: center;
    justify-content: space-between;
    box-sizing: border-box;
}

.box-vip .body .icon {
    width: 88rpx;
    height: 88rpx;
}

.box-vip .body .line {
    margin: 0 20rpx;
    vertical-align: middle;
    display: inline-block;
    width: 1rpx;
    height: 32rpx;
    background: rgba(238, 209, 150, 0.5);
}


.goods-list {
    padding: 0 0 20rpx 0;
}
.goods {
    background: #f3f6f9;
    width: 290rpx;
    height: 206rpx;
    border-radius: 20rpx;
    text-align: center;
    padding: 20rpx 0;
    float: left;
    margin-right: 30rpx;
    box-sizing: border-box;
    border: 6rpx solid #f3f6f9;
    margin-top: 30rpx;
}
.goods .title {
    font-size: 48rpx;
    display: flex;
    align-items: baseline;
    justify-content: center;
    font-weight: bold;
}
.goods .title .unit {
    font-size: 28rpx;
    margin-left: 20rpx;
    font-weight: normal;
}
.goods .price {
    font-size: 28rpx;
    margin: 10rpx 0;
    color: #444;
}
.goods .price text {
    color: red;
    margin: 0 6rpx;
}
.goods .market_price {
    color: #999;
    text-decoration: line-through;
    font-size: 24rpx;
}
.goods.active {
    border-color: #eed196;
}
.btn-pay {
    width: 400rpx;
    height: 80rpx;
    padding: 10rpx;
	background: #333;
	color: #eed196;
	border: none;
    border-radius: 100rpx;
    font-size: 30rpx;
    outline: none;
    margin: 100rpx 0 30rpx 110rpx;
    box-sizing: border-box;
    display: flex;
    justify-content: center;
    align-items: center;
    letter-spacing: 2rpx;
}
.btn-pay::after {
    display: none;
}
.btn-pay:active {
    transform: scale(0.9);
}

.box {
    width: 690rpx;
    background: #fff;
    margin: 0 30rpx 30rpx 30rpx;
    border-radius: 20rpx;
    overflow: hidden;
    padding: 30rpx 40rpx;
    box-sizing: border-box;
}
.box .box-title {
    width: 100%;
    height: 72rpx;
    line-height: 72rpx;
    font-size: 32rpx;
    color: #333;
    font-weight: bold;
}
.box .box-title .desc {
    font-weight: normal;
    color: #999;
    font-size: 24rpx;
    margin-left: 20rpx;
}
</style>
