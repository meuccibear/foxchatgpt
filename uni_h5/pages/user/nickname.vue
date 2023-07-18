<template>
    <view class="page">
        <button class="avatar-wrapper" open-type="chooseAvatar" @chooseavatar="onChooseAvatar">
            <image class="avatar" :src="avatar"></image>
        </button>
        <view class="form-input">
            <view class="label">昵称</view>
            <input type="nickname" class="input" v-model="nickname" placeholder="请输入昵称" />
        </view>
        <view>
            <button class="btn-submit" @tap="saveUserInfo">确 定</button>
        </view>
    </view>
</template>

<script>
const defaultAvatarUrl = 'https://mmbiz.qpic.cn/mmbiz/icTdbqWNOwNRna42FI242Lcia07jQodd2FJGIYQfG0LAJGFxM4FbnQP6yfMxBgJ0F3YRqJCJ1aPAK2dQagdusBZg/0';
const app = getApp();
export default {
    data() {
        return {
            avatar: defaultAvatarUrl,
            nickname: ''
        };
    },
    methods: {
        onChooseAvatar(e) {
            this.setData({
                avatar: e.detail.avatarUrl
            });
        },

        onChooseAvatar(e) {
            this.setData({
                avatar: e.detail.avatarUrl
            });
        },

        saveUserInfo() {
            var avatar = this.avatar;
            var nickname = this.nickname;
            if (!nickname || nickname == '微信用户') {
                app.globalData.util.message('请设置昵称', 'error');
                return;
            }
            if (!avatar || avatar == defaultAvatarUrl) {
                app.globalData.util.message('请设置头像', 'error');
                return;
            }
            app.globalData.util
                .upload({
                    url: '/upload/image',
                    filePath: avatar
                })
                .then((res) => {
                    avatar = res.data.path;
                    app.globalData.util
                        .request({
                            url: '/user/setUserInfo',
                            data: {
                                avatar: avatar,
                                nickname: nickname
                            }
                        })
                        .then((res) => {
                            uni.navigateBack();
                        });
                });
        }
    }
};
</script>
<style>
.page {
    margin: 0;
    background-color: #fff;
    font-family: '微软雅黑';
    box-sizing: border-box;
}
.avatar-wrapper {
    width: 120rpx;
    height: 120rpx;
    border-radius: 20rpx;
    margin: 80rpx auto;
    padding: 0;
}
.avatar-wrapper::after {
    display: none;
}
.avatar {
    width: 100%;
    height: 100%;
}

.form-input {
    width: 100%;
    border-top: 2rpx solid #e2e2e2;
    border-bottom: 2rpx solid #e2e2e2;
    padding: 10rpx 0;
    display: flex;
    justify-content: flex-start;
    align-items: center;
    box-sizing: border-box;
}
.form-input .label {
    width: 200rpx;
    font-weight: bold;
    padding-left: 60rpx;
}
.form-input .input {
    width: 400rpx;
    height: 80rpx;
    line-height: 80rpx;
}

.btn-submit {
    position: fixed;
    width: 70%;
    height: 80rpx;
    left: 15%;
    bottom: 200rpx;
    background: #04babe;
    color: #fff;
    text-align: center;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 40rpx;
    box-shadow: 0 0 20rpx rgba(0, 0, 0, 0.05);
}
.btn-submit image {
    width: 40rpx;
    height: 40rpx;
    margin-right: 12rpx;
}
.btn-submit text {
    letter-spacing: 1px;
    font-size: 36rpx;
}
.btn-submit::after {
    border: none;
}
.btn-submit:active {
    transform: scale(0.95);
}
</style>
