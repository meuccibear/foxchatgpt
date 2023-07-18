import request from '@/utils/request'

export function getAllRoles(data) {
  return request({
    url: '/cosplay/getAllRoles',
    method: 'post',
    data
  })
}
export function getRole(data) {
  return request({
    url: '/cosplay/getRole',
    method: 'post',
    data
  })
}
export function getCosplayHistoryMsg(data) {
  return request({
    url: '/cosplay/getHistoryMsg',
    method: 'post',
    data
  })
}
