import request from '@/utils/request'

export function getList(data) {
  return request({
    url: '/order/getList',
    method: 'post',
    data
  })
}
export function getExportList(data) {
  return request({
    url: '/order/getExportList',
    method: 'post',
    data
  })
}
export function getOrderDetail(data) {
  return request({
    url: '/order/getOrderDetail',
    method: 'post',
    data
  })
}
export function getTongji(data) {
  return request({
    url: '/order/getTongji',
    method: 'post',
    data
  })
}
export function refund(data) {
  return request({
    url: '/order/refund',
    method: 'post',
    data
  })
}
