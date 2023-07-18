<template>
    <view style="height: 100%">
        <web-view :src="url"></web-view>
    </view>
</template>

<script>
export default {
    data() {
        return {
            url: ''
        };
    },
    onLoad: function (options) {
        let url = options.url;
        url = decodeURIComponent(url);
        this.setData({
            url: url
        });
    },
    methods: {}
};
</script>
<style></style>
