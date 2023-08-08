<template>
  <div :class="{mobile: isMobile, opened: treeOpened, closed: !treeOpened}">
    <div class="fox-tree">
      <div class="box-search">
        <el-input
          v-model="keyword"
          placeholder="输入关键词"
          prefix-icon="el-icon-search"
          clearable
          @input="doSearch"
        />
      </div>
      <el-tree
        ref="tree"
        :data="articleTree"
        :props="treeProps"
        :highlight-current="true"
        :default-expand-all="true"
        :render-content="renderTreeContent"
        :filter-node-method="treeFilter"
        node-key="key"
        empty-text="无数据"
        @node-click="handleNodeClick"
      />
    </div>
    <div class="book-main">
      <div class="content" v-html="article.content" />
    </div>
  </div>
</template>

<script>
import { getArticleTree, getArticle } from '@/api/article'

export default {
  data() {
    return {
      articleId: 0,
      type: '',
      isMobile: true,
      treeOpened: true,
      articleTree: [],
      article: {},
      treeProps: {
        children: 'son',
        label: 'title'
      },
      keyword: ''
    }
  },
  watch: {
    '$route.query': function(query) {
      if (query.type) {
        this.type = query.type
        if (this.type === 'help' && query.id) {
          this.articleId = query.id
        }
        this.getArticle()
      }
    }
  },
  created() {
    const query = this.$route.query
    if (query.type) {
      this.type = query.type
      if (this.type === 'help') {
        if (query.id) {
          this.articleId = query.id
        } else {
          return
        }
      }
      this.getArticle()
    }
  },
  mounted() {
    this.isMobile = document.body.clientWidth < 980
    if (this.isMobile) {
      setTimeout(() => {
        this.treeOpened = false
      }, 800)
    }
    this.getArticleTree()
    window.onresize = () => {
      if (document.body.clientWidth < 980) {
        this.isMobile = true
        this.treeOpened = false
      } else {
        this.isMobile = false
        this.treeOpened = true
      }
    }
  },
  beforeDestroy() {
    window.onresize = null
  },
  methods: {
    getArticleTree() {
      getArticleTree().then(res => {
        this.articleTree = res.data
        setTimeout(() => {
          if (this.type) {
            var key = this.type
            if (this.type === 'help') {
              if (!this.articleId && this.articleTree[0]['son'].length > 0) {
                this.articleId = this.articleTree[0]['son'][0]['id']
                this.getArticle()
              }
              key += this.articleId
            }
            this.$refs.tree.setCurrentKey(key)
          }
        }, 10)
      })
    },
    renderTreeContent(h, { node, data, store }) {
      if (data.isFolder) {
        return (
          <span style='font-weight:bold;'>{data.title}</span>
        )
      } else {
        return (
          <span class='has-icon'>
            <i class='el-icon-document'></i>
            <span>{data.title}</span>
          </span>
        )
      }
    },
    handleNodeClick(node) {
      if (node.isFolder) {
        return
      }
      if (this.type === 'help') {
        if (this.articleId === node.id) {
          return
        }
      } else {
        if (this.type === node.type) {
          return
        }
      }
      this.$router.push({
        name: 'Doc',
        query: {
          type: node.type,
          id: node.id
        }
      })
      this.treeOpened = false
    },
    getArticle() {
      if (this.type || this.articleId) {
        getArticle({ type: this.type, id: this.articleId }).then(res => {
          this.article = res.data
        })
      } else {
        this.article = {
          title: '',
          content: ''
        }
      }
    },
    treeFilter(keyword, node) {
      if (!keyword) {
        return true
      }
      return node.title.indexOf(keyword) !== -1
    },
    doSearch() {
      this.$refs.tree.filter(this.keyword)
    },
    treeToggle() {
      this.treeOpened = !this.treeOpened
    }
  }
}
</script>
<style>
body {
  background-color: #f7f7f8;
}
</style>
<style lang="scss" scoped>
  .fox-tree {
    width: 300px;
    background: #f7f7f8;
    position: absolute;
    left: 15px;
    top: 15px;
    bottom: 0;
    padding: 15px;
    padding-bottom: 50px;
    overflow-x: hidden;
    overflow-y: auto;
    transition: left 0.28s;
    z-index: 100;

    &::-webkit-scrollbar {
      width: 0 !important;
      height: 6px !important;
    }
    &::-webkit-scrollbar-thumb {
      background: rgba(143, 146, 153, 0.3);
      border-radius: 3px;
    }
    &::v-deep {
      .el-tree {
        font-size: 15px;
        color: #212121;
        background: none;
      }
      .el-tree-node {
        white-space: inherit;
        word-break: break-word;
      }
      .el-tree-node__content {
        height: auto;
        min-height: 32px;
        padding: 10px 0;
        font-family: Chinese Quote,-apple-system,BlinkMacSystemFont,Segoe UI,Roboto,PingFang SC,Hiragino Sans GB,Microsoft YaHei,Helvetica Neue,Helvetica,Arial,sans-serif;
        position: relative;

        .has-icon {
          display: flex;
          align-items: flex-start;
          line-height: 22px;

          i {
            line-height: 22px;
            margin-right: 5px;
          }
        }
      }
      .is-current {
        .el-tree-node__content {
          background: #eff0f0;
          //color: #fff;
        }
      }
    }

    .box-search {
      margin-bottom: 15px;
    }
  }

  .tree-toggle {
    position: absolute;
    left: 300px;
    top: 50%;
    margin-top: -30px;
    width: 16px;
    height: 48px;
    line-height: 48px;
    text-align: center;
    background: #e7e8e9;
    color: #999;
    font-size: 16px;
    z-index: 999;
    transition: left 0.26s;
    display: none;

    &.opened {
      left: 300px;
    }
    &.closed {
      left: 0;
    }
  }

  .book-main {
    background: #fff;
    border-radius: 10px;
    position: absolute;
    left: 330px;
    right: 15px;
    top: 15px;
    bottom: 0;
    overflow-x: hidden;
    overflow-y: auto;
    transition: left 0.28s;
    &::-webkit-scrollbar {
      width: 6px !important;
      height: 6px !important;
    }
    &::-webkit-scrollbar-thumb {
      background: rgba(143, 146, 153, 0.3);
      border-radius: 3px;
    }
    .content {
      word-break: break-all;
      padding: 20px 30px;
      font-size: 18px;
      line-height: 1.5;
      max-width: 950px;
      margin: 0 auto;
      font-family: 微软雅黑;
    }
  }

  .mobile {
    .book-tree {
      left: 0;
      top: 50px;
    }
    .book-main {
      left: 0;
      right: 0;
      top: 50px;
    }
    &.opened {
      .book-tree {
        left: 0;
      }
    }
    &.closed {
      .book-tree {
        left: -320px;
      }
    }
    .tree-toggle {
      display: block;
    }
  }
</style>
