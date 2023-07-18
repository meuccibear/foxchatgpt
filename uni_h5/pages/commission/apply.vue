<template>
    <view class="page">
        <view class="container">
            <view class="login-bg">
                <image class="wave" src="/static/images/wave.png"></image>
            </view>
            <view class="login-main">
                <view v-if="lastApply && !isEdit" class="audit-result">
                    <view v-if="lastApply.status == 0">
                        <image class="icon" src="/static/images/ic_audit.png"></image>
                        <view class="message">申请已提交，正在审核中</view>
                        <view class="time">{{ lastApply.create_time }} 提交</view>
                    </view>
                    <view v-if="lastApply.status == 1">
                        <image class="icon" src="/static/images/ic_pass.png"></image>
                        <view class="message">恭喜你，已通过审核</view>
                        <view class="time">{{ lastApply.create_time }} 提交</view>
                        <view class="btn" @tap="toCommission">进入推广中心</view>
                    </view>
                    <view v-if="lastApply.status == 2">
                        <image class="icon" src="/static/images/ic_reject.png"></image>
                        <view class="message">审核被驳回，可调整后重新提交</view>
                        <view class="time">{{ lastApply.create_time }} 提交</view>
                        <view class="btn" @tap="toEdit">返回编辑</view>
                        <view class="reject">驳回原因：{{ lastApply.reject_reason ? lastApply.reject_reason : '无' }}</view>
                    </view>
                </view>
                <view v-else class="login-form">
                    <view class="form-item">
                        <text class="label">姓名</text>
                        <input type="text" class="input" placeholder="请输入姓名" v-model="name" />
                    </view>
                    <view class="form-item">
                        <text class="label">手机号</text>
                        <input type="text" class="input" maxlength="11" placeholder="请输入手机号" v-model="phone" />
                    </view>
                    <view class="form-item" style="display: flex; align-items: center; padding-top: 30rpx">
                        <label class="agreement">
                            <checkbox-group @change="checkboxChange">
                                <checkbox class="check" :value="true" :checked="is_agree" color="#04BABE" />
                                阅读并同意
                            </checkbox-group>
                        </label>
                        <text class="agreement" @tap="toAgreement" style="color: #04babe">《用户分销协议》</text>
                    </view>
                    <view class="form-item">
                        <button class="btn-login" @tap="doSubmit">立即申请</button>
                    </view>
                </view>
            </view>
        </view>
    </view>
</template>

<script>
const app = getApp();
export default {
    data() {
        return {
            name: '',
            phone: '',
            is_agree: false,
            pid: 0,
            focus: '',
            lastApply: null,
            isEdit: false
        };
    },
    onLoad(options) {
		if (param.pid) {
			this.setData({
				pid: param.pid
			});
		}
        // let phone = uni.getStorageSync('phone');
        // if (phone) {
        //     this.setData({
        //         phone: phone
        //     });
        // }
        this.getLastApply();
    },
    methods: {
        doSubmit: function () {
            const that = this;
            let name = this.name;
            let phone = this.phone;
            let pid = this.pid;
            let is_agree = this.is_agree;
            if (!name) {
                app.globalData.util.message('请输入姓名', 'error');
                return;
            }
            if (!phone) {
                app.globalData.util.message('请输入手机号', 'error');
                return;
            }
            if (!is_agree) {
                app.globalData.util.message('请阅读并同意《用户分销协议》', 'error');
                this.setData({
                    is_agree: true
                });
                return;
            }
            app.globalData.util
                .request({
                    url: '/commission/apply',
                    data: {
                        name: name,
                        phone: phone,
                        pid: pid
                    }
                })
                .then((res) => {
                    uni.showModal({
                        title: '系统提示',
                        content: res.message,
                        showCancel: false,
                        success() {
                            that.setData({
                                lastApply: null,
                                isEdit: false
                            });
                            that.getLastApply();
                        }
                    });
                });
        },

        toAgreement() {
            uni.navigateTo({
                url: '/pages/article/article?type=commission'
            });
        },

        toCommission() {
            uni.redirectTo({
                url: '/pages/commission/index'
            });
        },

        toEdit() {
            this.setData({
                isEdit: true
            });
        },

        getLastApply() {
            app.globalData.util
                .request({
                    url: '/commission/getLastApply'
                })
                .then((res) => {
                    if (res.data) {
                        this.setData({
                            lastApply: res.data,
                            name: res.data.name,
                            phone: res.data.phone
                        });
                    }
                });
        },

        inputChange(e) {
            let name = e.currentTarget.dataset.name;
            let value = e.detail.value;
            this.setData({
                [name]: value
            });
        },

        inputFocus(e) {
            let name = e.currentTarget.dataset.name;
            this.setData({
                focus: name
            });
        },

        inputBlur(e) {
            let name = e.currentTarget.dataset.name;
            if (this.focus == name) {
                this.setData({
                    focus: ''
                });
            }
        },

        checkboxChange(e) {
            let value = e.detail.value;
            this.setData({
                is_agree: value.length > 0
            });
        }
    }
};
</script>
<style>
.container {
    position: relative;
    padding: 0;
}

.login-bg {
    width: 750rpx;
    height: 240rpx;
    background: #04babe;
    position: relative;
}

.login-bg .wave {
    width: 750rpx;
    height: 38rpx;
    position: absolute;
    left: 0;
    bottom: 0;
}

.login-main {
    padding: 30rpx 80rpx;
    margin-top: 100rpx;
}

.form-item {
    display: flex;
    align-items: center;
    position: relative;
    margin-bottom: 40rpx;
}

.form-item .input {
    width: 100%;
    border: none;
    border-bottom: 2px solid #04babe;
    height: 80rpx;
    line-height: 80rpx;
    padding: 0 20rpx 0 180rpx;
}
.form-item .label {
    font-size: 32rpx;
    line-height: 40rpx;
    position: absolute;
    left: 20rpx;
    top: 20rpx;
}

.form-item .icon {
    width: 36rpx;
    height: 36rpx;
    position: absolute;
    left: 20rpx;
    top: 20rpx;
}

.form-item .eye {
    width: 36rpx;
    height: 36rpx;
    position: absolute;
    right: 20rpx;
    top: 20rpx;
    z-index: 10;
}

.form-item .check {
    transform: scale(0.75);
    margin-right: 6rpx;
}

.form-item .agreement {
    font-size: 28rpx;
    color: #666;
    display: flex;
    align-items: center;
}

.form-item .agreement text {
    color: #000;
}

.btn-login {
    color: #fff;
    background: #04babe;
    border-radius: 44rpx;
    width: 100%;
    height: 88rpx;
    line-height: 88rpx;
    text-align: center;
    font-size: 32rpx;
    margin: 100rpx auto 0 auto;
}

.audit-result {
    text-align: center;
    margin-top: 88rpx;
}

.audit-result .icon {
    width: 120rpx;
    height: 120rpx;
}
.audit-result .message {
    width: 100%;
    line-height: 44rpx;
    font-size: 36rpx;
    color: #666;
    margin-top: 60rpx;
}
.audit-result .time {
    width: 100%;
    line-height: 44rpx;
    font-size: 24rpx;
    color: #999;
    margin-top: 20rpx;
}
.audit-result .btn {
    width: 240rpx;
    height: 60rpx;
    border: 1px solid #666;
    border-radius: 10rpx;
    line-height: 60rpx;
    text-align: center;
    margin: 0 auto;
    margin-top: 60rpx;
    font-size: 28rpx;
    color: #666;
}
.audit-result .reject {
    font-size: 28rpx;
    color: red;
    margin-top: 40rpx;
    line-height: 44rpx;
}
</style>
