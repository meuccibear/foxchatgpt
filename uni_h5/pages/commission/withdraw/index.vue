<template>
    <view>
        <view class="container">
            <view class="box-input">
                <view class="title">提现金额</view>
                <view class="money">
                    <text class="unit">￥</text>
                    {{ money }}
                </view>
            </view>
            <view class="box-type">
                <view class="title">
                    <view class="icon"></view>
                    <text>提现方式</text>
                </view>
                <view class="type-list" style="height: auto">
                    <view class="type-item" @tap="bankChange" :data-type="word_lingqian">
                        <view class="row-label">
                            <image class="checkbox-img" src="/static/images/commission/wxpay.png"></image>
                            提现到{{ word_weixin }}
                        </view>
                        <image v-if="bank_name == word_lingqian" class="checkbox-img" src="/static/images/commission/ic_check_red.png"></image>
                        <image v-else class="checkbox-img" src="/static/images/commission/ic_check_gray.png"></image>
                    </view>
                    <view class="type-item" @tap="bankChange" :data-type="word_zfb">
                        <view class="row-label">
                            <image class="checkbox-img" src="/static/images/commission/alipay.png"></image>
                            提现到{{ word_zfb }}
                        </view>
                        <image v-if="bank_name == word_zfb" class="checkbox-img" src="/static/images/commission/ic_check_red.png"></image>
                        <image v-else class="checkbox-img" src="/static/images/commission/ic_check_gray.png"></image>
                    </view>
                </view>
            </view>
            <view class="box-form">
                <view class="form-group">
                    <view class="title">户名</view>
                    <input placeholder="请输入姓名" v-model="account_name" />
                </view>
                <view class="form-group" v-if="bank_name == word_zfb">
                    <view class="title">账号</view>
                    <input :placeholder="'请输入' + word_zfb + '账号'" v-model="account_number" />
                </view>
                <view class="form-group" v-if="bank_name == word_lingqian">
                    <view class="title">上传{{ word_skm }}</view>
                    <view class="upload">
                        <view class="image" @tap="viewImage" :data-url="imgList[index]" v-for="(item, index) in imgList" :key="index">
                            <image class="img" :src="imgList[index]" mode="aspectFill"></image>

                            <view class="del" @tap.stop.prevent="delImg" :data-index="index">
                                <image class="icon" src="/static/images/commission/ic_upload_del.png"></image>
                            </view>
                        </view>
                        <view class="btn-upload" v-if="!imgList || imgList.length == 0">
                            <image src="/static/images/commission/ic_upload_add.png" class="icon" @tap="chooseImage"></image>
                        </view>
                        <view style="clear: both"></view>
                    </view>
                </view>
            </view>

            <view v-if="money > 0" class="btn-submit" @tap="withdraw">提交申请</view>
            <view v-else class="btn-submit disabled">提交申请</view>
        </view>
    </view>
</template>

<script>
const app = getApp();
export default {
    data() {
        return {
            money: 0,
            bank_name: '',
            account_name: '',
            account_number: '',
            imgList: [],
            word_zfb: '',
            word_weixin: '',
            word_lingqian: '',
            word_skm: '',
            name: ''
        };
    },
    onLoad(options) {
        this.setData({
            money: options.money,
            bank_name: decodeURIComponent('%E5%BE%AE%E4%BF%A1%E9%9B%B6%E9%92%B1'),
            word_zfb: decodeURIComponent('%E6%94%AF%E4%BB%98%E5%AE%9D'),
            word_lingqian: decodeURIComponent('%E5%BE%AE%E4%BF%A1%E9%9B%B6%E9%92%B1'),
            word_weixin: decodeURIComponent('%E5%BE%AE%E4%BF%A1'),
            word_skm: decodeURIComponent('%E6%94%B6%E6%AC%BE%E7%A0%81')
        });
        this.geLastWithdraw();
    },
    methods: {
        geLastWithdraw: function () {
            app.globalData.util
                .request({
                    url: '/commission/lastWithdraw'
                })
                .then((res) => {
                    if (res.data.bank_name) {
                        this.setData({
                            bank_name: res.data.bank_name
                        });
                    }
                    if (res.data.account_name) {
                        this.setData({
                            account_name: res.data.account_name
                        });
                    }
                    if (res.data.account_number) {
                        this.setData({
                            account_number: res.data.account_number
                        });
                    }
                });
        },

        bankChange: function (e) {
            let type = e.currentTarget.dataset.type;
            if (type != this.word_lingqian && type != this.word_zfb) {
                type = '';
            }
            this.setData({
                bank_name: type
            });
        },

        inputChange: function (e) {
            const name = e.currentTarget.dataset.name;
            this.setData({
                [name]: e.detail.value
            });
        },

        withdraw: function () {
            let money = this.money;
            let bank_name = this.bank_name;
            let account_name = this.account_name;
            let account_number = this.account_number;
            let imgList = this.imgList;
            let data = {};
            if (bank_name == this.word_lingqian) {
                if (!account_name) {
                    app.globalData.util.message('请输入户名', 'error');
                    return;
                }
                if (!imgList || imgList.length == 0) {
                    app.globalData.util.message('请上传' + this.word_skm, 'error');
                    return;
                }
                data = {
                    money: money,
                    bank_name: bank_name,
                    account_name: account_name,
                    qrcode: imgList[0]
                };
            } else if (bank_name == this.word_zfb) {
                if (!account_name) {
                    app.globalData.util.message('请输入户名', 'error');
                    return;
                }
                if (!account_number) {
                    app.globalData.util.message('请输入' + this.word_zfb + '账号', 'error');
                    return;
                }
                data = {
                    money: money,
                    bank_name: bank_name,
                    account_name: account_name,
                    account_number: account_number
                };
            }
            app.globalData.util
                .request({
                    url: '/commission/withdraw',
                    data: data
                })
                .then((res) => {
                    uni.showModal({
                        title: '系统提示',
                        content: res.message,
                        showCancel: false,
                        success() {
                            uni.navigateBack({
                                fail: function() {
                                    uni.redirectTo({
                                        url: '/pages/commission/index'
                                    });
                                }
                            });
                        }
                    });
                });
        },

        chooseImage() {
            const _this = this;
            uni.chooseImage({
                count: 1,
                sourceType: ['album', 'camera'],
                sizeType: ['original', 'compressed'],
                success: (res) => {
                    const tempFiles = res.tempFiles;
                    console.log('res', res);
                    app.globalData.util
                        .upload({
                            url: '/upload/image',
                            filePath: tempFiles[0]['path'],
                            name: 'image'
                        })
                        .then((res) => {
                            var imgList = _this.imgList;
                            imgList.push(res.data.path);
                            _this.setData({
                                imgList: imgList
                            });
                        });
                }
            });
        },

        viewImage(e) {
            uni.previewImage({
                urls: this.imgList,
                current: e.currentTarget.dataset.url
            });
        },

        delImg(e) {
            uni.showModal({
                title: '请确认',
                content: '确定要删除这张图片吗？',
                cancelText: '取消',
                confirmText: '确定删除',
                success: (res) => {
                    if (res.confirm) {
                        this.imgList.splice(e.currentTarget.dataset.index, 1);
                        this.setData({
                            imgList: this.imgList
                        });
                    }
                }
            });
        }
    }
};
</script>
<style>
page {
    background-color: #f7f7f7;
}
.container {
    padding: 30rpx;
    color: #666;
}
.box-input {
    background-color: #fff;
    margin-bottom: 24rpx;
    padding: 30rpx;
    border-radius: 10rpx;
}
.box-input .title {
    font-size: 32rpx;
    margin-bottom: 10rpx;
}
.box-input .money .unit {
    font-size: 32rpx;
    margin-right: 10rpx;
}
.box-input .money {
    font-size: 44rpx;
    font-weight: bold;
    color: #04babe;
}
.box-type {
    background-color: #fff;
    border-radius: 10rpx;
    padding: 0 30rpx;
    margin-bottom: 24rpx;
}
.box-type .title {
    height: 80rpx;
    line-height: 80rpx;
    border-bottom: 1px solid #f2f2f2;
    display: flex;
    align-items: center;
}
.box-type .title .icon {
    width: 6rpx;
    height: 32rpx;
    background-color: #04babe;
    border-radius: 6rpx;
    margin-right: 16rpx;
}

