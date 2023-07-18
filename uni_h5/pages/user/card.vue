<template>
    <view>
        <view class="form">
            <view class="form-item" style="border-bottom: none;">
                <input type="text" class="input" placeholder="请输入卡密" @input="doInput"></input>
            </view>
            <view v-if="card" style="padding: 0 20rpx;">
                <view class="form-item">
                    <view class="label">面额</view>
                    <view class="value">
                        <text v-if="card.type == 'times'">对话{{card.val}}条</text>
                        <text v-else-if="card.type == 'draw'">绘画{{card.val}}张</text>
                        <text v-else-if="card.type == 'gpt4'">{{model4Name}}余额{{card.val}}万字</text>
                        <text v-else-if="card.type == 'vip'">vip会员{{card.val}}个月</text>
                        <text v-else>-</text>
                    </view>
                </view>
                <view class="form-item">
                    <view class="label">状态</view>
                    <view class="value">
                        <text v-if="card.bind_time" class="text-red">{{card.bind_time}} 已使用</text>
                        <text v-else class="text-green">未使用</text>
                    </view>
                </view>
            </view>
            <view class="form-item" style="border-bottom: none;">
                <view class="btn-submit" @tap="getCardInfo" v-if="!card">查询</view>
                <view class="btn-submit" @tap="bindCard" v-else-if="!card.bind_time" style="width: 100%;">立即兑换</view>
            </view>
        </view>
    </view>
</template>

<script>
const app = getApp();
export default {
    data() {
        return {
            code: '',
            card: null,
			model4Name: ''
        };
    },
    onLoad() {
       this.checkModel4()
    },
    methods: {
		getCardInfo() {
			app.globalData.util
			    .request({
				url: '/user/getCardInfo',
				data: {
					code: this.code
				}
			}).then(res => {
				this.setData({
					card: res.data
				})
			})
		},
		doInput(e) {
			this.setData({
				card: null,
				code: e.detail.value
			})
		},
		bindCard() {
			app.globalData.util
			    .request({
				url: '/user/bindCard',
				data: {
					code: this.code
				}
			}).then(res => {
				app.globalData.util.message(res.message, 'error', () => {
					wx.navigateBack()
				})
			})
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
						model4Name: res.data.model4Name
					})
				});
		}
	}
};
</script>
<style>
page {
    background: #f7f7f7;
}
.form {
    padding: 60rpx 50rpx;
    background-color: #fff;
    border-radius: 20rpx;
    margin: 50rpx 30rpx 0 30rpx;
}
.form-item {
    width: 100%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #f7f7f7;
    padding: 20rpx 0;
}
.form-item .label {
    font-size: 28rpx;
    position: relative;
    line-height: 48rpx;
    color: #758b97;
}
.form-item .value {
    color: #333;
    font-size: 28rpx;
    font-weight: bold;
}
.form-item .input {
    width: 100%;
    height: 100rpx;
    line-height: 100rpx;
    padding: 0 20rpx;
    background: #f7f7f7;
    box-sizing: border-box;
    border-radius: 10rpx;
    font-size: 38rpx;
    color: #333;
    font-weight: bold;
    letter-spacing: 1px;
    text-align: center;
}


.btn-submit {
    width: 390rpx;
    height: 72rpx;
    padding: 10rpx;
    background-color: #04BABE;
    border-radius: 100rpx;
    color: #fff;
    font-size: 30rpx;
    border: none;
    outline: none;
    margin: 30rpx auto 0 auto;
    box-sizing: border-box;
    display: flex;
    justify-content: center;
    align-items: center;
    letter-spacing: 2rpx;
}
.btn-submit:active {
    opacity: 0.8;
    transform: scale(0.9);
}
.text-red {
    color: #d81e06;
}
.text-green {
    color: #06b13c;
}
</style>
