<template>
    <view class="page">
        <view class="bg-user">
            <view class="userinfo" v-if="userinfo">
                <view class="avatar" v-if="!userinfo.avatar" @tap="getUserProfile">
                    <image src="/static/images/avatar.jpg"></image>
                </view>
                <view class="avatar" v-else @tap="getUserProfile">
                    <image :src="userinfo.avatar"></image>
                </view>
                <view class="info">
                    <view class="nickname" v-if="!userinfo.nickname && !userinfo.avatar" @tap="getUserProfile">未设置昵称</view>
                    <view class="nickname" v-else @tap="getUserProfile">{{ userinfo.nickname || '未设置昵称' }}</view>
                    <view class="mid" style="padding-left: 2rpx">MID: {{ userinfo.user_id }}</view>
                    <!-- <button class="phone" open-type="getPhoneNumber" @getphonenumber="getUserPhone">
                        <image src="/static/images/user/ic_phone.png"></image>
                        <text>{{ userinfo.phone || '未绑定手机号' }}</text>
                    </button> -->
                </view>
            </view>
        </view>
        <view class="box-vip">
            <image class="bg" src="/static/images/user/bg-vip.png"></image>
            <view class="body">
                <view style="display: flex; align-items: center">
                    <image class="icon" src="/static/images/user/ic_vip.png"></image>
                    <text>VIP会员</text>
                    <view class="line"></view>
                    <text style="font-size: 24rpx" v-if="userinfo.vip_expire_time">{{ userinfo.vip_expire_time }} 到期</text>
                    <text style="font-size: 24rpx" v-else>享无限对话特权</text>
                </view>
                <view>
                    <button class="btn-vip" @tap="toPayVip" v-if="userinfo.vip_expire_time" style="width: 92rpx">续费</button>
                    <button class="btn-vip" @tap="toPayVip" v-else>立即开通</button>
                </view>
            </view>
        </view>
		<view class="wallet">
			<view class="item" data-url="/pages/pay/chat" @tap="linkto">
				<view>
					<text class="num">{{ userinfo.balance }}</text>
					<text class="unit">条</text>
				</view>
				<view class="label">对话余额</view>
			</view>
			<view class="item" data-url="/pages/pay/draw" @tap="linkto">
				<view>
					<text class="num">{{ userinfo.balance_draw }}</text>
					<text class="unit">张</text>
				</view>
				<view class="label">绘画余额</view>
			</view>
		</view>
        <view class="menus">
            
            <view class="item" data-url="/pages/user/card" @tap="linkto">
                <text class="text-grey">卡密兑换</text>
                <image class="arrow" src="/static/images/ic_arrow_r.png"></image>
            </view>
            <view class="item" data-url="/pages/task/index" @tap="linkto">
                <text class="text-grey">每日任务</text>
                <image class="arrow" src="/static/images/ic_arrow_r.png"></image>
            </view>
        </view>
        <view class="menus">
            <view class="item" data-url="/pages/commission/index" @tap="linkto" v-if="userinfo.is_commission">
                <text class="text-grey">推广中心</text>
                <image class="arrow" src="/static/images/ic_arrow_r.png"></image>
            </view>
            <view class="item" data-url="/pages/commission/apply" @tap="linkto" v-if="userinfo.commission_is_open && !userinfo.is_commission">
                <text class="text-grey">申请推广员</text>
                <image class="arrow" src="/static/images/ic_arrow_r.png"></image>
            </view>
            <view class="item" data-url="/pages/article/list?type=help" @tap="linkto">
                <text class="text-grey">使用教程</text>
                <image class="arrow" src="/static/images/ic_arrow_r.png"></image>
            </view>
            <view class="item" data-url="/pages/user/feedback" @tap="linkto">
                <text class="text-grey">意见反馈</text>
                <image class="arrow" src="/static/images/ic_arrow_r.png"></image>
            </view>
            <view class="item" data-url="/pages/article/article?type=about" @tap="linkto">
                <text class="text-grey">关于我们</text>
                <image class="arrow" src="/static/images/ic_arrow_r.png"></image>
            </view>
            <view class="item" data-url="/pages/article/article?type=kefu" @tap="linkto">
                <text class="text-grey">联系客服</text>
                <image class="arrow" src="/static/images/ic_arrow_r.png"></image>
            </view>
        </view>
    </view>
</template>

<script>
const app = getApp();
export default {
    data() {
        return {
            userinfo: {
                avatar: '',
                nickname: '',
                id: '',
                phone: '',
                vip_expire_time: '',
                is_commission: '',
                commission_is_open: ''
            }
        };
    },
    onShow() {
        this.getUserInfo();
    },
    methods: {
        getUserInfo() {
            app.globalData.util
                .request({
                    url: '/user/info'
                })
                .then((res) => {
                    this.setData({
                        userinfo: res.data
                    });
                });
        },

        getUserProfile() {
			const url = app.globalData.siteroot + '/h5/getProfile'
			window.location.href = url
            // uni.getUserProfile({
            //     desc: '使用微信登录'
            // })
            //     .then((e) => {
            //         if (!(e.errMsg.indexOf('fail') > 0)) {
            //             app.globalData.util
            //                 .request({
            //                     url: '/user/setUserAvatar',
            //                     data: {
            //                         encryptedData: e.encryptedData,
            //                         iv: e.iv
            //                     }
            //                 })
            //                 .then((res) => {
            //                     this.getUserInfo();
            //                 });
            //         } else {
            //             app.globalData.util.message('授权失败', 'error');
            //         }
            //     })
            //     .catch(() => {});
        },

        getUserPhone(e) {
            if (e.detail.errMsg != 'getPhoneNumber:ok') {
                var message = e.detail.errMsg;
                if (message.indexOf('user deny') !== -1) {
                    message = '已取消授权';
                }
                app.globalData.util.message(message, 'error');
                return;
            }
            app.globalData.util
                .request({
                    url: '/user/setUserPhone',
                    data: {
                        encryptedData: e.detail.encryptedData,
                        iv: e.detail.iv
                    }
                })
                .then((res) => {
                    this.getUserInfo();
                });
        },

        linkto(e) {
            const url = e.currentTarget.dataset.url;
            uni.navigateTo({
                url: url
            });
        },

        toPayVip() {
            uni.navigateTo({
                url: '/pages/pay/vip'
            });
        },

        toTask() {
            uni.switchTab({
                url: '/pages/task/index'
            });
        },

        toInputNickname() {
            uni.navigateTo({
                url: '/pages/user/nickname'
            });
        }
    }
};
</script>
<style>
page {
    box-sizing: border-box;
    background: #f7f7f7;
}

