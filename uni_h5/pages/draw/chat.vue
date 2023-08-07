<template>
	<view style="height: 100%">
		<view class="page" v-if="pageIsLoad">
			<scroll-view class="box-msg-list" :scroll-x="false" :scroll-y="true" :scroll-with-animation="false"
				:scroll-top="scrollTop">
				<view class="list" v-if="lists && lists.length > 0">
					<view class="message-group" v-for="(item, index) in lists" :key="index">
						<view class="message user" :data-index="index" @longpress="copyText(item.message)">
							<view class="avatar" style="background: #9aa37e">
								<img mode="widthFix" src="/static/img/ic_user.png" />
							</view>
							<view class="text">
								<textComponent :text="item.message"></textComponent>
								<!-- <view style="display: block;">
									<span class="btn-copy" @click="toEdit(item.message)">编辑</span>
								</view> -->
							</view>
						</view>
						<view class="message ai">
							<view class="avatar">
								<img mode="widthFix" src="/static/img/ic_ai.png" />
							</view>
							<view class="text">
								<imageComponent
									:item="item"
									@preview="previewImage"
									@retry="retryDraw"
								></imageComponent>
							</view>
						</view>

					</view>
				</view>
			</scroll-view>

			<view class="box-input">
				<view class="input">
					<textarea type="text" v-model="message" :auto-height="true" placeholder="请输入要求和场景描述" maxlength="3000" cursor-spacing="0"></textarea>
					<button class="btn-send" @tap="submitDraw">
						<image mode="widthFix" src="/static/images/ic_send.png"></image>
					</button>
				</view>
			</view>
		</view>

	</view>
</template>

<script>
	const app = getApp();
	import TextComponent from '../../components/message/text'
	import ImageComponent from '../../components/message/image'
	import 'katex/dist/katex.min.css'
	import '../../static/styles/lib/tailwind.css'
	import '../../static/styles/lib/highlight.scss'
	import '../../static/styles/lib/github-markdown.scss'

	export default {
		components: {
			TextComponent,
			ImageComponent
		},
		data() {
			return {
				pageIsLoad: false,
				siteroot: '',
				lists: [],
				message: '',
				page: 1,
				pagesize: 10,
				scrollTop: 0,
				inputShow: true
			};
		},
		onLoad(options) {
			this.setData({
				system: app.globalData.system,
				siteroot: app.globalData.siteroot.replace('/web.php', '')
			});
			app.globalData.util.checkLogin().then(() => {
				this.getHistoryMsg();
				this.setData({
					pageIsLoad: true
				});
			});
		},
		methods: {
			submitDraw() {
				var message = this.trim(this.message)
				if (!message) {
					if (this.prompt.hint) {
						this.message = this.prompt.hint
						message = this.message
					} else {
						app.globalData.util.message('请输入要求和场景描述')
						this.message = ''
						return
					}
				}

				this.message = ''
				this.scrollToBottom()

				app.globalData.util
					.request({
						url: '/draw/draw',
						data: {
							message: message
						}
					})
					.then(res => {
						this.lists.push({
							state: 0,
							draw_id: res.data.draw_id,
							message: message
						});

						this.startLoopResult(res.data.draw_id);

						setTimeout(() => {
							this.scrollToBottom()
						}, 500)
					})
					.catch(res => {
						if (res.message.indexOf('请充值') !== -1) {
							app.globalData.util.message(res.message, 'error', function() {
								uni.navigateTo({
									url: '/pages/pay/draw'
								})
							});
						}
					})
			},

			startLoopResult(draw_id) {
				var si = setInterval(() => {
					app.globalData.util
						.request({
							url: '/draw/getDrawResult',
							data: {
								draw_id: draw_id
							},
							loading: false
						})
						.then(res => {
							var lists = this.lists
							lists.forEach((item, index) => {
								if (item.draw_id == draw_id) {
									var state = res.data.state
									lists[index].state = state
									if (state != 0) {
										clearInterval(si)
										if (state == 1) {
											lists[index].response = res.data.images
										}
										else if (state == 2) {
											lists[index].errmsg = res.data.message
										}
										this.lists = lists
										setTimeout(() => {
											this.scrollToBottom()
										}, 300)
									}
								}
							})
						});
				}, 5000)
			},

			retryDraw(draw_id) {
				app.globalData.util
					.request({
						url: '/draw/draw',
						data: {
							draw_id: draw_id
						}
					})
					.then((res) => {
						var lists = this.lists
						lists.forEach((item, index) => {
							if (item.draw_id == draw_id) {
								lists[index].state = 0
								lists[index].errmsg = ''
								lists[index].response = ''
								this.startLoopResult(draw_id)
							}
						})
						this.lists = lists
					})
			},

			getHistoryMsg() {
				app.globalData.util
					.request({
						url: '/draw/getHistoryMsg',
						data: {
							page: this.page,
							pagesize: this.pagesize
						}
					})
					.then((res) => {
						if (res.data.length > 0) {
							var lists = res.data
							this.setData({
								lists: lists
							});
							lists.forEach((item, index) => {
								if (item.state == 0) {
									this.startLoopResult(item.draw_id);
								}
							})
						}
						setTimeout(() => {
							this.scrollToBottom();
						}, 500)
					});
			},

			scrollToBottom() {
				setTimeout(() => {
					let query = uni.createSelectorQuery().in(this);
					query.select('.list').boundingClientRect((res) => {
						this.setData({
							scrollTop: parseInt(res.height)
						});
					});
					query.exec((res) => {});
				}, 100);
			},

			copyText(text) {
				let textarea = document.createElement("textarea")
				textarea.value = text
				textarea.readOnly = "readOnly"
				textarea.style = "width:0;height:0;"
				document.body.appendChild(textarea)
				textarea.select()
				textarea.setSelectionRange(0, text.length)
				app.globalData.util.message('已复制')
				document.execCommand("copy")
				textarea.remove()
			},

			previewImage(src) {
				var urls = []
				this.lists.forEach((item, index) => {
					if (item.state == 1) {
						item.response.forEach((img, idx) => {
							urls.push(img)
						})
					}
				})
				uni.previewImage({
					urls: urls,
					current: src
				})
			},

			trim(str) {
				if (str) {
					return str.replace(/(^\s*)|(\s*$)/g, '');
				} else {
					return ''
				}
			},

			toEdit(message) {
				this.message = message
			}
		}
	};
