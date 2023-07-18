import request from '@/utils/request'

export function getChatHistoryMsg(data) {
  return request({
    url: '/chat/getHistoryMsg',
    method: 'post',
    data
  })
}
