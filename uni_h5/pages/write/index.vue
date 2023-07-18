<template>
    <view class="page">
        <scroll-view :scroll-x="true" class="tab-nav" v-if="topicList && topicList.length > 0">
            <view class="tab-list" :style="'width: ' + tabWidth + 'rpx;'">
                <view :class="'tab ' + (topic_id == 'vote' ? 'active' : '')" @tap="switchTopic" data-topic="vote">收藏</view>
                <view :class="'tab ' + (topic_id == 'all' ? 'active' : '')" @tap="switchTopic" data-topic="all">全部</view>
                <view :class="'tab ' + (topic_id == item.id ? 'active' : '')" @tap="switchTopic" :data-topic="item.id" v-for="(item, index) in topicList" :key="index">
                    {{ item.title }}
                </view>
            </view>
        </scroll-view>

        <view class="prompt-list" v-if="promptList && promptList.length > 0">
            <view class="prompt-item" v-for="(item, index) in promptList" :key="index">
                <view @tap="toWriteChat" :data-id="item.id">
                    <view class="title">{{ item.title }}</view>
                    <view class="desc">{{ item.desc }}</view>
                </view>

                <view class="ops">
                    <view class="op-item">
                        <image class="icon" src="/static/images/write/ic_views.png"></image>
                        {{ item.views }}
                    </view>
                    <view class="op-item">
                        <image class="icon" src="/static/images/write/ic_usages.png"></image>
                        {{ item.usages }}
                    </view>
                    <view class="op-item" @tap="doVote" :data-id="item.id">
                        <image v-if="item.isVote == 1" class="icon" src="/static/images/write/ic_vote_active.png"></image>
                        <image v-else class="icon" src="/static/images/write/ic_vote.png"></image>
                    </view>
                </view>
            </view>
            <view style="clear: both"></view>
        </view>

        <view class="empty" v-else>
            <image src="/static/images/nodata.png"></image>
        </view>

        <view v-if="promptList && promptCount > pagesize" style="padding: 30rpx 0 30rpx 0; width: 100%">
            <pages :count="promptCount" :pagesize="pagesize" :page="page" @change="pageChange"></pages>
        </view>
    </view>
</template>

<script>
import pages from '@/components/pages/index';
const app = getApp();
export default {
    components: {
        pages
    },
    data() {
        return {
            topicList: [],
			tabWidth: 160,
            promptList: [],
            promptCount: 0,
            page: 1,
            pagesize: 10,
            scrollTop: 0,
            shareTitle: '',
            shareImage: '',
            timeline_share_id: 0,
            topic_id: 'all',
            system: ''
        };
    },
    onLoad(options) {
        this.setData({
            system: app.globalData.system
        });
        app.globalData.util.checkLogin().then(() => {
            this.getTopicList();
            this.getPrompts();
        });
    },
    methods: {
        switchTopic: function (e) {
            let topic_id = e.currentTarget.dataset.topic;
            this.setData({
                topic_id: topic_id
            });
            if (topic_id == 'vote') {
                this.setData({
                    page: 1,
                    promptList: []
                });
                this.getVotePrompts();
            } else {
                this.setData({
                    page: 1
                });
                this.getPrompts();
            }
        },

        getTopicList() {
            app.globalData.util.request({
				url: '/write/getTopicList'
			})
			.then((res) => {
				this.setData({
					topicList: res.data
				});
				
				this.calcTabWidth()
			});
        },
		
		calcTabWidth() {
			const topicList = this.topicList
			var tabWidth = 160, len = 0;
			topicList.forEach((item) => {
				len = this.strLen(item.title)
				tabWidth += len * 20
			})
			this.setData({
				tabWidth: tabWidth
			})
		},
		strLen(str) {
			var len = 0;
			for (var i = 0; i < str.length; i++) {
				if (str.charCodeAt(i) >= 0 && str.charCodeAt(i) <= 128){
					len += 1
				} else {
					len += 2
				}
			}
			return len
		},

        getPrompts() {
            const topic_id = this.topic_id;
            const page = this.page;
            const pagesize = this.pagesize;
            app.globalData.util
                .request({
                    url: '/write/getPrompts',
                    data: {
                        topic_id: topic_id,
                        page: page,
                        pagesize: pagesize
                    }
                })
                .then((res) => {
                    this.setData({
                        promptList: res.data.list,
                        promptCount: res.data.count
                    });
                    this.scrollToTop();
                });
        },

        getVotePrompts() {
            const page = this.page;
            const pagesize = this.pagesize;
            app.globalData.util
                .request({
                    url: '/write/getVotePrompts',
                    data: {
                        page: page,
                        pagesize: pagesize
                    }
                })
                .then((res) => {
                    this.setData({
                        promptList: res.data.list,
                        promptCount: res.data.count
                    });
                    this.scrollToTop();
                });
        },

        pageChange(e) {
            var page = e.detail;
            this.setData({
                page: page
            });
            if (this.topic_id == 'vote') {
                this.getVotePrompts();
            } else {
                this.getPrompts();
            }
        },

        doVote(e) {
            const prompt_id = e.currentTarget.dataset.id;
            app.globalData.util
                .request({
                    url: '/write/votePrompt',
                    data: {
                        prompt_id: prompt_id
                    }
                })
                .then((res) => {
                    app.globalData.util.message(res.message);
                    var promptList = this.promptList;
                    for (var i in promptList) {
                        if (promptList[i].id == prompt_id) {
                            if (promptList[i].isVote) {
                                promptList[i].isVote = 0;
                            } else {
                                promptList[i].isVote = 1;
                            }
                        }
                    }
                    this.setData({
                        promptList: promptList
                    });
                });
        },

        scrollToTop() {
            setTimeout(() => {
                this.setData({
                    scrollTop: 0
                });
            }, 100);
        },

        toWriteChat(e) {
            const id = e.currentTarget.dataset.id;
            uni.navigateTo({
                url: '/pages/write/chat?prompt_id=' + id
            });
        }
    }
};
</script>
<style>
page {
    background: #fff;
    padding-top: 88rpx;
	overflow-x: hidden;
}
.page {
	overflow-x: hidden;
}

