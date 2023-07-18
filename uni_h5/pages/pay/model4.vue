<template>
    <view class="wrap">
        <view class="wallet">
            <view class="balance" style="margin-top: 12rpx">
                {{model4Name}}余额
                <text>{{ balance_model4 }}</text>
                万字
            </view>
        </view>
        <view class="box" style="padding-right: 0" v-if="model4List && model4List.length > 0">
			<view class="box-title">
				<text>充值{{model4Name}}余额</text>
				<text class="desc">仅 {{model4Name}} 模型可用</text>
			</view>
			<view class="model4-list">
				<view :class="'model4 ' + (item.id == goods_id ? 'active' : '')" @tap="chooseModel4" :data-id="item.id" v-for="(item, index) in model4List" :key="index">
					<view class="title">
						<text class="num">{{ item.num }}</text>
						<text class="unit">万字</text>
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
			<button class="btn-pay" @tap="doPayModel4" :disabled="!goods_id || paying">立即充值{{model4Name}}</button>
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
            balance_model4: 0,
            model4List: [],
			type: 'model4',
            goods_id: 0,
            paying: false,
			hasModel4: false,
			model4Name: ''
        };
    },
    onLoad: function (options) {
        this.setData({
            system: app.globalData.system
        });
        app.globalData.util.checkLogin().then(() => {
            this.getBalance();
			this.checkModel4();
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
                        balance_model4: res.data.balance_model4
                    });
                });
        },
        getGoodsList() {
            app.globalData.util
                .request({
                    url: '/order/getGoodsList',
					data: {
						type: 'model4'
					}
                })
                .then((res) => {
                    const model4List = res.data;
                    model4List.forEach((item) => {
                        if (item.is_default) {
                            this.setData({
                                goods_id: item.id
                            });
                        }
                    });
                    this.setData({
                        model4List: model4List
                    });
                });
        },
		
		checkModel4() {
			app.globalData.util
				.request({
					url: '/h5/hasModel4',
					data: {
						from: 'h5'
					},
					loading: false
				})
				.then((res) => {
					this.setData({
						hasModel4: res.data.hasModel4,
						model4Name: res.data.model4Name
					})
				});
		},

        chooseModel4(e) {
            const id = e.currentTarget.dataset.id;
            this.setData({
                goods_id: id
            });
        },
		
        doPayModel4: function () {
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
    height: 140rpx;
    background: #04babe;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    color: #fff;
    padding-bottom: 100rpx;
    margin-bottom: -80rpx;
}
.wallet .balance {
    font-size: 36rpx;
    text-align: center;
}
.wallet .balance text {
    font-size: 48rpx;
    margin: 0 10rpx;
    color: red;
    font-weight: bold;
}
.wallet .vip {
    color: #eee;
}
.model4-list {
    padding: 0 0 20rpx 0;
}
.model4 {
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
.model4 .title {
    font-size: 48rpx;
    display: flex;
    align-items: baseline;
    justify-content: center;
    font-weight: bold;
}
.model4 .title .unit {
    font-size: 28rpx;
    margin-left: 20rpx;
    font-weight: normal;
}
.model4 .price {
    font-size: 28rpx;
    margin: 10rpx 0;
    color: #444;
}
.model4 .price text {
    color: red;
    margin: 0 6rpx;
}
.model4 .market_price {
    color: #999;
    text-decoration: line-through;
    font-size: 24rpx;
}
.model4.active {
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
