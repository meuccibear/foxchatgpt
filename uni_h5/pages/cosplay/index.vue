<template>
    <view class="page">
		<view v-for="(group, index) in allRoles" :key="index">
			<view class="group" v-if="group.roles && group.roles.length > 0">
				<view class="type-title"><text>{{ group.title }}</text></view>
				<view class="role-list">
				    <view class="role-item"
						v-for="(item, index) in group.roles"
						:key="index"
						@tap="toCosplayChat"
						:data-id="item.id"
					>
						<view class="thumb">
							<image :src="item.thumb || '/static/images/cosplay/default.png'"></image>
						</view>
						<view style="width: 192rpx;">
							<view class="title">{{ item.title }}</view>
							<view class="ops">
								<view class="op-item" style="padding-right: 20rpx;">
									<image class="icon" src="/static/images/cosplay/ic_views.png"></image>
									{{ item.views }}
								</view>
								<view class="op-item">
									<image class="icon" src="/static/images/cosplay/ic_usages.png"></image>
									{{ item.usages }}
								</view>
							</view>
						</view>
				    </view>
				    <view style="clear: both"></view>
				</view>
			</view>
		</view>

        <view class="empty" v-if="!allRoles || allRoles.length == 0">
            <image src="/static/images/nodata.png"></image>
        </view>

		<view class="nomore" v-else>没有更多了~</view>
    </view>
</template>

<script>
const app = getApp();
export default {
    data() {
        return {
            allRoles: []
        };
    },
    onLoad(options) {
        app.globalData.util.checkLogin().then(() => {
            this.getAllRoles();
        });
    },
    methods: {
        getAllRoles() {
            app.globalData.util
                .request({
                    url: '/cosplay/getAllRoles'
                })
                .then((res) => {
                    this.setData({
                        allRoles: res.data
                    });
                });
        },

        toCosplayChat(e) {
            const id = e.currentTarget.dataset.id;
            uni.navigateTo({
                url: '/pages/cosplay/chat?role_id=' + id
            });
        }
    }
};
</script>
<style>
page {
    background: #f7f7f7;
}

.group {
	margin: 30rpx 20rpx 0 20rpx;
	background: #fff;
	border-radius: 20rpx;
	overflow: hidden;
}

.type-title {
    color: #233445;
    height: 72rpx;
    line-height: 72rpx;
    padding: 20rpx 5rpx 0 6rpx;
    position: relative;
    box-sizing: border-box;
	padding-left: 30rpx;
}
.type-title text {
	color: #666;
	font-size: 32rpx;
	font-weight: bold;
}

.role-list {
    width: 100%;
    background-color: #fff;
    padding: 50rpx 0 30rpx 30rpx;
}

.role-item {
    background: #f2f2f2;
    padding: 20rpx 20rpx;
    border-radius: 14rpx;
    margin: 0 20rpx 20rpx 0;
    float: left;
    width: 280rpx;
	display: flex;
}

.role-item:active {
    background: #f0f0f0;
}
.role-item .thumb {
	width: 88rpx;
	height: 88rpx;
	margin-right: 20rpx;
	border-radius: 10rpx;
	overflow: hidden;
}
.role-item .thumb image {
	width: 100%;
	height: 100%;
}

.role-item .title {
    font-size: 28rpx;
    font-weight: bold;
    line-height: 44rpx;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 2;
    overflow: hidden;
}

.role-item .ops {
    display: flex;
    align-items: center;
    margin-top: 14rpx;
    height: 32rpx;
}
.role-item .ops .op-item {
    display: flex;
    align-items: center;
    color: #8e8ea0;
    font-size: 24rpx;
}
.role-item .ops .op-item .icon {
    width: 28rpx;
    height: 28rpx;
    margin-right: 10rpx;
}

.empty {
    text-align: center;
    margin: 0 60rpx;
    padding: 80rpx 0 100rpx 0;
    margin-top: 120rpx;
    border-radius: 20rpx;
}
.empty image {
    width: 240rpx;
    height: 240rpx;
}

.nomore {
	height: 48rpx;
	text-align: center;
	color: #aaa;
	margin: 40rpx 0;
	font-size: 28rpx;
}

</style>
