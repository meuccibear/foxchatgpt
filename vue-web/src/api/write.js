import request from '@/utils/request'

export function getAllPrompt(data) {
  return request({
    url: '/write/getAllPrompt',
    method: 'post',
    data
  })
}
export function votePrompt(data) {
  return request({
    url: '/write/votePrompt',
    method: 'post',
    data
  })
}
export function getPrompt(data) {
  return request({
    url: '/write/getPrompt',
    method: 'post',
    data
  })
}
export function getWriteHistoryMsg(data) {
  return request({
    url: '/write/getHistoryMsg',
    method: 'post',
    data
  })
}
