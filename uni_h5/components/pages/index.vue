<template>
    <view class="pages">
        <text class="prev" @tap="doPrev">上页</text>
        <text class="current" @tap="showPageInputFun">{{ page }} / {{ pageMax }}</text>
        <text class="next" @tap="doNext">下页</text>
    </view>
</template>

<script>
export default {
    data() {
        return {
            pageMax: 1,
            pageInput: '',
            showPageInput: false
        };
    },
    props: {
        page: {
            type: Number,
            default: 0
        },
        pagesize: {
            type: Number
        },
        count: {
            type: Number
        }
    },
    watch: {
        count_pagesize: {
            deep: true,
            immediate: true,

            handler: function (newValue, oldValue) {
                const { count, pagesize } = newValue;

                this.setData({
                    pageMax: Math.ceil(this.count / this.pagesize)
                });
            }
        }
    },
    methods: {
        doPageChange() {
            this.$emit('change', {
                detail: this.pageInput
            });
            this.closePageInput();
        },
        doPrev() {
            if (this.page > 1) {
                this.$emit('change', {
                    detail: this.page - 1
                });
            }
        },
        doNext() {
            if (this.page < this.pageMax) {
                this.$emit('change', {
                    detail: this.page + 1
                });
            }
        },
        showPageInputFun() {
            this.setData({
                pageInput: this.page,
                showPageInput: true
            });
        },
        closePageInput() {
            this.setData({
                showPageInput: false
            });
        }
    },
    created: function () {},
    computed: {
        count_pagesize() {
            const { count, pagesize } = this;

            return {
                count,
                pagesize
            };
        }
    }
};
</script>
<style>
.pages {
    text-align: center;
    padding: 20rpx 0;
}
.pages text {
    display: inline-block;
    background: #ffffff;
    padding: 12rpx 30rpx;
    font-size: 30rpx;
    margin: 0 20rpx;
    border-radius: 10rpx;
    color: #666;
}
.pages text:active {
    background: #04babe;
    color: #fff;
}
.pages .form-block {
    background-color: #fff;
    padding: 30rpx 100rpx 30rpx 100rpx;
    box-sizing: border-box;
    margin-bottom: 20rpx;
}

.pages .form-label {
    margin: 0;
    padding: 24rpx 0 24rpx;
    color: #333;
    font-weight: normal;
    font-size: 28rpx;
    line-height: 32rpx;
}
</style>
