import {Loading} from "element-ui";

const loading = {
  loadingInstance: null
}
loading.show = (title) => {
  //console.log('show')
  if(!loading.loadingInstance){
    loading.loadingInstance = Loading.service({
      fullscreen: true,
      lock: true,
      text: title ? title : '加载中',
      background: 'rgba(0,0,0,0.3)',
      customClass: 'my-loading'
    })
  }
}

loading.hide = ()=>{
  //console.log('hide')
  if (loading.loadingInstance) {
    loading.loadingInstance.close()
    loading.loadingInstance = null
  }
}

export default loading
