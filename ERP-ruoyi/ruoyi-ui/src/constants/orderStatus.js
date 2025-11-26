/**
 * 订单状态常量
 */
export const OrderStatus = {
  CANCELLED: '-1',    // 取消订单
  PENDING_PAYMENT: '0',  // 待付款
  PENDING_SHIPMENT: '1',  // 待配货
  PARTIAL_SHIPPED: '2',  // 部分发货
  FULLY_SHIPPED: '3',    // 全部发货
  REFUNDED: '5'         // 已退款
}

/**
 * 订单状态映射
 */
export const OrderStatusMap = {
  [OrderStatus.CANCELLED]: '取消订单',
  [OrderStatus.PENDING_PAYMENT]: '待付款',
  [OrderStatus.PENDING_SHIPMENT]: '待配货',
  [OrderStatus.PARTIAL_SHIPPED]: '部分发货',
  [OrderStatus.FULLY_SHIPPED]: '全部发货',
  [OrderStatus.REFUNDED]: '已退款'
}

/**
 * 订单状态标签类型映射
 */
export const OrderStatusTypeMap = {
  [OrderStatus.CANCELLED]: 'info',
  [OrderStatus.PENDING_PAYMENT]: 'warning',
  [OrderStatus.PENDING_SHIPMENT]: 'primary',
  [OrderStatus.PARTIAL_SHIPPED]: 'success',
  [OrderStatus.FULLY_SHIPPED]: 'success',
  [OrderStatus.REFUNDED]: 'danger'
}

/**
 * 获取订单状态文本
 * @param status 订单状态码
 * @returns 状态文本
 */
export function getOrderStatusText(status) {
  return OrderStatusMap[status] || '未知状态'
}

/**
 * 获取订单状态标签类型
 * @param status 订单状态码
 * @returns 标签类型
 */
export function getOrderStatusType(status) {
  return OrderStatusTypeMap[status] || ''
}

/**
 * 判断是否可以发货
 * @param status 订单状态码
 * @returns 是否可以发货
 */
export function canShipOrder(status) {
  return status === OrderStatus.PENDING_SHIPMENT
}

/**
 * 判断是否已发货
 * @param status 订单状态码
 * @returns 是否已发货
 */
export function isOrderShipped(status) {
  return status === OrderStatus.PARTIAL_SHIPPED || status === OrderStatus.FULLY_SHIPPED
}

/**
 * 判断是否已取消
 * @param status 订单状态码
 * @returns 是否已取消
 */
export function isOrderCancelled(status) {
  return status === OrderStatus.CANCELLED
}

/**
 * 判断是否已退款
 * @param status 订单状态码
 * @returns 是否已退款
 */
export function isOrderRefunded(status) {
  return status === OrderStatus.REFUNDED
}