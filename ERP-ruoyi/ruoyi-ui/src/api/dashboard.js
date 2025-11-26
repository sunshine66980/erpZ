import request from '@/utils/request'

// 获取仪表板统计数据
export function getDashboardStats() {
  return request({
    url: '/dashboard/stats',
    method: 'get'
  })
}

// 获取设计师统计
export function getDesignerStats() {
  return request({
    url: '/design/profile/stats',
    method: 'get'
  })
}

// 获取作品统计
export function getWorkStats() {
  return request({
    url: '/design/work/stats',
    method: 'get'
  })
}

// 获取主题统计
export function getTopicStats() {
  return request({
    url: '/design/topics/stats',
    method: 'get'
  })
}