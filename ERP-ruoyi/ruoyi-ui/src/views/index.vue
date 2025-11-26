<template>
  <div class="app-container home">
    <!-- 页面头部 -->
    <div class="dashboard-header">
      <div class="header-content">
        <div class="header-info">
          <h1>ERP 概览</h1>
          <p>欢迎使用企业管理系统</p>
        </div>
        <div class="header-actions">
          <el-button type="primary" icon="el-icon-refresh" @click="loadDashboardStats">刷新数据</el-button>
        </div>
      </div>
    </div>

    <!-- 数据统计卡片 -->
    <el-row :gutter="20" class="card-row">
      <el-col :xs="24" :sm="12" :md="6" :lg="6">
        <div class="card">
          <div class="title">库存 SKU 总数</div>
          <div class="value">{{ stats.totalSkus || '—' }}</div>
          <div class="small muted">活跃 SKU 数量</div>
        </div>
      </el-col>
      <el-col :xs="24" :sm="12" :md="6" :lg="6">
        <div class="card">
          <div class="title">待收采购单</div>
          <div class="value">{{ stats.pendingPurchaseOrders || '—' }}</div>
          <div class="small muted">正在运输/待入库</div>
        </div>
      </el-col>
      <el-col :xs="24" :sm="12" :md="6" :lg="6">
        <div class="card">
          <div class="title">今日销售单</div>
          <div class="value">{{ stats.todaySalesOrders || '—' }}</div>
          <div class="small muted">已发货 / 待发货</div>
        </div>
      </el-col>
      <el-col :xs="24" :sm="12" :md="6" :lg="6">
        <div class="card">
          <div class="title">库存总件数</div>
          <div class="value">{{ stats.totalQuantity || '—' }}</div>
          <div class="small muted">单位：件</div>
        </div>
      </el-col>
    </el-row>

    <!-- 主要内容区域 -->
    <div class="content">
      <!-- 近期采购 -->
      <div class="panel" style="flex: 2">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
          <div style="font-weight: 600; font-size: 16px;">近期采购</div>
          <div class="small muted">采购单仅作示例</div>
        </div>
        <el-table :data="recentPurchaseOrders" style="width: 100%" size="small">
          <el-table-column prop="purchaseOrderNo" label="采购单号" width="120" />
          <el-table-column prop="supplier" label="供应商" width="120" />
          <el-table-column prop="itemCount" label="项数" width="80" />
          <el-table-column prop="totalAmount" label="总额" width="100" />
          <el-table-column prop="status" label="状态" width="100">
            <template slot-scope="scope">
              <el-tag :type="getStatusType(scope.row.status)" size="small">
                {{ scope.row.status }}
              </el-tag>
            </template>
          </el-table-column>
        </el-table>
      </div>
      
      <!-- 库存预警和快速操作 -->
      <div class="panel" style="flex: 1">
        <div style="font-weight: 600; margin-bottom: 12px; font-size: 16px;">库存预警</div>
        <div id="lowStockList">
          <div v-for="(item, index) in lowStockItems" :key="index" class="low-stock-item">
            <div style="display: flex; justify-content: space-between; align-items: center;">
              <div>
                <div style="font-weight: 500;">{{ item.sku }}</div>
                <div class="small muted">{{ item.name }}</div>
              </div>
              <div style="color: #ff4d4f; font-weight: 500;">{{ item.quantity }} 件</div>
            </div>
          </div>
          <div v-if="lowStockItems.length === 0" class="small muted">暂无库存预警</div>
        </div>
        
        <el-divider />
        
        <div style="font-weight: 600; margin-bottom: 12px; font-size: 16px;">快速操作</div>
        <div style="display: flex; flex-direction: column; gap: 8px;">
          <el-button type="info" plain size="small" icon="el-icon-download" @click="exportReport">
            导出库存报表
          </el-button>
          <el-button type="primary" plain size="small" icon="el-icon-plus" @click="navigateToModule('purchase')">
            新建采购单
          </el-button>
          <el-button type="success" plain size="small" icon="el-icon-sell" @click="navigateToModule('sales')">
            新建销售单
          </el-button>
        </div>
      </div>
    </div>

    <!-- 财务概览 -->
    <div class="content" style="margin-top: 16px;">
      <div class="panel">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
          <div style="font-weight: 600; font-size: 16px;">财务概览</div>
          <div class="small muted">单位：万元</div>
        </div>
        <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 40px; align-items: center;">
          <div style="text-align: center;">
            <div class="progress-ring" :style="`--progress: ${financialData.payableProgress}deg`">
              {{ financialData.payablePercent }}%
            </div>
            <div class="small muted" style="margin-top: 8px;">应付账款</div>
          </div>
          <div style="text-align: center;">
            <div class="progress-ring" :style="`--progress: ${financialData.receivableProgress}deg`">
              {{ financialData.receivablePercent }}%
            </div>
            <div class="small muted" style="margin-top: 8px;">应收账款</div>
          </div>
          <div style="text-align: center;">
            <div class="progress-ring" :style="`--progress: ${financialData.profitProgress}deg`">
              {{ financialData.profitPercent }}%
            </div>
            <div class="small muted" style="margin-top: 8px;">毛利率</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { getDesignerStats, getWorkStats, getTopicStats } from '@/api/dashboard'