::-webkit-scrollbar{
    width: 0;
    height: 0;
    color: transparent;
}

.tab-nav {
    position: fixed;
    top: 0;
    width: 100%;
    height: 88rpx;
    line-height: 88rpx;
    background-color: #f4fcfb;
    box-sizing: border-box;
    z-index: 99;
    border-top: 1rpx solid #eee;
    border-bottom: 1rpx solid #eee;
    overflow: hidden;
    overflow-x: auto;
}

.tab-list {
    width: auto;
    height: 100%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 20rpx;
}

.tab {
    font-size: 28rpx;
    color: #233445;
    height: 88rpx;
    line-height: 88rpx;
    text-align: center;
    padding: 0 6rpx;
    position: relative;
    box-sizing: border-box;
    border-bottom: 6rpx solid #fff;
}

.tab.active {
    color: #04babe;
    border-bottom: 6rpx solid #04babe;
}

.activitys {
    width: 100%;
    padding: 20rpx 0 0 20rpx;
    background-color: #f3f6f9;
}

.activitys .act-item {
    padding: 10rpx 20rpx;
    border: 1px solid #ccc;
    color: #666;
    margin: 0 20rpx 20rpx 0;
    float: left;
    display: block;
    border-radius: 10rpx;
    font-size: 24rpx;
}

.activitys .act-item.active {
    color: #04babe;
    border-color: #04babe;
}

.prompt-list {
    width: 100%;
    background-color: #fff;
    padding: 30rpx 0 0 30rpx;
}

.prompt-item {
    background: #f7f7f8;
    padding: 20rpx 30rpx;
    border-radius: 14rpx;
    margin: 0 20rpx 20rpx 0;
    float: left;
    width: 280rpx;
    font-family: '微软雅黑';
	height: 220rpx;
	overflow: hidden;
	position: relative;
}
.prompt-item:active {
    background: #f0f0f0;
}

.prompt-item .title {
    font-size: 28rpx;
    font-weight: bold;
    line-height: 44rpx;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 2;
    overflow: hidden;
}

.prompt-item .desc {
    font-size: 24rpx;
    color: #888;
    margin-top: 10rpx;
    line-height: 36rpx;
    height: 108rpx;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 3;
    overflow: hidden;
}

.prompt-item .ops {
    display: flex;
	align-items: center;
	justify-content: space-between;
	height: 64rpx;
	position: absolute;
	width: 100%;
	left: 0;
	bottom: 0;
	padding: 10rpx 30rpx;
	box-sizing: border-box;
	background: #f7f7f8;
}
.prompt-item .ops .op-item {
    display: flex;
    align-items: center;
    color: #8e8ea0;
    font-size: 24rpx;
}
.prompt-item .ops .op-item .icon {
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

.box-input {
    width: 100%;
    padding: 40rpx 0 0 0;
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
    box-shadow: 0 0 12rpx rgba(0, 0, 0, 0.15);
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

.box-msg-list {
    width: 100%;
    height: 100%;
    top: 188rpx;
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
    line-height: 60rpx;
    font-size: 32rpx;
    word-break: break-all;
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
}

.message .avatar image {
    width: 36rpx;
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
</style>