.box-type .type-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    height: 80rpx;
    line-height: 60rpx;
    padding: 10rpx 30rpx 10rpx 0;
    border-bottom: 1px solid #f6f6f6;
}
.box-type .type-item .row-label {
    height: 40rpx;
    font-size: 30rpx;
    font-weight: 500;
    color: #666;
    display: flex;
    align-items: center;
}
.box-type .type-item .row-label image {
    width: 64rpx;
    height: 64rpx;
    margin-right: 10rpx;
}
.box-type .type-item .checkbox-img {
    height: 40rpx;
    width: 40rpx;
}

.box-form {
    background-color: #fff;
    border-radius: 10rpx;
    padding: 20rpx 30rpx;
}
.box-form .form-group {
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-bottom: 1px solid #f6f6f6;
    padding: 16rpx 0;
    font-size: 30rpx;
}
.box-form .form-group .title {
	width: 240rpx;
}
.box-form .form-group:last-child {
    border-bottom: none;
}
.box-form .form-group input {
    text-align: right;
}
.btn-submit {
    width: 600rpx;
    height: 80rpx;
    line-height: 80rpx;
    border-radius: 40rpx;
    background: #04babe;
    text-align: center;
    font-size: 32rpx;
    font-weight: 500;
    color: #ffffff;
    margin: 100rpx auto 30rpx auto;
}
.btn-submit.disabled {
    background: #ddd;
}

.upload .image {
    width: 116rpx;
    height: 116rpx;
    float: left;
    margin-right: 16rpx;
    position: relative;
    margin-bottom: 16rpx;
}
.upload .image .img {
    width: 100%;
    height: 100%;
    background-color: #dedede;
}
.upload .image .del {
    position: absolute;
    right: 0;
    top: 0;
    border-bottom-left-radius: 6rpx;
    padding: 2rpx 8rpx;
    width: 32rpx;
    height: 32rpx;
    background-color: rgba(0, 0, 0, 0.5);
    overflow: hidden;
}
.upload .image .del .icon {
    width: 100%;
    height: 100%;
}

.upload .btn-upload {
    width: 116rpx;
    height: 116rpx;
    border-radius: 6rpx;
    margin-bottom: 16rpx;
    position: relative;
    overflow: hidden;
    border: 1px dashed #ccc;
    border-radius: 6rpx;
    background: #fafbfc;
    display: flex;
    justify-content: center;
    align-items: center;
    float: left;
}
.upload .btn-upload .icon {
    width: 100%;
    height: 100%;
}

.no-order {
    width: 100%;
    position: absolute;
    bottom: 0;
    top: 88rpx;
    left: 0;
    right: 0;
    text-align: center;
    padding-top: 203rpx;
    display: block;
}

.no-order-img {
    width: 100rpx;
    height: 100rpx;
    margin-bottom: 30rpx;
}

.no-order .text {
    font-size: 30rpx;
    color: #999;
    text-align: center;
    margin-bottom: 30rpx;
}
</style>
