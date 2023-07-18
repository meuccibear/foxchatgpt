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
        <view class="box" v-if="tasks">
            <view class="box-title">
                <text>每日任务</text>
                <text class="desc">免费获得条数</text>
            </view>
            <view class="task-list">
                <!-- <view class="task-item" v-if="tasks.share">
                    <view class="task-icon"><image src="/static/images/ic_task_share.png"></image></view>
                    <view class="task-info">
                        <view class="task-name">分享给朋友</view>
                        <view class="task-desc">
                            分享1次奖励
                            <text>{{ tasks.share.num }}</text>
                            条，每日限
                            <text>{{ tasks.share.max }}</text>
                            次
                        </view>
                        <view class="task-status">进度 {{ tasks.share.count }} / {{ tasks.share.max }}</view>
                    </view>
                    <view class="task-op">
                        <button type="button" class="task-btn" @tap="showShareTips">去转发</button>
                    </view>
                </view> -->

                <view class="task-item" v-if="tasks.invite">
                    <view class="task-icon"><image src="/static/images/ic_task_invite.png"></image></view>
                    <view class="task-info">
                        <view class="task-name">邀请新用户</view>
                        <view class="task-desc">
                            每邀请1人奖励
                            <text>{{ tasks.invite.num }}</text>
                            条，每日限
                            <text>{{ tasks.invite.max }}</text>
                            人
                        </view>
                        <view class="task-status">进度 {{ tasks.invite.count }} / {{ tasks.invite.max }}</view>
                    </view>
                    <view class="task-op">
                        <button type="button" class="task-btn" @tap="showShareTips">去邀请</button>
                    </view>
                </view>
            </view>
        </view>
		
		<view class="share_tips" v-if="shareTipsShow" @click="closeShareTips">
			<image src="/static/images/share_tips.png"></image>
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
            tasks: null,
            paying: false,
            num: '',
            max: '',
            count: '',
			shareTipsShow: false
        };
    },
    onLoad: function (options) {
        this.setData({
            system: app.globalData.system
        });
        app.globalData.util.checkLogin().then(() => {
            this.getBalance();
            this.getTasks();
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
        getTasks() {
            app.globalData.util
                .request({
                    url: '/h5/getTasks',
                    loading: false
                })
                .then((res) => {
                    this.setData({
                        tasks: res.data
                    });
                    // if (res.data && res.data.ad && !rewardVideoAd) {
                    //     this.initRewardAd();
                    // }
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
                        balance: res.data.balance,
                        vip_expire_time: res.data.vip_expire_time
                    });
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
		},

        initRewardAd() {
            rewardVideoAd = null;
            const ad_unit_id = this.tasks.ad.ad_unit_id;
            if (uni.createRewardedVideoAd && !rewardVideoAd) {
                rewardVideoAd = uni.createRewardedVideoAd({
                    adUnitId: ad_unit_id
                });
                rewardVideoAd.onLoad(() => {
                    console.log('reward ad onload');
                });
                rewardVideoAd.onError((err) => {
                    console.log('reward ad error');
                    this.initRewardAd();
                });
                rewardVideoAd.onClose((res) => {
                    console.log('reward ad onclose', res);
                    if (res && res.isEnded) {
                        app.globalData.util
                            .request({
                                url: '/wxapp/doAd',
                                data: {
                                    ad_unit_id: ad_unit_id
                                },
                                loading: false
                            })
                            .then((res) => {
                                app.globalData.util.message(res.message);
                                this.getTasks();
                                this.getBalance();
                            });
                    }
                });
            }
        },

        showTaskAd() {
            uni.showLoading({
                title: '加载中'
            });
            if (!rewardVideoAd) {
                this.initRewardAd();
            }
            if (!rewardVideoAd) {
                uni.hideLoading();
                app.globalData.util.message('广告加载失败，请重试', 'error');
                return;
            }
            rewardVideoAd
                .load()
                .then(() => {
                    rewardVideoAd.show();
                    setTimeout(() => {
                        uni.hideLoading();
                    }, 1500);
                })
                .catch(() => {
                    uni.hideLoading();
                    app.globalData.util.message('广告加载失败，请重试', 'error');
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

.box {
    width: 690rpx;
    background: #fff;
    margin: 0 30rpx 30rpx 30rpx;
    border-radius: 20rpx;
    overflow: hidden;
    padding: 20rpx 30rpx;
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
    font-size: 28rpx;
    margin-left: 20rpx;
}

.task-list {
    padding-top: 20rpx;
}
.task-list .task-item {
    width: 100%;
    margin-top: 30rpx;
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    border-bottom: 2rpx solid #f3f6f9;
    padding-bottom: 30rpx;
}
.task-list .task-item:last-child {
    border-bottom: 0;
}
.task-item .task-icon {
    width: 100rpx;
    height: 100rpx;
    border-radius: 10rpx;
    overflow: hidden;
    background-color: #f3f6f9;
}
.task-item .task-icon image {
    width: 100%;
    height: 100%;
}
.task-item .task-info {
    margin: 0 20rpx;
    width: 380rpx;
}
.task-item .task-name {
    font-size: 32rpx;
    color: #333;
    line-height: 48rpx;
    font-weight: bold;
    letter-spacing: 2rpx;
}
.task-item .task-desc {
    font-size: 28rpx;
    color: #999;
    line-height: 44rpx;
    margin: 6rpx 0 20rpx 0;
}
.task-item .task-desc text {
    color: red;
    margin: 0 6rpx;
}
.task-item .task-status {
    font-size: 24rpx;
    color: #04babe;
}
.task-item .task-op {
    width: 110rpx;
}
.task-item .task-btn {
    border: none;
    font-size: 22rpx;
    padding: 0;
    background: #04babe;
    color: #fff;
    border-radius: 40rpx;
    height: 48rpx;
    line-height: 48rpx;
}
.task-item .task-btn::after {
    display: none;
}
.task-item .task-btn:active {
    transform: scale(0.9);
}
.task-item .task-btn.disabled {
    background: #999;
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
</style>