.page {
    position: relative;
}

.bg-user {
    position: relative;
    width: 100%;
    left: 0;
    top: 0px;
    background: #04babe;
    height: 300rpx;
    box-sizing: content-box;
    z-index: 1;
}

.userinfo {
    display: flex;
    align-items: flex-start;
    padding: 50rpx 0 0 60rpx;
}

.userinfo .avatar {
    width: 108rpx;
    height: 108rpx;
    border-radius: 10rpx;
    overflow: hidden;
    background-color: #f8f8f8;
}

.userinfo .avatar image {
    width: 100%;
    height: 100%;
}

.userinfo .info {
    display: flex;
    flex-direction: column;
    margin-left: 30rpx;
}

.userinfo .info .nickname {
    font-size: 30rpx;
    font-weight: bold;
    color: #fff;
}

.userinfo .info .mid {
    font-size: 24rpx;
    color: #fff;
    line-height: 52rpx;
}

.userinfo .info .phone {
    color: #fff;
    background-color: rgba(0, 0, 0, 0.2);
    padding: 4rpx 8rpx 4rpx 4rpx;
    height: 36rpx;
    border-radius: 6rpx;
    display: flex;
    align-items: center;
}

.userinfo .info .phone image {
    width: 28rpx;
    height: 28rpx;
}

.userinfo .info .phone text {
    font-size: 22rpx;
}

.nologin {
    display: flex;
    align-items: center;
    padding: 20rpx 0 60rpx 30rpx;
}

.nologin .avatar {
    width: 92rpx;
    height: 92rpx;
}

.nologin .avatar image {
    width: 100%;
    height: 100%;
    border-radius: 50%;
}

.nologin .info {
    display: flex;
    flex-direction: column;
    margin-left: 20rpx;
    align-items: center;
}

.nologin .info .nickname {
    font-size: 30rpx;
    font-weight: bold;
    color: #fff;
}

.box-vip {
    width: 690rpx;
    height: 94rpx;
    margin: -86rpx auto 0 auto;
    border-style: none;
    border-width: 0;
    border: none;
    position: relative;
}

.box-vip .bg {
    position: absolute;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    z-index: 1;
}

.box-vip .body {
    position: absolute;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    z-index: 2;
    font-size: 24rpx;
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

.box-vip .body .btn-vip {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 144rpx;
    height: 40rpx;
    background: linear-gradient(-90deg, #f1ce80, #ffe8b5);
    border-radius: 20rpx;
    font-size: 24rpx;
    padding: 0;
    margin-right: 20rpx;
}

.wallet {
	display: flex;
	justify-content: space-between;
	align-items: center;
	overflow: hidden;
	margin: 30rpx;
}

.wallet .item {
    text-align: center;
    line-height: 48rpx;
	color: #666;
	font-size: 28rpx;
    padding: 18rpx 0;
    border-radius: 10rpx;
	background: #fff;
	border-radius: 20rpx;
	width: 334rpx;
	box-sizing: border-box;
}

.wallet .item:active {
    background: #f3f6f9;
}

.wallet .item .num {
	font-size: 40rpx;
	color: #04babe;
	font-weight: bold;
	margin-right: 10rpx;
	letter-spacing: 1px;
}
.wallet .item .unit {
	font-size: 28rpx;
	color: #999;
}
.wallet .item .label {
	color: #666;
	font-size: 28rpx;
	letter-spacing: 1px;
	margin-top: 4rpx;
}

.menus {
    background: #fff;
    border-radius: 20rpx;
    padding: 20rpx;
    margin: 30rpx 30rpx 0 30rpx;
}

.menus .item {
    width: 100%;
    padding: 24rpx 20rpx 24rpx 30rpx;
    border-bottom: 1px solid #f3f6f9;
    display: flex;
    align-items: center;
    justify-content: space-between;
    font-size: 32rpx;
    color: #444;
    box-sizing: border-box;
}

.menus .item .arrow {
    width: 24rpx;
    height: 24rpx;
    opacity: 0.8;
}

.menus .item.button {
    background: #fff;
    border: none;
    outline: none;
    margin: 0;
    font-size: 32rpx;
    color: #444;
    line-height: 1em;
}

.menus .item.button::after {
    display: none;
}

.menus .item:active {
    background: #fafafa;
}

.menus .item:last-child {
    border-bottom: 0;
}

.text-grey {
    color: #666;
}
</style>
