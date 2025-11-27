import request from '@/utils/request'

// 查询产品图片列表
export function listImages(query) {
  return request({
    url: '/product/images/list',
    method: 'get',
    params: query
  })
}

// 查询产品图片详细
export function getImages(imageId) {
  return request({
    url: '/product/images/' + imageId,
    method: 'get'
  })
}

// 新增产品图片
export function addImages(data) {
  return request({
    url: '/product/images',
    method: 'post',
    data: data
  })
}

// 修改产品图片
export function updateImages(data) {
  return request({
    url: '/product/images',
    method: 'put',
    data: data
  })
}

// 删除产品图片
export function delImages(imageId) {
  return request({
    url: '/product/images/' + imageId,
    method: 'delete'
  })
}

// 生成3D模型
export function generate3DModel(file) {
  const formData = new FormData()
  formData.append('file', file)
  return request({
    url: '/product/images/generate3DModel',
    method: 'post',
    data: formData,
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })
}