export default {
  name: "Index",
  data() {
    return {
      version: "3.9.0",
      stats: {
        totalSkus: 1245,
        pendingPurchaseOrders: 12,
        todaySalesOrders: 8,
        totalQuantity: 34567
      },
      recentPurchaseOrders: [
        { purchaseOrderNo: 'PO001', supplier: '供应商A', itemCount: 5, totalAmount: '15000', status: '待收货' },
        { purchaseOrderNo: 'PO002', supplier: '供应商B', itemCount: 3, totalAmount: '8000', status: '运输中' },
        { purchaseOrderNo: 'PO003', supplier: '供应商C', itemCount: 8, totalAmount: '22000', status: '已入库' },
        { purchaseOrderNo: 'PO004', supplier: '供应商D', itemCount: 2, totalAmount: '4500', status: '待收货' }
      ],
      lowStockItems: [
        { sku: 'SKU001', name: '产品A', quantity: 5 },
        { sku: 'SKU002', name: '产品B', quantity: 3 },
        { sku: 'SKU003', name: '产品C', quantity: 8 }
      ],
      financialData: {
        payablePercent: 35,
        receivablePercent: 28,
        profitPercent: 42,
        payableProgress: 126,
        receivableProgress: 101,
        profitProgress: 151
      },
      moduleRoutes: {
        purchase: '/purchase',
        sales: '/sales',
        inventory: '/inventory'
      }
    }
  },
  created() {
    this.loadStats()
  },
  methods: {
    navigateToModule(module, action = 'list') {
      const directPaths = {
        purchase: '/purchase',
        sales: '/sales', 
        inventory: '/inventory'
      }

      const targetPath = directPaths[module]

      if (!targetPath) {
        this.$message.error('模块不存在')
        return
      }

      this.$router.push(targetPath).catch(err => {
        console.error('导航失败:', err)
        this.$notify({
          title: '导航失败',
          message: `无法访问 ${targetPath}，可能需要在数据库中配置菜单权限。`,
          type: 'warning',
          duration: 8000
        })
      })
    },

    getStatusType(status) {
      const statusMap = {
        '待收货': 'warning',
        '运输中': 'info', 
        '已入库': 'success',
        '已发货': 'success',
        '待发货': 'warning'
      }
      return statusMap[status] || 'info'
    },

    loadStats() {
      this.loadDashboardStats()
    },

    loadDashboardStats() {
      // 模拟数据加载
      console.log('加载仪表板数据...')
    },

    exportReport() {
      this.$message.success('报表导出功能开发中...')
    },

    goTarget(href) {
      window.open(href, "_blank")
    }
  }
}
</script>

<style scoped lang="scss">
.home {
  .dashboard-header {
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
    padding: 20px;

    .header-content {
      display: flex;
      justify-content: space-between;
      align-items: center;

      .header-info {
        h1 {
          color: #333;
          font-size: 1.8em;
          margin-bottom: 5px;
          font-weight: 600;
        }

        p {
          color: #666;
          margin: 0;
          font-size: 14px;
        }
      }

      .header-actions {
        display: flex;
        gap: 10px;
      }
    }
  }

  .card-row {
    margin-bottom: 20px;

    .card {
      background: white;
      padding: 16px;
      border-radius: 10px;
      box-shadow: 0 2px 6px rgba(15, 23, 42, 0.04);
      transition: all 0.3s ease;

      &:hover {
        transform: translateY(-3px);
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
      }

      .title {
        font-size: 15px;
        color: #6c757d;
        margin-bottom: 8px;
        font-weight: 500;
      }

      .value {
        font-size: 26px;
        font-weight: 600;
        color: #333;
      }

      .small {
        font-size: 14px;
      }

      .muted {
        color: #6c757d;
      }
    }
  }

  .content {
    display: flex;
    gap: 16px;
    margin-bottom: 20px;

    .panel {
      background: white;
      padding: 16px;
      border-radius: 10px;
      min-height: 400px;
      box-shadow: 0 2px 6px rgba(15, 23, 42, 0.04);

      .low-stock-item {
        padding: 8px 0;
        border-bottom: 1px solid #f0f0f0;

        &:last-child {
          border-bottom: none;
        }
      }
    }
  }

  .progress-ring {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    background: conic-gradient(#4facfe 0deg, #4facfe var(--progress), #f0f0f0 var(--progress));
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 600;
    font-size: 16px;
    color: #333;
    position: relative;

    &::before {
      content: '';
      position: absolute;
      width: 70px;
      height: 70px;
      background: white;
      border-radius: 50%;
    }
  }
}

// 响应式设计
@media (max-width: 768px) {
  .home {
    .dashboard-header {
      .header-content {
        flex-direction: column;
        text-align: center;
        gap: 15px;

        .header-actions {
          justify-content: center;
        }
      }
    }

    .content {
      flex-direction: column;
    }

    .progress-ring {
      width: 60px;
      height: 60px;

      &::before {
        width: 50px;
        height: 50px;
      }
    }
  }
}
</style>