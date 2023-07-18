<template>
    <view class="wrap">
        <view class="wallet">
            <view class="balance" style="margin-top: 12rpx">
                对话余额
                <text>{{ balance }}</text>
                条
            </view>
            <view v-if="vip_expire_time" style="margin-top: 20rpx;">
				<text class="tips">您已开通vip会员，期间不消耗余额</text>
			</view>
        </view>
        <view class="box" style="padding-right: 0" v-if="goodsList && goodsList.length > 0">
			<view class="box-title">
				<text>充值对话次数</text>
				<text class="desc">永不过期，文字类对话可用</text>
			</view>
			<view class="goods-list">
				<view :class="'goods ' + (item.id == goods_id ? 'active' : '')" @tap="chooseGoods" :data-id="item.id" v-for="(item, index) in goodsList" :key="index">
					<view class="title">
						<text class="num">{{ item.num }}</text>
						<text class="unit">条</text>
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
			<button class="btn-pay" @tap="doPayGoods" :disabled="!goods_id || paying">立即充值</button>
		</view>
    </view>
</template>

<script>

const app = getApp();
export default {
    data() {
        return {
            pageIsLoad: false,
            system: '',
            balance: 0,
            vip_expire_time: '',
            goodsList: [],
			type: 'goods',
            goods_id: 0,
            paying: false
        };
    },
    onLoad: function (options) {
        this.setData({
            system: app.globalData.system
        });
        app.globalData.util.checkLogin().then(() => {
            this.getBalance();
            this.getGoodsList();
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
        getBalance() {
            app.globalData.util
                .request({
                    url: '/h5/getBalance',
                    loading: false
                })
                .then((res) => {
                    this.setData({
                        balance: res.data.balance,
                        vip_expire_time: res.data.vip_expire_time
                    });
                });
        },
        getGoodsList() {
            app.globalData.util
                .request({
                    url: '/order/getGoodsList',
					data: {
						type: 'goods'
					}
                })
                .then((res) => {
                    const goodsList = res.data;
                    goodsList.forEach((item) => {
                        if (item.is_default) {
                            this.setData({
                                goods_id: item.id
                            });
                        }
                    });
                    this.setData({
                        goodsList: goodsList
                    });
                });
        },

        chooseGoods(e) {
            const id = e.currentTarget.dataset.id;
            this.setData({
                goods_id: id
            });
        },
		
        doPayGoods: function () {
            if (this.paying) {
                return false;
            }
            var goods_id = this.goods_id;
            if (goods_id == 0) {
                app.globalData.util.message('请选择充值套餐');
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
						type: this.type,
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
    background: #f7f7f7;
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
    height: 160rpx;
    background: #04babe;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    color: #fff;
    padding-bottom: 110rpx;
    margin-bottom: -80rpx;
}
.wallet .balance {
    font-size: 36rpx;
    text-align: center;
}
.wallet .balance text {
    font-size: 48rpx;
    margin: 0 14rpx;
    color: red;
    font-weight: bold;
}
.wallet .vip {
    color: #eee;
}
.wallet .tips {
	font-size: 24rpx;
	color: #eed196;
	font-weight: normal;
	padding: 6rpx 20rpx;
	border-radius: 10rpx;
	background: #333;
}
.goods-list {
    padding: 0 0 20rpx 0;
}
.goods {
    background: #f3f6f9;
    width: 292rpx;
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
    border-color: #04babe;
}
.btn-pay {
    width: 400rpx;
    height: 80rpx;
    padding: 10rpx;
    background-color: #04babe;
    border-radius: 100rpx;
    color: #fff;
    font-size: 30rpx;
    border: none;
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
    padding: 20rpx 40rpx;
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
