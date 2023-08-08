<template>
  <div class="copyright">
    <div v-if="copyright || icp || gongan">
      <a @click="toDoc('legal')">{{ copyright }}</a>
      <a v-if="gongan" :href="'http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=' + gongan.replace(/[^\d]/g, '')" target="_blank" style="margin-left: 15px;">
        <img src="@/assets/gongan.png" style="margin-right: 3px; position: relative; top: 2px; height: 14px;">{{ gongan }}
      </a>
      <a v-if="icp" href="https://beian.miit.gov.cn/" target="_blank" style="margin-left: 15px;">{{ icp }}</a>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
export default {
  computed: {
    ...mapGetters([
      'copyright',
      'icp',
      'gongan'
    ])
  },
  methods: {
    toDoc(type) {
      const routeData = this.$router.resolve({ name: 'Doc', query: { type: type }})
      window.open(routeData.href, '_blank')
    }
  }
}
</script>
<style lang="scss" scoped>
.float {
  position: fixed;
  right: 0;
  top: 50%;
  margin-top: -80px;
  width: 44px;
  height: 160px;
  border-top-left-radius: 10px;
  border-bottom-left-radius: 10px;
  border: 1px solid #ddd;
  border-right:none;
  overflow: hidden;
  padding: 20px 10px;
  font-size: 16px;
  z-index: 9;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: background 0.1s ease-in-out, color 0.1s ease-in-out;
  .icon {
    font-size: 24px;
    margin-bottom: 5px;
  }
  span {
    line-height: 20px;
    text-align: center;
  }
}
</style>
