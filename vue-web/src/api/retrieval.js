import request from '@/utils/request'

export function getFileListForLib(params) {
  return request({
    url: '/Retrieval/getFileListForLib',
    method: 'get',
    params
  })
}

export function getLibs() {
  return request({
    url: '/Retrieval/getAllLibs',
    method: 'get'
  })
}

export function getLib(data) {
  return request({
    url: '/Retrieval/getLibs',
    method: 'post',
    data
  })
}

export function saveLib(data) {
  return request({
    url: '/Retrieval/' + ( 'repo_id' in data ? 'updateLib':'addLib'),
    method: 'post',
    data
  })
}

export function delLib(data) {
  return request({
    url: '/Retrieval/delLib',
    method: 'post',
    data
  })
}
