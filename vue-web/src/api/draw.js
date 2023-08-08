import request from '@/utils/request'

export function submitTask(data) {
  return request({
    url: '/draw/draw',
    method: 'post',
    data
  })
}

export function mjCtrl(data) {
  return request({
    url: '/draw/mjCtrl',
    method: 'post',
    data
  })
}

export function getDrawSetting(data) {
  return request({
    url: '/draw/getDrawSetting',
    method: 'post',
    data
  })
}

export function getHistoryMsg(data) {
  return request({
    url: '/draw/getHistoryMsg',
    method: 'post',
    data
  })
}

export function getDrawResult(data) {
  return request({
    url: '/draw/getDrawResult',
    method: 'post',
    hideLoading: true,
    data
  })
}
