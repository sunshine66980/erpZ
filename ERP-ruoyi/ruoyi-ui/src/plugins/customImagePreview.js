import Vue from 'vue'
import CustomImagePreview from '@/components/CustomImagePreview'

const CustomImagePreviewPlugin = {
  install(Vue) {
    // 创建一个实例用于全局访问
    const customImagePreview = new Vue({
      render: h => h(CustomImagePreview)
    })
    
    // 挂载到body
    const component = customImagePreview.$mount()
    document.body.appendChild(component.$el)
    
    // 添加到Vue原型
    Vue.prototype.$customImagePreview = {
      show(options) {
        component.$children[0].show(options)
      }
    }
  }
}

export default CustomImagePreviewPlugin