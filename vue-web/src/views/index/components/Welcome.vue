<template>
  <div class="welcome">
    <template v-if="tutorial">
      <div class="title">{{ pageTitle }}</div>
      <div class="tips-list">
        <div class="column">
          <div class="h-item">
            <svg-icon class="icon" icon-class="ic_write" style="font-size: 24px;" />
            <div class="tit">AI 创作</div>
          </div>
          <ul>
            <li @click="quickMessage('写一首赞美祖国的诗')">写一首赞美祖国的诗 →</li>
            <li @click="quickMessage('写一篇科幻小说')">写一篇科幻小说 →</li>
            <li @click="quickMessage('安排一场发布会流程')">安排一场发布会流程 →</li>
          </ul>
        </div>
        <div class="column">
          <div class="h-item">
            <svg-icon class="icon" icon-class="ic_linggan" style="font-size: 24px;" />
            <div class="tit">有趣的提问</div>
          </div>
          <ul>
            <li @click="quickMessage('有哪些有趣的科学实验')">有哪些有趣的科学实验 →</li>
            <li @click="quickMessage('问一个AI也答不出的问题')">问一个AI也答不出的问题 →</li>
            <li @click="quickMessage('AI会替代人类工作吗')">AI会替代人类工作吗 →</li>
          </ul>
        </div>
        <div class="column">
          <div class="h-item">
            <svg-icon class="icon" icon-class="ic_baike" style="font-size: 24px;" />
            <div class="tit">AI 百科</div>
          </div>
          <ul>
            <li @click="quickMessage('用简单的术语来解释人工智能')">简单解释一下人工智能 →</li>
            <li @click="quickMessage('红烧牛肉的做法')">红烧牛肉的做法 →</li>
            <li @click="quickMessage('请介绍一下百度文心')">请介绍一下百度文心 →</li>
          </ul>
        </div>
      </div>
    </template>

    <div v-else>
      <div class="title">知识库指南</div>
      <div class="tips-list">
        <div class="page-container">
<!--          <div class="h-item">-->
<!--            <svg-icon class="icon" icon-class="ic_write" style="font-size: 24px;" />-->
<!--            <div class="tit">AI 创作</div>-->
<!--          </div>-->
<!--          <ul>-->
<!--            <li>写一首赞美祖国的诗 →</li>-->
<!--            <li>写一篇科幻小说 →</li>-->
<!--            <li>安排一场发布会流程 →</li>-->
<!--          </ul>-->
          <p>1. 新建自己的知识库</p>
          <p>2. 上传自己知识库的文件 【支持的文件格式：.docx, .txt, .pdf, .doc】</p>
          <p>3. 编辑知识库，查看已上传的文件是否【解析成功<i class="el-icon-success" style="color: rgb(4, 186, 190);" />】或者【正在解析<i class="el-icon-loading" style="color: rgb(4, 186, 190);" />】</p>
          <p>4.进入【对话】，点击 消息框上方【知识库】选择知识库</p>
          <p>快点体验知识库吧～</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    pageTitle: {
      type: String,
      default: ''
    },
    tutorial: {
      type: Boolean,
      default: true
    }
  },
  computed: {
    message() {
      const text = this.text.replace(/(^\s*)|(\s*$)/g, '')
      return mdi.render(text)
    }
  },
  methods: {
    quickMessage(text) {
      this.$emit('use', text)
    }
  }
}
</script>
<style lang="scss" scoped>
.welcome {
  width: 768px;
  max-width: 100%;
  height: 400px;
  margin: 0 auto;
  margin-top: 80px;

  .title {
    font-size: 40px;
    color: #404040;
    text-align: center;
    line-height: 48px;
    margin: 30px 0;
    font-weight: bold;
    letter-spacing: 2px;
    transition: color 0.1s ease-in-out;
  }

  .tips-list {
    display: flex;
    justify-content: space-around;
    padding: 10px;

    .page-container {
      width: 70%;
      padding: 20px 10px 0 10px;

      p {
        font-size: 14px;
        color: #5e6d82;
        line-height: 1.5rem;
      }
    }

    .column {
      width: 33%;
      padding: 0 10px;
      text-align: center;

      .h-item {
        color: #666;
        transition: color 0.1s ease-in-out;
      }

      ul, li {
        list-style: none;
        margin: 0;
        padding: 0;
      }

      .h-item {
        margin-bottom: 20px;

        img {
          width: 24px;
          height: 24px;
        }

        .tit {
          font-size: 16px;
          line-height: 44px;
        }
      }

      li {
        background: #f7f7f8;
        border-radius: 4px;
        margin-bottom: 15px;
        padding: 12px 15px;
        font-size: 13px;
        color: #444;
        line-height: 18px;
        cursor: default;
        transition: background 0.1s ease-in-out;

        &:active {
          background: #e5e7eb;
          color: #222;
        }
      }
    }
  }
}
</style>
