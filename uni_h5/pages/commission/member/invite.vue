<template>
    <view class="qrcode" v-if="qrcode">
        <image :src="qrcode" @longpress="saveImage"></image>
        <view class="title">使用微信扫一扫打开</view>
    </view>
</template>

<script>
const app = getApp();
export default {
    data() {
        return {
            qrcode: ''
        };
    },
    onLoad() {
        this.getInviteQrcode();
    },
    methods: {
        getInviteQrcode: function () {
            app.globalData.util
                .request({
                    url: '/commission/memberInviteQrcode'
                })
                .then((res) => {
                    this.setData({
                        qrcode: res.data.qrcode
                    });
                });
        },

        saveImage() {
            if (!this.qrcode) {
                app.globalData.util.message('获取二维码失败', 'error');
                return;
            }
            uni.downloadFile({
                url: this.qrcode,
                success: function (res) {
                    uni.saveImageToPhotosAlbum({
                        filePath: res.tempFilePath,
                        success: function () {
                            app.globalData.util.message('已保存到相册');
                        },
                        fail: function (res) {
                            console.log('error', res);
                            app.globalData.util.message('保存失败，请检查是否有保存到相册权限', 'error');
                        }
                    });
                },
                fail: function () {
                    app.globalData.util.message('图片下载失败', 'error');
                }
            });
        }
    }
};
</script>
<style>
page {
    background: #f7f7f7;
}
.page {
    width: 100%;
}
.qrcode {
    padding-top: 100rpx;
}
.qrcode image {
    width: 440rpx;
    height: 440rpx;
    margin: 0 155rpx;
    box-shadow: 0 0 30rpx rgba(0, 0, 0, 0.05);
    border-radius: 0;
    padding: 30rpx;
    background: #fff;
    box-sizing: border-box;
}
.qrcode .title {
    line-height: 200rpx;
    text-align: center;
    color: #555;
    letter-spacing: 4rpx;
    font-size: 34rpx;
}
</style>
