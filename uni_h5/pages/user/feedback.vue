<template>
    <view class="page">
        <view class="form">
            <view class="form-item">
                <view class="label" style="margin-top: 20rpx">反馈类型</view>
                <view class="value" style="height: 60rpx">
                    <radio-group @change="typeChange">
                        <label>
                            <radio class="blue sm" value="故障" color="#04babe" :checked="type === '故障'" />
                            <text>故障</text>
                        </label>
                        <label>
                            <radio class="blue sm" value="建议" color="#04babe" :checked="type === '建议'" />
                            <text>建议</text>
                        </label>
                        <label>
                            <radio class="blue sm" value="投诉" color="#04babe" :checked="type === '投诉'" />
                            <text>投诉</text>
                        </label>
                    </radio-group>
                </view>
            </view>
            <view class="form-item">
                <view class="label">反馈内容</view>
                <view class="value">
                    <textarea v-model="content" placeholder="请填写您的反馈内容"></textarea>
                </view>
            </view>
            <view class="form-item">
                <view class="label">联系方式</view>
                <view class="value">
                    <input class="input" type="text" v-model="phone" maxlength="20" placeholder="手机号 / 微信号" />
                </view>
            </view>
            <view class="form-item">
                <button class="btn-submit" @tap="doSubmit">立即提交</button>
            </view>
        </view>
    </view>
</template>

<script>
const app = getApp();
export default {
    data() {
        return {
            type: '故障',
            content: '',
            phone: ''
        };
    },
    onLoad() {},
    methods: {
        typeChange(e) {
            this.setData({
                type: e.detail.value
            });
        },

        doSubmit() {
            const type = this.type;
            const content = this.content;
            const phone = this.phone;
            if (content === '') {
                app.globalData.util.message('请输入反馈内容', 'error');
                return;
            }
            app.globalData.util
                .request({
                    url: '/user/feedback',
                    data: {
                        type: type,
                        content: content,
                        phone: phone
                    }
                })
                .then((res) => {
                    app.globalData.util.message(res.message, 'error', function () {
                        uni.navigateBack();
                    });
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
    padding: 40rpx 30rpx;
}
.form {
    padding: 30rpx 60rpx;
    background-color: #fff;
    border-radius: 20rpx;
}
.form-item {
    width: 100%;
    margin-bottom: 30rpx;
}
.form-item .label {
    font-size: 32rpx;
    position: relative;
    line-height: 48rpx;
    margin: 30rpx 0;
    color: #758b97;
    margin-top: 50rpx;
}
.form-item textarea {
    width: 100%;
    height: 6em;
    padding: 20rpx;
    margin-top: 16rpx;
    border-radius: 10rpx;
    font-size: 30rpx;
    background: #f6f6f6;
    color: #333;
    box-sizing: border-box;
}
.form-item .input {
    width: 100%;
    height: 80rpx;
    line-height: 80rpx;
    padding: 0 20rpx;
    background: #f6f6f6;
    box-sizing: border-box;
    border-radius: 10rpx;
    font-size: 30rpx;
    color: #333;
}
.form-item label {
    float: left;
    margin-right: 30rpx;
    display: flex;
    align-items: center;
}
.form-item radio {
    transform: scale(0.75);
    margin-right: 10rpx;
}

.image {
    width: 116rpx;
    height: 116rpx;
    float: left;
    margin-right: 16rpx;
    position: relative;
    margin-bottom: 16rpx;
}
.image .img {
    width: 100%;
    height: 100%;
}
.image .del {
    position: absolute;
    right: 0;
    top: 0;
    border-bottom-left-radius: 6rpx;
    padding: 2rpx 8rpx;
    height: auto;
    background-color: rgba(0, 0, 0, 0.5);
}
.image .del .icon {
    font-size: 28rpx;
}

.btn-upload {
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
.btn-upload .icon {
    font-size: 52rpx;
}

.btn-submit {
    width: 60%;
    height: 80rpx;
    margin-top: 80rpx;
    letter-spacing: 4rpx;
    background: #04babe;
    color: #fff;
    border-radius: 40rpx;
}
</style>
