<template>
	<view style="height: 100%">
		<view class="page" :class="{gold: model === 'model4'}" v-if="pageIsLoad">
			<view class="tab-model" v-if="hasModel4">
				<view class="tab-item" :class="{active: model === 'default'}" @tap="switchModel('default')">默认</view>
				<view class="tab-item" :class="{active: model === 'model4'}" @tap="switchModel('model4')">{{model4Name}}</view>
			</view>
			<scroll-view class="box-msg-list" :scroll-x="false" :scroll-y="true" :scroll-with-animation="false"
				:scroll-top="scrollTop"
        :style="'bottom: ' + (inputShow ? '316rpx' : '102rpx') + ';'">
				<view class="list" v-if="lists && lists.length > 0">
					<block v-for="(item, index) in lists" :key="index">
						<view class="message" :data-index="index" v-if="item.user == 'AI'" style="background: #f2f2f2">
							<view class="avatar">
								<img src="/static/img/ic_ai.png" />
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
								<img src="/static/img/ic_user.png" />
							</view>
							<view class="text markdown-body">
								<textComponent :text="item.message"></textComponent>
							</view>
						</view>
					</block>
					<view class="message" style="background: #f2f2f2" v-if="writing || writingText">
						<view class="avatar">
							<img src="/static/img/ic_ai.png" />
						</view>
						<view class="text markdown-body">
							<textComponent :text="writingText" :writing="!!(writing || writingText)"></textComponent>
							<!-- <view style="display: block;">
								<span class="btn-copy" @click="abortFetching">停止回复</span>
							</view> -->
						</view>
					</view>
				</view>
				<view v-else :style="'padding-top: ' + (hasModel4 ? 40 : 0) + 'rpx;'">
					<welcome @use="quickMessage"></welcome>
				</view>
			</scroll-view>

      <view class="box-input" :style="'bottom: ' + (inputShow ? '0' : '-204rpx') + ';'">
        <view class="tools">
          <view
              v-for="(item, index) in langs"
              class="item"
              :class="{active: userCache.lang.indexOf(item) > -1 }"
              @click="changeLang(item)">
            <text>{{item}}</text>
            <image class="ic_sj" src="/static/images/write/ic_sj.png"></image>
          </view>
          <view class="item close" @click="showInput"
                :style="'transform: rotate(' + (inputShow ? '180' : 0) + 'deg);'">
            <image src="/static/images/write/ic_up.png" style="width: 32rpx;height: 32rpx;"></image>
          </view>
        </view>
				<view class="input">
					<textarea type="text" v-model="message" confirm-type="send" @confirm="sendConfirm"
						:auto-height="true" placeholder="输入你的问题" maxlength="3000" cursor-spacing="0"></textarea>
					<button class="btn-send" @tap="sendText">
						<image mode="widthFix" src="/static/images/ic_send.png"></image>
					</button>
				</view>
				<view class="balance4" v-if="model === 'model4'" @tap="toModel4Pay">
					{{model4Name}} 余额<text>{{balance_model4}}</text>万字
				</view>
			</view>
		</view>

    <view>
      <!-- 输入框示例 -->
      <uni-popup ref="inputDialog" type="dialog">
        <uni-popup-dialog
            ref="inputClose"
            mode="checkbox"
            title="请选择知识库"
            type="info"
            placeholder="请输入内容"
            :value="userCache.knowledgeBaseCheckData"
            @confirm="dialogInputConfirm"
            :checkboxData="knowledgeBase"></uni-popup-dialog>
      </uni-popup>
    </view>
	</view>
</template>

