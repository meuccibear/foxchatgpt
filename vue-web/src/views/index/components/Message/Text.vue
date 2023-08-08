<template>
  <div v-html="message" />
</template>

<script>
import MarkdownIt from 'markdown-it'
import mdKatex from '@traptitech/markdown-it-katex'
import mila from 'markdown-it-link-attributes'
import hljs from 'highlight.js'

const mdi = new MarkdownIt({
  linkify: true,
  highlight(code, language) {
    code = code.replace('![cursor](/static/img/cursor.gif)', '')
    const validLang = !!(language && hljs.getLanguage(language))
    if (validLang) {
      const lang = language ?? ''
      return highlightBlock(hljs.highlight(code, { language: lang }).value, lang)
    }
    code = code.replaceAll('<', '&lt;')
    code = code.replaceAll('>', '&gt;')
    return code
  }
})

mdi.use(mila, { attrs: { target: '_blank', rel: 'noopener' }})
mdi.use(mdKatex, { blockClass: 'katexmath-block rounded-md p-[10px]', errorColor: ' #cc0000' })

function highlightBlock(str, lang) {
  return `<pre class="code-block-wrapper"><div class="code-block-header"><span class="code-block-header__lang">${lang}</span></div><code class="hljs code-block-body ${lang}">${str}</code></pre>`
}

export default {
  props: {
    text: {
      type: String,
      default: ''
    },
    writing: {
      type: Boolean,
      default: false
    }
  },
  computed: {
    message() {
      var text = this.text.replace(/(^\s*)|(\s*$)/g, '')
      if (this.writing) {
        text += '![cursor](/static/img/cursor.gif)'
      }
      return mdi.render(text)
    }
  },
  methods: {
    trim(str) {
      return str.replace(/(^\s*)|(\s*$)/g, '')
    }
  }
}
</script>
<style lang="scss" scoped>
  .text {
    color: #343541;
    line-height: 26px;
    font-size: 16px;
    word-break: break-all;
    padding: 4px 0;
    span {
      display: inline;
    }
  }
</style>
