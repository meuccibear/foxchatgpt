<template>
    <view class="page">
        <swiper class="poster-list" @change="swiperChange" previous-margin="125rpx" next-margin="125rpx">
            <swiper-item class="item" v-for="(item, index) in posterList" :key="index">
                <view class="poster" :style="index === current ? 'transform: scale(1)' : 'transform: scale(0.8)'">
                    <image :src="item.img" style="width: 100%; height: 100%"></image>
                    <image
                        :src="qrcode"
                        :style="'left: ' + item.hole.x + 'rpx; top: ' + item.hole.y + 'rpx; width: ' + item.hole.w + 'rpx; height:' + item.hole.h + 'rpx;'"
                    ></image>
                </view>
            </swiper-item>
        </swiper>

        <canvas canvasId="poster" style="display: block; height: 750px; width: 500px; position: absolute; left: -500px; top: -750px"></canvas>

        <view class="btn-save" v-if="posterList.length > 0" @tap="saveImage">保存到相册</view>
    </view>
</template>

<script>
const app = getApp();
export default {
    data() {
        return {
            qrcode: '',
            posterList: [],
            current: 0
        };
    },
    onLoad(options) {
        this.getPoster();
    },
    methods: {
        getPoster: function () {
            app.globalData.util
                .request({
                    url: '/commission/poster'
                })
                .then((res) => {
                    this.setData({
                        qrcode: res.data.qrcode,
                        posterList: res.data.posterList
                    });
                });
        },

        swiperChange: function (e) {
            this.setData({
                current: e.detail.current
            });
        },

        saveImage: function () {
            var context = uni.createCanvasContext('poster');
            var poster = this.posterList[this.current];
            var qrcode = this.qrcode;
            var posterOk = false;
            var qrcodeOk = false;
            uni.showLoading({
                title: '生成中'
            });
            uni.downloadFile({
                url: poster.img,
                success: function (res) {
                    context.drawImage(res.tempFilePath, 0, 0, 500, 750);
                    posterOk = true;
                    uni.downloadFile({
                        url: qrcode,
                        success: function (res) {
                            context.drawImage(res.tempFilePath, poster.hole.x, poster.hole.y, poster.hole.w, poster.hole.h);
                            qrcodeOk = true;
                        }
                    });
                }
            });
            var si = setInterval(() => {
                if (posterOk && qrcodeOk) {
                    clearInterval(si);
                    context.draw();
                    uni.hideLoading();
                    setTimeout(() => {
                        uni.canvasToTempFilePath({
                            canvasId: 'poster',
                            destWidth: 500,
                            destHeight: 750,
                            quality: 1,
                            fileType: 'jpg',
                            success: (res) => {
                                uni.saveImageToPhotosAlbum({
                                    filePath: res.tempFilePath,
                                    success: function () {
                                        util.showSuccessToast('已保存到相册');
                                    },
                                    fail: function (res) {
                                        console.log('error', res);
                                        util.showErrorToast('保存失败，请检查是否有保存到相册权限');
                                    }
                                });
                            }
                        });
                    }, 300);
                }
            }, 500);
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
    height: 100%;
    overflow: hidden;
}
.poster-list {
    width: 100%;
    height: 750rpx;
    margin-top: 100rpx;
}
.poster-list .item {
    width: 500rpx;
    height: 750rpx;
}
.poster {
    width: 100%;
    height: 100%;
    position: relative;
    transition: transform 0.4s linear 0s;
}
.poster image {
    position: absolute;
    width: 100%;
    height: 100%;
}
.btn-save {
    width: 500rpx;
    margin: 160rpx auto 40rpx auto;
    font-size: 32rpx;
    font-weight: 500;
    color: #ffffff;
    text-align: center;
    background-image: linear-gradient(to right, #ff5e41, #fc4353);
    height: 80rpx;
    line-height: 80rpx;
    border-radius: 80rpx;
    box-shadow: 0 0 20rpx rgba(252, 67, 83, 0.3);
}
</style>
