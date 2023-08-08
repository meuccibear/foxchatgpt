import request from '@/utils/request'

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
  // console.log('data:', data)
  // console.log('repo_id' in data ? 1: 0)
  return request({
    url: '/Retrieval/' + ( 'repo_id' in data ? 'updateLib':'addLib'),
    method: 'post',
    data
  })
}

export function delLib(data) {
  return request({
    url: '/group/delGroup',
    method: 'post',
    data
  })
}
