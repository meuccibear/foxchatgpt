import { login, logout, getInfo, getSystemInfo } from '@/api/user'
import { getToken, setToken, removeToken, getTheme, setTheme } from '@/utils/auth'
import { resetRouter } from '@/router'

const getDefaultState = () => {
  return {
    token: getToken(),
    user_id: 0,
    avatar: '',
    nickname: '',
    vip_expire_time: '',
    balance: 0,
    balance_gpt4: 0,
    balance_draw: 0,
    hasModel4: 0,
    model4Name: 'GPT-4',
    logo: '',
    logo_mini: '',
    page_title: '',
    copyright: '',
    copyright_link: '',
    icp: '',
    gongan: '',
    theme: getTheme() || 'light'
  }
}

const state = getDefaultState()

const mutations = {
  RESET_STATE: (state) => {
    Object.assign(state, getDefaultState())
  },
  SET_TOKEN: (state, token) => {
    state.token = token
  },
  SET_USER_ID: (state, user_id) => {
    state.user_id = user_id
  },
  SET_NICKNAME: (state, nickname) => {
    state.nickname = nickname
  },
  SET_AVATAR: (state, avatar) => {
    state.avatar = avatar
  },
  SET_VIP_EXPIRE_TIME: (state, vip_expire_time) => {
    state.vip_expire_time = vip_expire_time
  },
  SET_BALANCE: (state, balance) => {
    state.balance = balance
  },
  SET_BALANCE_GPT4: (state, balance_gpt4) => {
    state.balance_gpt4 = balance_gpt4
  },
  SET_BALANCE_DRAW: (state, balance_draw) => {
    state.balance_draw = balance_draw
  },
  SET_HAS_MODEL4: (state, hasModel4) => {
    state.hasModel4 = hasModel4
  },
  SET_MODEL4_NAME: (state, model4Name) => {
    state.model4Name = model4Name
  },
  SET_LOGO: (state, logo) => {
    state.logo = logo
  },
  SET_LOGO_MINI: (state, logo_mini) => {
    state.logo_mini = logo_mini
  },
  SET_PAGE_TITLE: (state, page_title) => {
    state.page_title = page_title
  },
  SET_COPYRIGHT: (state, copyright) => {
    state.copyright = copyright
  },
  SET_COPYRIGHT_LINK: (state, copyright_link) => {
    state.copyright_link = copyright_link
  },
  SET_ICP: (state, icp) => {
    state.icp = icp
  },
  SET_GONGAN: (state, gongan) => {
    state.gongan = gongan
  },
  SET_THEME: (state, theme) => {
    state.theme = theme
    setTheme(theme)
  }
}

const actions = {
  // user login
  login({ commit }, userInfo) {
    const { username, password } = userInfo
    return new Promise((resolve, reject) => {
      login({ username: username.trim(), password: password }).then(response => {
        if (response.errno === 0) {
          const { data } = response
          commit('SET_TOKEN', data.token)
          setToken(data.token)
        }
        resolve(response)
      }).catch(error => {
        console.log('error', error)
        reject(error)
      })
    })
  },

  // get user info
  getInfo({ commit, state }) {
    return new Promise((resolve, reject) => {
      getInfo().then(response => {
        const { data } = response

        if (!data) {
          return reject('登录过期，请重新登录')
        }

        const { user_id, nickname, avatar, vip_expire_time, balance, balance_gpt4, balance_draw, hasModel4, model4Name, theme } = data

        commit('SET_USER_ID', user_id)
        commit('SET_NICKNAME', nickname)
        commit('SET_AVATAR', avatar)
        commit('SET_VIP_EXPIRE_TIME', vip_expire_time)
        commit('SET_BALANCE', balance)
        commit('SET_BALANCE_GPT4', balance_gpt4)
        commit('SET_BALANCE_DRAW', balance_draw)
        commit('SET_HAS_MODEL4', hasModel4)
        commit('SET_MODEL4_NAME', model4Name)
        if (theme) {
          commit('SET_THEME', theme)
        }

        resolve(data)
      }).catch(error => {
        reject(error)
      })
    })
  },

  setTheme({ commit }, theme) {
    if (theme) {
      commit('SET_THEME', theme)
    }
  },

  // get user info
  getSystemInfo({ commit, state }) {
    return new Promise((resolve, reject) => {
      getSystemInfo().then(response => {
        const { data } = response

        if (!data) {
          return reject('登录过期，请重新登录')
        }

        const { logo, page_title, copyright, copyright_link, icp, gongan } = data

        commit('SET_LOGO', logo)
        commit('SET_LOGO_MINI', logo)
        commit('SET_PAGE_TITLE', page_title)
        commit('SET_COPYRIGHT', copyright)
        commit('SET_COPYRIGHT_LINK', copyright_link)
        commit('SET_ICP', icp)
        commit('SET_GONGAN', gongan)

        if (page_title) {
          document.title = page_title
        }

        resolve(data)
      }).catch(error => {
        if (error.errno === 403) {
          window.location.href = '/web/404'
          return
        }

        reject(error)
      })
    })
  },

  // user logout
  logout({ commit, state }) {
    return new Promise((resolve, reject) => {
      logout().then(() => {
        removeToken() // must remove  token  first
        resetRouter()
        commit('RESET_STATE')
        resolve()
      }).catch(error => {
        reject(error)
      })
    })
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}

