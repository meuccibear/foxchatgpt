<template>
    <view class="page">
        <view class="image">
            <image src="/static/images/ic_pc.png"></image>
        </view>
        <view class="desc">您将在电脑上登录网页版</view>
        <button class="btn-login" @tap="doLogin">确认登录</button>
    </view>
</template>

<script>
const app = getApp();
export default {
    data() {
        return {
            code: ''
        };
    },
    onLoad(options) {
        if (options.scene) {
            let scene = decodeURIComponent(options.scene);
            let param = app.globalData.util.queryToArr(scene);
            if (param.code) {
                this.setData({
                    code: param.code
                });
            }
        }
        app.globalData.util.login();
    },
    methods: {
        doLogin() {
            if (!this.code) {
                app.globalData.util.message('参数错误', 'error');
                return;
            }
            app.globalData.util
                .request({
                    url: '/wxapp/pclogin',
                    data: {
                        code: this.code
                    }
                })
                .then((res) => {
                    app.globalData.util.message(res.message);
                    setTimeout(() => {
                        uni.switchTab({
                            url: '/pages/user/index'
                        });
                    }, 800);
                });
        }
    }
};
</script>
<style>
page {
    background-color: #fff;
}
.image {
    padding: 80rpx 0 40rpx 0;
    text-align: center;
}
.image image {
    width: 360rpx;
    height: 260rpx;
    opacity: 0.75;
}
.desc {
    text-align: center;
    color: #666;
    padding: 40rpx 0;
    font-size: 28rpx;
    letter-spacing: 1px;
}

.btn-login {
    width: 530rpx;
    height: 80rpx;
    padding: 10rpx;
    background-color: #04babe;
    color: #fff;
    font-size: 30rpx;
    border: none;
    outline: none;
    margin: 40rpx 0 30rpx 110rpx;
    box-sizing: border-box;
    display: flex;
    justify-content: center;
    align-items: center;
    letter-spacing: 2rpx;
}
.btn-login::after {
    display: none;
}
.btn-login:active {
    transform: scale(0.9);
}
</style>
