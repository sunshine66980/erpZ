import request from '@/utils/request'

// 查询产品管理列表
export function listProduct(query) {
  return request({
    url: '/product/product/list',
    method: 'get',
    params: query
  })
}

// 查询产品管理详细
export function getProduct(productId) {
  return request({
    url: '/product/product/' + productId,
    method: 'get'
  })
}

// 新增产品管理
export function addProduct(data) {
  return request({
    url: '/product/product',
    method: 'post',
    data: data
  })
}

// 修改产品管理
export function updateProduct(data) {
  return request({
    url: '/product/product',
    method: 'put',
    data: data
  })
}

// 删除产品管理
export function delProduct(productId) {
  return request({
    url: '/product/product/' + productId,
    method: 'delete'
  })
}

// 生成产品SKU
export function generateSku(data) {
  return request({
    url: '/product/product/generateSku',
    method: 'post',
    data: data
  })
}

// 检查SKU是否重复
export function checkSkuDuplicate(productCode, productId) {
  return request({
    url: '/product/product/checkSkuDuplicate',
    method: 'get',
    params: {
      productCode: productCode,
      productId: productId || ''
    }
  })
}

// 获取下一个SKU序号
export function getNextSequence(productType, categoryId, classificationId) {
  return request({
    url: '/product/product/getNextSequence',
    method: 'get',
    params: {
      productType: productType,
      categoryId: categoryId,
      classificationId: classificationId
    }
  })
}
