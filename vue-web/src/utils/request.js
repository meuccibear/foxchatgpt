import axios from 'axios'
import { Message } from 'element-ui'
import loading from '@/utils/loading'
// import store from '@/store'
import { getToken, getSiteCode } from '@/utils/auth'

const service = axios.create({
  baseURL: process.env.VUE_APP_BASE_API, // url = base url + request url
  timeout: 120000 // request timeout
})


// request interceptor
service.interceptors.request.use(
  config => {
    const token = getToken()
    if (token) {
      config.headers['X-Token'] = token
    }
    const sitecode = getSiteCode()
    if (sitecode) {
      config.headers['X-Site'] = sitecode
    }

    if (!config.headers['hideLoading'] && !config.hideLoading) {
      loading.show()
    }

    return config
  },
  error => {
    // do something with request error
    console.log(error) // for debug
    return Promise.reject(error)
  }
)

// response interceptor
service.interceptors.response.use(
  /**
   * If you want to get http information such as headers or status
   * Please return  response => response
   */

  /**
   * Determine the request status by custom code
   * Here is just an example
   * You can also judge the status by HTTP Status Code
   */
  response => {
    loading.hide()
    const res = response.data

    // if the custom code is not 20000, it is judged as an error.
    if (res.errno) {
      if (res.errno !== 403) {
        Message({
          message: res.message || res.msg || 'Error',
          type: 'error',
          duration: 3 * 1000
        })
      }
      return Promise.reject(res)
    } else {
      return res
    }
  },
  error => {
    loading.hide()
    Message({
      message: error.message,
      type: 'error',
      duration: 5 * 1000
    })
    return Promise.reject(error)
  }
)

export default service
