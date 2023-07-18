<template>
	<view>
		<view v-if="item.state === 0" class="writing">
			<draw-loading title="生成中，预计需要30秒左右" color="#04BABE" />
		</view>
		<view v-else-if="item.state === 1">
			<image v-for="(image, index) in item.response" class="image" :src="image" mode="widthFix" @tap="previewImage(image)"></image>
		</view>
		<view v-else-if="item.state === 2" class="writing fail">
			<view class="errmsg">
				<image src="/static/images/ic_fail.png"></image>
				<text style="max-width: 400rpx;">生成失败: {{ item.errmsg }} </text>
			</view>
			<view><text @tap="retry(item.draw_id)" class="btn-retry">重新生成</text></view>
		</view>
	</view>
</template>

<script>
	import drawLoading from './drawLoading'
	export default {
		components: {
			drawLoading
		},
		props: {
			item: {
				type: Object,
				default() {
					return {}
				}
			}
		},
		watch: {
			item: {
				handler(val) {
					console.log('val', val)
				},
				deep: true
			}
		},
		created() {
			console.log('')
		},
		methods: {
			previewImage(image) {
				this.$emit('preview', image)
			},
			retry(draw_id) {
				this.$emit('retry', draw_id)
			}
		}
	}
</script>
<style>
	.image {
		width: 100%;
		border-radius: 20rpx;
		border: 1px solid #f6f6f6;
		box-sizing: border-box;
		float: left;
	}
	
	.writing {
		width: 532rpx;
		height: 532rpx;
		background: #f7f7f7;
		display: flex;
		justify-content: center;
		align-items: center;
		border-radius: 20rpx;
	}
	
	.fail {
		flex-direction: column;
	}
	
	.fail .errmsg {
		color: #666;
		font-size: 28rpx;
		display: flex;
		align-items: flex-start;
		line-height: 42rpx;
		padding: 30rpx 0;
		overflow: hidden;
		max-height: 210rpx;
	}
	.fail .errmsg image {
		width: 32rpx;
		height: 32rpx;
		margin-right: 10rpx;
		position: relative;
		top: 4rpx;
	}
	.fail .btn-retry {
		color: #666;
		padding: 10rpx 24rpx;
		background: #fff;
		border-radius: 10rpx;
		margin-top: 20rpx;
		font-size: 24rpx;
	}
</style>