<template>
	<view style="height: 100%">
		<view class="page" v-if="pageIsLoad">
			<scroll-view v-if="lists && lists.length > 0" class="box-msg-list" :scroll-x="false" :scroll-y="true"
				:scroll-with-animation="false" :scroll-top="scrollTop"
				:style="'bottom: ' + (inputShow ? '316rpx' : '102rpx') + ';'">
				<view class="list">
					<block v-for="(item, index) in lists" :key="index">
						<view class="message" :data-index="index" v-if="item.user == 'AI'" style="background: #f7f7f8">
							<view class="avatar">
								<img mode="widthFix" src="/static/img/ic_ai.png" />
							</view>
							<view class="text markdown-body">
								<textComponent :text="item.message"></textComponent>
								<view style="display: block;">
									<span class="btn-copy" @click="copyText(item.message)">复制内容</span>
								</view>
							</view>
						</view>

						<view class="message" :data-index="index" @longpress="copyText(item.message)" v-else
							style="background: #fff">
							<view class="avatar" style="background: #9aa37e">
								<img mode="widthFix" src="/static/img/ic_user.png" />
							</view>
							<view class="text markdown-body">
								<textComponent :text="item.message"></textComponent>
							</view>
						</view>
					</block>
					<view class="message" style="background: #f7f7f8" v-if="writing || writingText">
						<view class="avatar">
							<img src="/static/img/ic_ai.png" />
						</view>
						<view class="text markdown-body">
							<textComponent :text="writingText" :writing="!!(writing || writingText)"></textComponent>
						</view>
					</view>
				</view>
			</scroll-view>
			<view class="box-input">
				<view class="input">
					<textarea type="text" v-model="message" confirm-type="send" @confirm="sendConfirm"
						:auto-height="true" :placeholder="role.hint || '输入你的问题'" maxlength="3000" cursor-spacing="0"></textarea>
					<button class="btn-send" @tap="sendText">
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
	import 'katex/dist/katex.min.css'
	import '../../static/styles/lib/tailwind.css'
	import '../../static/styles/lib/highlight.scss'
	import '../../static/styles/lib/github-markdown.scss'

	var textStacks = []
	var textOutputSi = 0

	export default {
		components: {
			TextComponent
		},
		data() {
			return {
				pageIsLoad: false,
				siteroot: '',
				lists: [],
				message: '',
				writingText: '',
				writing: false,
				page: 1,
				pagesize: 10,
				scrollTop: 0,
				role: {},
				role_id: 0,
				inputShow: true
			};
		},
		onLoad(options) {
			if (options.role_id) {
				this.setData({
					role_id: options.role_id
				})
			}
			
			this.setData({
				system: app.globalData.system,
				siteroot: app.globalData.siteroot.replace('/web.php', '')
			});
			app.globalData.util.checkLogin().then(() => {
				this.getRole();
				this.getHistoryMsg();
				this.setData({
					pageIsLoad: true
				});
			});
		},
		methods: {

			async sendText() {
				if (this.writing) {
					return
				}
				var message = this.trim(this.message)
				if (!message) {
					if (this.role.hint) {
						this.message = this.role.hint
						message = this.message
					} else {
						app.globalData.util.message('请输入你的问题')
						this.message = ''
						return
					}
				}
				
				if (textOutputSi) {
					clearInterval(textOutputSi)
					textOutputSi = 0
					textStacks = []
				}
				
				this.lists.push({
					user: '我',
					message: message
				});
				this.message = ''
				this.writing = true
				this.scrollToBottom()

				const headers = new Headers();
				headers.append('Content-Type', 'application/json');
				headers.append('X-site', uni.getStorageSync('sitecode'));
				const url = this.siteroot + '/web.php/chat/sendText'
				const data = {
					role_id: this.role_id,
					message: message
				}
				const response = await fetch(url, {
					method: 'POST',
					headers: headers,
					body: JSON.stringify(data),
				});
				if (!response.ok) {
					this.writing = false
					app.globalData.util.message(response.statusText)
					return
				}
				const reader = response.body.getReader();
				const decoder = new TextDecoder('utf-8');
				let done = false;
				let curAiMsg = '';
				
				textOutputSi = setInterval(() => {
					if (textStacks.length > 0) {
						this.writingText += textStacks.shift();
						this.scrollToBottom()
					} else if (!this.writing) {
						clearInterval(textOutputSi)
						textOutputSi = 0
						if (this.writingText) {
							this.lists.push({
								user: 'AI',
								message: this.writingText
							});
						}
						this.writingText = '';
				
						setTimeout(() => {
							this.scrollToBottom();
						}, 200)
					}
				}, 50)
				
				while (!done) {
					this.scrollToBottom()
					const {
						value,
						done: readerDone
					} = await reader.read();
					if (value) {
						let char = decoder.decode(value);
						if (char === '\n' && curAiMsg.endsWith('\n')) {
							continue;
						}
						if (char) {
							if (char.indexOf('[error]') !== -1) {
								this.writing = false;
								this.writingText = '';
								this.lists.pop();
								const error = char.replace('[error]', '')
								if (error.indexOf('请登录') !== -1) {
									this.$emit('showlogin')
									setTimeout(() => {
										app.globalData.util.message(error)
									}, 500)
								} else if (error.indexOf('请充值') !== -1) {
									this.$emit('showUserInfo')
									setTimeout(() => {
										app.globalData.util.message(error)
									}, 500)
								} else {
									app.globalData.util.message(error, 'error');
								}
								break;
							}
							// char = char.replaceAll("\n", "<br>");
							this.writing = true;
							// this.writingText += char;
							
							for (var i = 0; i < char.length; i++) {
								textStacks.push(char[i])
							}
						}
					}
					done = readerDone;
				}
				
				this.writing = false;
			},
			
			sendConfirm() {
				setTimeout(() => {
					this.sendText()
				}, 50)
			},

			getHistoryMsg() {
				app.globalData.util
					.request({
						url: '/cosplay/getHistoryMsg',
						data: {
							role_id: this.role_id,
							page: this.page,
							pagesize: this.pagesize
						}
					})
					.then((res) => {
						if (res.data.length > 0) {
							this.setData({
								lists: res.data
							});
						}
						setTimeout(() => {
							this.scrollToBottom();
						}, 300)
					});
			},

			getRole() {
				app.globalData.util.request({
					url: '/cosplay/getRole',
					data: {
						role_id: this.role_id
					}
				}).then(res => {
					this.setData({
						role: res.data
					})
					document.title = res.data.title
				})
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
				}, 200);
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

			trim(str) {
				if (str) {
					return str.replace(/(^\s*)|(\s*$)/g, '');
				} else {
					return ''
				}
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
		background: #f6f9fc;
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
		max-height: 800rpx;
		overflow-x: hidden;
		overflow-y: auto;
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
	}
	
	.empty {
		text-align: center;
		margin: 0 60rpx;
		padding: 80rpx 0 100rpx 0;
		margin-top: 200rpx;
		background: #fff;
		border-radius: 20rpx;
	}
	
	.empty image {
		width: 404rpx;
		height: 266rpx;
		margin-bottom: 40rpx;
	}
	
	.empty .tip {
		width: 100%;
		line-height: 40rpx;
		font-size: 32rpx;
		letter-spacing: 2rpx;
		color: #444;
	}
	
	.btn-finish {
		width: 60%;
		height: 80rpx;
		line-height: 80rpx;
		border-radius: 48rpx;
		border: none;
		color: #fff;
		margin: 240rpx auto 0 20%;
		box-shadow: 0 0 20rpx rgba(0, 235, 79, 0.1);
		font-size: 30rpx;
		letter-spacing: 4rpx;
		outline: none;
		background: #39b54a;
		text-align: center;
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
		background: #fff;
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
	}
	
	.message {
		display: flex;
		justify-content: flex-start;
		padding: 40rpx 40rpx;
		border-bottom: 2rpx solid #eee;
	}
	
	.message:last-child {
		border-bottom: 0;
	}
	
	.message .text {
		width: 100%;
		color: #343541;
		line-height: 52rpx;
		font-size: 32rpx;
		word-break: break-all;
		padding: 4rpx 0;
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
	
	.content image {
		width: 100%;
	}
	
	.btn-copy {
		color: #409EFF;
	}
</style>