<script>
  const app = getApp();

	import TextComponent from '../../components/message/text'
	import Welcome from '../../components/welcome/index'
	import 'katex/dist/katex.min.css'
	import '../../static/styles/lib/tailwind.css'
	import '../../static/styles/lib/highlight.scss'
	import '../../static/styles/lib/github-markdown.scss'

	var textStacks = []
	var textOutputSi = 0
	const fetchController = new AbortController()
    const fetchSignal = fetchController.signal

	export default {
		components: {
			TextComponent,
			Welcome
		},
		data() {
      let userCache = {
        lang: [],
        knowledgeBaseCheckData: []
      }
      uni.getStorage({
        key: 'UserCache',
        success: (res) => {
          console.log('getCache:', res.data)
          userCache = res.data
        }
      })
      console.log('data:')
			return {
				pageIsLoad: false,
				siteroot: '',
				group_id: 0,
				lists: [],
				message: '',
				writingText: '',
				writing: false,
				page: 1,
				pagesize: 10,
				scrollTop: 0,
				page_title: '',
				hasModel4: false,
				model4Name: '',
				balance_model4: '',
				model: 'default',
        userCache: userCache,
        langs: ['联网', '知识库'],
        inputShow: true,
        knowledgeBase: [
          {
            repo_id: 'mvdb274eefbae618428585fc8f6facc1',
            repo_name: "\u540c\u4ec1\u5802\u77e5\u8bc6\u5e93",
            repo_desc: "\u548c\u540c\u4ec1\u5802\u53ca\u5176\u4ea7\u54c1\u76f8\u5173\u7684\u5185\u5bb9"
          }
        ]
        /**
         * [
         *         {
         *             "repo_id":"mvdb274eefbae618428585fc8f6facc1",
         *             "repo_name":"\u540c\u4ec1\u5802\u77e5\u8bc6\u5e93",
         *             "repo_desc":"\u548c\u540c\u4ec1\u5802\u53ca\u5176\u4ea7\u54c1\u76f8\u5173\u7684\u5185\u5bb9"
         *         },
         *         {
         *             "repo_id":"mvdbcff53daea9be4592841855e858cc",
         *             "repo_name":"\u79c1\u57df\u5f15\u6d41\u4e0e\u793e\u7fa4\u8425\u9500\u77e5\u8bc6\u5e93",
         *             "repo_desc":"\u82b1\u7237\u7684\u79c1\u57df\u5f15\u6d41\u4e0e\u793e\u7fa4\u8425\u9500\uff0c\u76f4\u64ad\u6280\u5de7\u7b49\u6570\u5b57\u5a92\u4f53\u8425\u9500\u76f8\u5173\u5185\u5bb9"
         *         }
         *     ]
         */
      //   ["internetsearch","repodb:mvdbb96ca0b7e3ef4c1b97e7f68722f8","repodb:mvdbb96ca0b7e3ef4c1b97e7f685555"]
			};
		},
		onLoad(options) {
			let tuid = 0
			let search = window.location.search
			if (search && search.indexOf('tuid=') != -1) {
				search = search.split('tuid=')[1]
				tuid = parseInt(search)
				if (tuid) {
					uni.setStorageSync('tuid', tuid);
				}
			}

			this.setData({
				system: app.globalData.system,
				siteroot: app.globalData.siteroot.replace('/web.php', ''),
				page_title: app.globalData.page_title
			});
      this.changeLang()
      console.log('knowledgeBaseCheckData:', this.userCache.knowledgeBaseCheckData)
			app.globalData.util.checkLogin().then(() => {
				this.getHistoryMsg();
				this.checkModel4();
				setTimeout(() => {
					this.setData({
						pageIsLoad: true
					});
				}, 500)
			});
			setTimeout(() => {
				uni.setNavigationBarTitle({
					title: app.globalData.page_title
				})
			}, 300)

		},
		onShow() {
			uni.setNavigationBarTitle({
				title: app.globalData.page_title
			})
		},
		methods: {
			async sendText() {
				if (this.writing) {
					return
				}
        console.log(this.userCache)
        let to = []
        for (let item in this.userCache.lang) {
          if (this.userCache.lang[item] === this.langs[0]) {
            to.push('internetsearch')
          } else {
            for (let itemSon in this.userCache.knowledgeBaseCheckData) {
              to.push('repodb:' + this.userCache.knowledgeBaseCheckData[itemSon])
            }
          }
        }

				const message = this.trim(this.message)
				if (!message) {
					app.globalData.util.message('请输入你的问题')
					this.message = ''
					return
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
					message: message,
					model: this.model,
          tools: to
				}
				const response = await fetch(url, {
					method: 'POST',
					signal: fetchSignal,
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
									if (this.model == 'model4') {
										app.globalData.util.message(error, 'error', function() {
											uni.navigateTo({
												url: '/pages/pay/model4'
											})
										});
									} else {
										app.globalData.util.message(error, 'error', function() {
											uni.navigateTo({
												url: '/pages/pay/vip'
											})
										});
									}
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
				this.getBalanceModel4();
			},

			abortFetching() {
				console.log('abortFetching');
				fetchController.abort()
				setTimeout(() => {
					clearInterval(textOutputSi)
					textOutputSi = 0
					if (this.writingText) {
						this.lists.push({
							user: 'AI',
							message: this.writingText
						});
					}
					this.writing = false;
					this.writingText = '';

					setTimeout(() => {
						this.scrollToBottom();
					}, 200)
				}, 200)
			},

			sendConfirm() {
				setTimeout(() => {
					this.sendText()
				}, 50)
			},

      showInput() {
        this.inputShow = !this.inputShow
        setTimeout(() => {
          this.scrollBottom()
        }, 300)
      },
      dialogInputConfirm(val) {
        if (val){
          console.log('knowledgeBase', this.knowledgeBase)
          this.userCache.knowledgeBaseCheckData = val
          this.cache()
          this.changeLang()
        }
      },
      cache: function (){
        console.log('cache:', this.userCache)
        uni.setStorage({
          key: 'UserCache',
          data: this.userCache
        })
      },
      changeLang(lang) {
        if (lang) {
          if (this.langs[1] === lang) {
            app.globalData.util.request({
              url: '/Retrieval/getAllLibs',
              method: 'GET'
            })
            .then((res) => {
              this.setData({
                knowledgeBase: res.data
              })
              this.$refs.inputDialog.open()
            })
            return
          }
          const index = this.userCache.lang.indexOf(lang)
          if ( index > -1) {
            this.userCache.lang.splice(index, 1)
          } else {
            this.userCache.lang.push(lang)
          }
          this.inputShow = true
        } else {
          const lan = this.langs[1]
          const index = this.userCache.lang.indexOf(lan)
          if (this.userCache.knowledgeBaseCheckData.length != 0){
            if (index === -1){
              console.log('添加了')
              this.userCache.lang.push(lan)
            }
          } else if (index > -1) {
            this.userCache.lang.splice(index, 1)
          }
        }
        this.cache()
      },
			getHistoryMsg() {
				app.globalData.util
					.request({
						url: '/chat/getHistoryMsg',
						data: {
							model: this.model
						}
					})
					.then((res) => {
						this.setData({
							lists: res.data.list
						});
						setTimeout(() => {
							this.scrollToBottom();
						}, 300)
					});
			},

			checkModel4() {
				app.globalData.util
					.request({
						url: '/h5/hasModel4',
						data: {
							from: 'h5'
						},
						loading: false
					})
					.then((res) => {
						this.setData({
							hasModel4: res.data.hasModel4,
							model4Name: res.data.model4Name
						})
					});
			},

			getBalanceModel4() {
				app.globalData.util
					.request({
						url: '/h5/getBalance',
						loading: false
					})
					.then((res) => {
						this.setData({
							balance_model4: res.data.balance_model4
						})
					});
			},

			toModel4Pay() {
				wx.navigateTo({
					url: '/pages/pay/model4'
				})
			},

			scrollToBottom() {
				setTimeout(() => {
					let query = uni.createSelectorQuery().in(this);
					query.select('.list').boundingClientRect((res) => {
						if (res) {
							this.setData({
								scrollTop: parseInt(res.height)
							});
						}
					});
					query.exec((res) => {});
				}, 200);
			},

			quickMessage(text) {
				this.message = text
			},

			toPay() {
				uni.navigateTo({
					url: '/pages/pay/pay'
				});
			},

			getWxappInfo() {
				const _this = this;
				return new Promise(function(resolve, reject) {
					app.globalData.util
						.request({
							url: '/wxapp/getWxappInfo',
							loading: false
						})
						.then((res) => {
							// 设置页面标题
							let page_title = res.data.page_title;
							if (page_title) {
								uni.setNavigationBarTitle({
									title: page_title
								});
							}
							if (res.data.index_type == 'chat' && res.data.outtype && res.data.outtype ==
								'stream') {
								_this.setData({
									outtype: res.data.outtype
								});
								_this.socketConnect();
							}

							// 设置欢迎语
							let welcome = res.data.welcome;
							if (welcome) {
								let lists = _this.lists;
								if (lists.length == 0) {
									lists.push({
										user: 'AI',
										message: [welcome]
									});
									_this.setData({
										lists: lists
									});
								}
							}
							_this.setData({
								shareTitle: res.data.share_title,
								shareImage: res.data.share_image,
								is_check: res.data.is_check,
								index_type: res.data.index_type,
								content: res.data.content ? JSON.parse(res.data.content) : ''
							});
							resolve();
						});
				});
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
				return str.replace(/(^\s*)|(\s*$)/g, '');
			},

			switchModel(name) {
				if (this.model == name) {
					this.scrollTop += 1;
					return;
				}
				if (this.writing) {
					app.globalData.util.message('输出中，请稍等')
					return;
				}
				if (name == 'model4') {
					var _this = this
					uni.showModal({
						title: '提示',
						content: this.model4Name + '功能更强大，但成本很高，所以单独计费',
						confirmText: '我已知晓',
						showCancel: false,
						success: function(res) {
							_this.setData({
								model: name,
								page: 1
							})
							_this.getHistoryMsg()
							_this.getBalanceModel4()
						}

					})
				} else {
					this.setData({
						model: name,
						page: 1
					})
					this.getHistoryMsg()
					this.getBalanceModel4()
				}
			}
		}
	};
</script>
<style>
	page {
		background: #f7f7f7;
	}

	.tab-model {
		position: fixed;
		left: 218rpx;
		top: 40rpx;
		width: 314rpx;
		height: 80rpx;
		border-radius: 20rpx;
		background: #f6fafc;
		padding: 10rpx;
		box-sizing: border-box;
		z-index: 99;
		display: flex;
		justify-content: space-between;
		align-items: center;
		box-shadow: 0 0 20rpx rgb(0, 0, 0, 0.1);
	}

	.tab-model .tab-item {
		width: 140rpx;
		height: 60rpx;
		line-height: 60rpx;
		text-align: center;
		border-radius: 20rpx;
		border: 1px solid #ebf7f5;
		color: #666;
		font-size: 30rpx;
	}

	.tab-model .tab-item:hover,
	.tab-model .active {
		background: #fff;
		color: #666;
		border: 1px solid #f7f7f7;
	}

	.gold .tab-model .active {
		border: 1px solid #f5ad0c;
		color: #f5ad0c;
	}

	.gold .balance4 {
		line-height: 48rpx;
		margin-top: 10rpx;
		text-align: center;
		font-size: 24rpx;
		color: #999;
	}

	.gold .balance4 text {
		color: #10a37f;
		margin: 0 10rpx;
	}

	.gold .box-input {
		padding-bottom: 20rpx;
	}

	.gold .box-input .input {
		background: #fffef8;
		border: 1px solid #ffa41a;
		border-radius: 20rpx;
	}

	.gold .box-input .input textarea {
		min-height: 80rpx;
	}


  .box-input {
    width: 100%;
    height: auto;
    padding: 0 30rpx;
    border-top: 1px solid #d8d8e2;
    background: #f6fafc;
    box-sizing: border-box;
    position: absolute;
    left: 0;
    bottom: 0;
    z-index: 2;
    transition: all 0.3s;
  }

  .box-input .tools {
    width: 100%;
    height: 72rpx;
    margin-bottom: 10rpx;
    box-sizing: border-box;
    margin-top: 30rpx;
  }

  .box-input .tools .item {
    width: auto;
    height: 56rpx;
    line-height: 56rpx;
    background: #fff;
    font-size: 24rpx;
    border-radius: 10rpx;
    border: 1px solid #ddd;
    color: #444;
    float: left;
    margin-right: 20rpx;
    position: relative;
    overflow: visible;
    padding: 0 20rpx;
  }

  .box-input .tools .item .ic_sj {
    width: 24rpx;
    height: 12rpx;
    position: absolute;
    left: 50%;
    margin-left: -12rpx;
    bottom: -12rpx;
    display: none;
  }

  .box-input .tools .item.active {
    border-color: #04BABE;
  }

  .box-input .tools .item.active .ic_sj {
    display: block;
  }

  .box-input .tools .item:active {
    background-color: #fafafa;
  }

  .box-input .tools .close {
    float: right;
    margin-right: 0;
    background: none;
    border: none;
    transform: rotate(180deg);
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.5s;
  }

  .box-input .input {
    width: 100%;
    position: relative;
    box-sizing: border-box;
    background: #fff;
    border: 1px solid #ddd;
    border-radius: 10rpx;
    overflow: hidden;
    transition: all 1s;
    margin-bottom: 40rpx;
  }

  .box-input .input textarea {
    width: 100%;
    height: 240rpx;
    min-height: 120rpx;
    max-height: 600rpx;
    padding: 20rpx 10rpx 20rpx 20rpx;
    border-radius: 10rpx;
    line-height: 40rpx;
    box-sizing: border-box;
    outline: none;
    border: none;
    resize: none;
    overflow: auto;
  }

  .box-input .input .btn-send {
    position: absolute;
    right: 0;
    bottom: 0;
    width: 80rpx;
    height: 80rpx;
    padding: 0;
    border: none;
    border-radius: 10rpx;
    background: none;
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 9;
    background:#fff;
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
		/*width: 100%;*/
		/*height: 100%;*/
		/*top: 0;*/
		/*bottom: 132rpx;*/
		/*left: 0;*/
		/*box-sizing: border-box;*/
		/*overflow: hidden;*/

    width: 100%;
    box-sizing: border-box;
    overflow: hidden;
    overflow-y: scroll;
    position: absolute;
    left: 0;
    right: 0;
    top: 0;
    bottom: 316px;
    background: #fff;
    z-index: 1;
    transition: all 0.3s;
	}

	.list {
		width: 100%;
		height: auto;
	}

	.message {
		display: flex;
		justify-content: flex-start;
		padding: 40rpx 40rpx;
		border-top: 2rpx solid #eee;
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