</script>
<style>
	page {
		background: #f7f7f7;
	}

	.box-input {
		width: 100%;
		padding: 40rpx 0;
		left: 0;
		bottom: 0;
		border-top: 1px solid #d8d8e2;
		background: #f6fafc;
	}

	.box-input .input {
		width: 690rpx;
		margin: 0 30rpx;
		position: relative;
		box-sizing: border-box;
		box-shadow: 0 0 12rpx rgba(0, 0, 0, 0.1);
		background: #fefefe;
	}

	.box-input .input textarea {
		width: 580rpx;
		padding: 20rpx 10rpx 20rpx 20rpx;
		border-radius: 10rpx;
		line-height: 40rpx;
	}

	.box-input .input .btn-send {
		position: absolute;
		right: 0;
		bottom: 0;
		width: 100rpx;
		height: 80rpx;
		padding: 0;
		border: none;
		border-radius: 10rpx;
		background: none;
		display: flex;
		align-items: center;
		justify-content: center;
		z-index: 9;
	}

	.box-input .input .btn-send::after {
		display: none;
	}

	.box-input .input .btn-send:active {
		background: #f2f2f2;
	}

	.box-input .input .btn-send image {
		width: 40rpx;
		height: 40rpx;
	}

	.page {
		width: 100%;
		overflow: hidden;
		display: flex;
		flex-direction: column;
		position: absolute;
		left: 0;
		right: 0;
		top: 0;
		bottom: 0;
		background: #f7f7f7;
	}

	.box-msg-list {
		width: 100%;
		height: 100%;
		top: 0;
		bottom: 132rpx;
		left: 0;
		box-sizing: border-box;
		overflow: hidden;
	}

	.list {
		width: 100%;
		height: auto;
		padding-bottom: 40rpx;
		box-sizing: border-box;
	}

	.message-group {
		background: #fff;
		margin: 40rpx 30rpx 0 30rpx;
		border-radius: 20rpx;
		overflow: hidden;
	}

	.message {
		display: flex;
		justify-content: flex-start;
		padding: 40rpx 40rpx;
	}

	.message.user {
		border-bottom: 2rpx solid #f6f6f6;
	}

	.message .text {
		width: 100%;
		color: #343541;
		line-height: 52rpx;
		font-size: 32rpx;
		word-break: break-all;
		padding: 3rpx 0;
		overflow: hidden;
	}

	.message .text span {
		display: inline;
	}

	.message .avatar {
		width: 48rpx;
		height: 48rpx;
		background: #10a37f;
		margin-right: 30rpx;
		color: #fff;
		font-size: 28rpx;
		border-radius: 4rpx;
		display: flex;
		align-items: center;
		justify-content: center;
		margin-top: 6rpx;
		overflow: hidden;
	}

	.message .avatar image,
	.message .avatar img {
		width: 48rpx;
		height: 48rpx;
	}

	.account {
		margin: 20rpx 30rpx;
		padding: 16rpx 24rpx 16rpx 24rpx;
		box-sizing: border-box;
		/* background: #f3f6f9; */
		border-radius: 10rpx;
		display: flex;
		justify-content: space-between;
		align-items: center;
	}

	.account .balance {
		color: #666;
		font-size: 24rpx;
	}

	.account .balance text {
		color: #10a37f;
		margin-right: 6rpx;
	}

	.account .btn-pay {
		display: inline-block;
		color: #10a37f;
		margin-left: 20rpx;
		font-size: 24rpx;
	}

	.banner-ad {
		width: 100%;
		height: 120rpx;
		border-top: 2rpx solid #ddd;
	}

	.cursor {
		background: #3d3d3d;
		width: 100%;
		line-height: 100%;
		border-left: 0.1em solid transparent;
		animation: cursor 0.6s infinite;
		display: inline-block;
		width: 10rpx;
		height: 40rpx;
		position: relative;
		top: 6rpx;
	}

	/* Animation */
	@keyframes cursor {
		50% {
			background: white;
		}
	}

	.content {
		padding: 20rpx;
	}

	.content view {
		margin: 10rpx 0;
		word-break: break-all;
		line-height: 1.5;
		font-size: 28rpx;
		color: #444;
	}

	.content img {
		width: 100%;
	}

	.btn-copy {
		color: #409EFF;
	}
</style>
