import request from '@/utils/request'

export function getLoginQrcode(data) {
  return request({
    url: '/login/getQrcode',
    method: 'post',
    data
  })
}

export function loginCheck(data) {
  return request({
    url: '/login/check',
    method: 'post',
    data,
    hideLoading: true
  })
}
