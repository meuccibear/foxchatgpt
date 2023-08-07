var util = {};
util.request = function (option) {
    var app = getApp();
    var option = option ? option : {};

    // 组装url
    var url = option.url;
    if (url.indexOf('http://') == -1 && url.indexOf('https://') == -1) {
        url = app.globalData.siteroot + option.url;
    }
    if (!url) {
        return false;
    }

    // 是否显示loading
    option.loading = typeof option.loading != 'undefined' ? option.loading : true;
    // console.log(option.url, option.loading)
    if (option.loading) {
        uni.showNavigationBarLoading();
        uni.showLoading({
            title: '加载中'
        });
    }
    var data = option.data ? option.data : {};
    return new Promise(function (resolve, reject) {
        uni.request({
            url: url,
            data: data,
            method: option.method ? option.method : 'POST',
            dataType: 'json',
            header: {
                'Content-Type': 'application/x-www-form-urlencoded',
                'X-Site': uni.getStorageSync('sitecode')
            },
            timeout: option.timeout ? option.timeout : 60000,
            success: function (res) {
                if (res.statusCode != 200) {
					// util.message('网络错误1' + url);
                    reject(res);
                    return;
                }
                if (res.data.errno > 0) {
                    if (res.data.errno === 403) {
                        // 需要登录后才可以操作
                        if (option.url == '/user/checkLogin') {
                            reject(res);
                        } if (option.url != '/h5/getShareInfo') {
                            // 登录
                            util.login();
                        }
                        return;
                    } else {
                        if (res.data.message) {
                            util.message(res.data.message, 'error');
                        }
                        reject(res.data);
                    }
                } else {
                    resolve(res.data);
                }
            },
            fail: function (err) {
                // util.message('网络错误2' + url);
                reject(err);
            },
            complete: function (res) {
                if (option.loading) {
                    uni.hideLoading();
                    uni.hideNavigationBarLoading();
                }
            }
        });
    });
};
util.upload = function (option = null) {
    var app = getApp();
    var option = option ? option : {};

    // 组装url
    var url = option.url;
    if (url.indexOf('http://') == -1 && url.indexOf('https://') == -1) {
        url = app.globalData.siteroot + option.url;
    }
    if (!url) {
        return false;
    }

    // 是否显示loading
    option.loading = typeof option.loading != 'undefined' ? option.loading : true;
    if (option.loading) {
        uni.showNavigationBarLoading();
        uni.showLoading({
            title: '上传中'
        });
    }
    var data = option.data ? option.data : {};
    return new Promise(function (resolve, reject) {
        uni.uploadFile({
            url: url,
			fileType: 'image',
            filePath: option.filePath,
            name: option.name ? option.name : 'image',
            formData: option.data ? option.data : {},
            header: {
                'X-Site': uni.getStorageSync('sitecode')
            },
            success: function (response) {
                const res = JSON.parse(response.data);
                if (res.errno > 0) {
                    if (res.errno === 403) {
                        // 需要登录后才可以操作
                        util.login();
                    } else {
                        if (res.message && res.message.indexOf('请充值') === -1) {
                            util.message(res.message, 'error');
                        }
                        reject(res);
                    }
                } else {
                    resolve(res);
                }
            },
            fail: function (err) {
                util.message('网络错误', 'error');
                reject(err);
            },
            complete: function (res) {
                if (option.loading) {
                    uni.hideLoading();
                    uni.hideNavigationBarLoading();
                }
            }
        });
    });
};
util.login = function () {
    var sitecode = uni.getStorageSync('sitecode')
    var tuid = uni.getStorageSync('tuid')
	var url = '/web.php/login/h5?sitecode=' + sitecode + '&tuid=' + tuid + '&from=' + encodeURIComponent(window.location.href)
	window.location.href = url
};

/**
 * 检查是否登录
 */
util.checkLogin = function () {
    return new Promise(function (resolve, reject) {
        util.request({
            url: '/user/checkLogin',
            loading: false
        })
		.then((res) => {
			resolve(res);
		})
		.catch((res) => {
		   util.login()
		});
    });
};
/*
 * 提示信息
 * type 为 success, error 当为 success,  时，为toast方式，否则为模态框的方式
 */
util.message = function (title, type = 'none', callback = null) {
    if (!title) {
        return true;
    }
    if (type == 'success') {
        uni.showToast({
            title: title,
            icon: 'success',
            duration: 2000,
            mask: false,
            complete: function () {
                if (callback && typeof callback == 'function') {
                    setTimeout(function () {
                        callback();
                    }, 1800);
                }
            }
        });
    } else if (type == 'none') {
        uni.showToast({
            title: title,
            icon: 'none',
            duration: 2000,
            mask: false,
            complete: function () {
                if (callback && typeof callback == 'function') {
                    setTimeout(function () {
                        callback();
                    }, 1800);
                }
            }
        });
    } else if (type == 'error') {
        uni.showModal({
            title: '系统提示',
            content: title,
            showCancel: false,
            complete: function () {
                if (callback && typeof callback == 'function') {
                    callback();
                }
            }
        });
    }
};
util.queryToArr = function (str) {
    let result = [];
    let kv = [];
    let paramArr = str.split('&');
    for (let i in paramArr) {
        kv = paramArr[i].split('=');
        result[kv[0]] = kv[1];
    }
    return result;
};
module.exports = util;
