<template>
    <view>
        <view class="list">
            <view class="item" v-for="(item, index) in list" @tap="toArticle" :data-id="item.id">{{ index + 1}}、{{ item.title }}</view>
        </view>
    </view>

</template>

<script>
const app = getApp();
export default {
    data() {
        return {
            type: 'help',
			list: []
        };
    },
    onLoad(options) {
		const type = options.type
		this.setData({
			type: type
		})
		if(type == 'help') {
			uni.setNavigationBarTitle({
			  title: '使用教程'
			})
		}
		app.globalData.util.request({
			url: '/article/getList',
			data: {
				type: type
			}
		}).then(res => {
			this.setData({
				list: res.data.list
			})
		})
    },
    methods: {
		toArticle(e) {
			const id = e.currentTarget.dataset.id
			wx.navigateTo({
			  url: '/pages/article/article?type=' + this.type + '&id=' + id
			})
		}
	}
};
</script>
<style>
page {
    background: #f2f2f2;
}
.list {
    background: #fff;
    margin: 30rpx;
    border-radius: 20rpx;
    overflow: hidden;
}
.item {
    line-height: 40rpx;
    padding: 40rpx 40rpx;
    font-size: 32rpx;
    color: #333;
    border-radius: 10rpx;
    border-bottom: 1px solid #f2f2f2;
}
.item:active {
    background: #f3f3f4;
}
.item:last-child {
    border-bottom: none;
}
</style>
