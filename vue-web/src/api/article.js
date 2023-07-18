import request from '@/utils/request'

export function getArticleTree(data) {
  return request({
    url: '/article/getArticleTree',
    method: 'post',
    data
  })
}
export function getArticle(data) {
  return request({
    url: '/article/getArticle',
    method: 'post',
    data
  })
}
