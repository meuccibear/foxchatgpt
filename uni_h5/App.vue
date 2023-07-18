<script>
	import wx from "weixin-js-sdk";
	import util from "./utils/util.js"
	import siteinfo from "./siteinfo.js"
	export default {
		data() {
			return {};
		},
		onLaunch: function() {
			this.globalData.siteroot = siteinfo.host + '/web.php';
			const system = uni.getSystemInfoSync().system.toLowerCase();
			if (system.indexOf('android') > -1) {
				this.globalData.system = 'android';
			} else if (system.indexOf('ios') > -1) {
				this.globalData.system = 'ios';
			} else {
				this.globalData.system = 'other';
			}
			
			// 站点sitecode
			var search = window.location.search
			if(search && search.indexOf('?') != -1) {
				var sitecode = '';
				if(search.length == 5) {
					sitecode = search.substr(1, 4)
				} else if (search.length > 5) {
					var char = search.charAt(5)
					if(char == '&' || char == '#' || char == '=' || char == '/') {
						sitecode = search.substr(1, 4)
					}
				}
				if (sitecode) {
					uni.setStorageSync('sitecode', sitecode)
				}
			}
			

			// 初始化微信jssdk
			util.request({
					url: '/h5/getShareInfo',
					data: {
						url: window.location.href
					}
				})
				.then((res) => {
					const jssdkConfig = res.data.jssdk_config;
					const page_title = res.data.page_title;
					const share_title = res.data.share_title;
					const share_link = res.data.share_link;
					const share_desc = res.data.share_desc;
					const share_image = res.data.share_image;
					this.globalData.page_title = page_title;
					wx.config(jssdkConfig);
					wx.ready(function() {
						wx.updateAppMessageShareData({
							title: share_title,
							desc: share_desc,
							link: share_link,
							imgUrl: share_image,
							success: function() {
								// 设置成功
							}
						})
						wx.updateTimelineShareData({
							title: share_title,
							link: share_link,
							imgUrl: share_image,
							success: function() {
								// 设置成功
							}
						})
					});

					this.globalData.jssdk = wx
				});
		},
		globalData: {
			siteroot: '',
			system: '',
			page_title: '',
			util: util,
			jssdk: null
		}
	};
</script>
<style>
	button::after {
		display: none;
	}
</style>