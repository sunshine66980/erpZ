/**
 * SKU生成工具函数
 * 基于产品类型、类目、分类自动生成唯一SKU
 */

// 产品类型映射
export const PRODUCT_TYPE_MAP = {
  1: 'N',  // 普通
  2: 'C',  // 组合
  3: 'P'   // 生产
}

// 产品类目映射
export const CATEGORY_MAP = {
  1: 'GA',  // 游戏
  2: '3C',  // 3C类
  3: 'BB',  // 母婴
  4: 'AP',  // 汽配
  5: 'OS',  // 户外运动
  6: 'TO',  // 玩具
  7: 'HO'   // 家居
}

// 产品分类映射
export const CLASSIFICATION_MAP = {
  1: 'FP',   // 成品(外采)
  2: 'IP',   // 成品(内部生产)
  3: 'HS',   // 半成品(可单售)
  4: 'HC',   // 半成品(需组合)
  5: 'MM',   // 物料(来料生产)
  6: 'MP',   // 物料(包装物料)
  7: 'PB',   // 包装辅料(彩盒)
  8: 'CB',   // 包装辅料(外箱)
  9: 'TA',   // 包装辅料(胶布)
  10: 'TL',  // 包装辅料(标签纸)
  11: 'OA'   // 包装辅料(其他辅料)
}

// SKU生成函数
export function generateSkuFormat(productType, categoryId, classificationId, sequence) {
  const typeCode = PRODUCT_TYPE_MAP[productType]
  const categoryCode = CATEGORY_MAP[categoryId]
  const classificationCode = CLASSIFICATION_MAP[classificationId]
  
  if (!typeCode || !categoryCode || !classificationCode) {
    return null
  }
  
  const sequenceStr = sequence.toString().padStart(4, '0')
  return `${typeCode}-${categoryCode}-${classificationCode}-${sequenceStr}`
}

// 验证SKU格式
export function validateSkuFormat(sku) {
  const pattern = /^[A-Z]-[A-Z0-9]{2}-[A-Z]{2}-\d{4}$/
  return pattern.test(sku)
}

// 解析SKU获取信息（用于显示）
export function parseSku(sku) {
  if (!validateSkuFormat(sku)) {
    return null
  }
  
  const [typeCode, categoryCode, classificationCode, sequence] = sku.split('-')
  
  // 反向映射
  const reverseTypeMap = Object.fromEntries(
    Object.entries(PRODUCT_TYPE_MAP).map(([key, value]) => [value, key])
  )
  const reverseCategoryMap = Object.fromEntries(
    Object.entries(CATEGORY_MAP).map(([key, value]) => [value, key])
  )
  const reverseClassificationMap = Object.fromEntries(
    Object.entries(CLASSIFICATION_MAP).map(([key, value]) => [value, key])
  )
  
  return {
    productType: parseInt(reverseTypeMap[typeCode]),
    categoryId: parseInt(reverseCategoryMap[categoryCode]),
    classificationId: parseInt(reverseClassificationMap[classificationCode]),
    sequence: parseInt(sequence),
    productTypeName: getProductTypeName(reverseTypeMap[typeCode]),
    categoryName: getCategoryName(reverseCategoryMap[categoryCode]),
    classificationName: getClassificationName(reverseClassificationMap[classificationCode])
  }
}

// 获取产品类型名称
export function getProductTypeName(typeId) {
  const typeNames = {
    1: '普通',
    2: '组合',
    3: '生产'
  }
  return typeNames[typeId] || ''
}

// 获取类目名称
export function getCategoryName(categoryId) {
  const categoryNames = {
    1: '游戏',
    2: '3C类',
    3: '母婴',
    4: '汽配',
    5: '户外运动',
    6: '玩具',
    7: '家居'
  }
  return categoryNames[categoryId] || ''
}

// 获取分类名称
export function getClassificationName(classificationId) {
  const classificationNames = {
    1: '成品(外采)',
    2: '成品(内部生产)',
    3: '半成品(可单售)',
    4: '半成品(需组合)',
    5: '物料(来料生产)',
    6: '物料(包装物料)',
    7: '包装辅料(彩盒)',
    8: '包装辅料(外箱)',
    9: '包装辅料(胶布)',
    10: '包装辅料(标签纸)',
    11: '包装辅料(其他辅料)'
  }
  return classificationNames[classificationId] || ''
}

// 检查是否可以生成SKU（所有必需字段是否已选择）
export function canGenerateSku(productType, categoryId, classificationId) {
  return productType && categoryId && classificationId
}

// 生成本地SKU（用于前端即时显示，需后端验证）
export function generateLocalSku(productType, categoryId, classificationId, sequence = 1) {
  return generateSkuFormat(productType, categoryId, classificationId, sequence)
}