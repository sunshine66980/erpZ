<template>
  <div class="app-container product-management">
    <!-- 页面头部 -->
    <div class="page-header">
      <div class="header-content">
        <div class="header-info">
          <h2>产品管理</h2>
          <p>管理所有产品信息，包括SKU、库存、销量等</p>
        </div>
        <div class="header-actions">
          <el-button type="primary" icon="el-icon-plus" @click="handleAdd">新增产品</el-button>
          <el-button icon="el-icon-refresh" @click="getList">刷新</el-button>
        </div>
      </div>
    </div>

    <!-- 筛选和工具栏 -->
    <div class="toolbar-section">
      <el-card shadow="never" class="filter-card">
        <div class="filter-row">
          <!-- 搜索框 -->
          <div class="filter-item search-item">
            <el-input
              v-model="queryParams.searchKeyword"
              placeholder="搜索SKU或产品名称"
              clearable
              size="small"
              prefix-icon="el-icon-search"
              @keyup.enter.native="handleQuery"
            />
          </div>
          
          <!-- 产品类型筛选 -->
          <div class="filter-item">
            <el-select v-model="queryParams.productType" placeholder="产品类型" clearable size="small">
              <el-option label="全部" value="" />
              <el-option label="普品" :value="1" />
              <el-option label="组合" :value="2" />
              <el-option label="生产" :value="3" />
            </el-select>
          </div>
          
          <!-- 产品类目筛选 -->
          <div class="filter-item">
            <el-select v-model="queryParams.categoryId" placeholder="产品类目" clearable size="small">
              <el-option label="全部类目" value="" />
              <el-option label="游戏" :value="1" />
              <el-option label="3C类" :value="2" />
              <el-option label="母婴" :value="3" />
              <el-option label="汽配" :value="4" />
              <el-option label="户外运动" :value="5" />
              <el-option label="玩具" :value="6" />
              <el-option label="家居" :value="7" />
            </el-select>
          </div>
          
          <!-- 产品分类筛选 -->
          <div class="filter-item">
            <el-select v-model="queryParams.classificationId" placeholder="产品分类" clearable size="small">
              <el-option label="全部分类" value="" />
              <el-option label="成品" :value="1" />
              <el-option label="半成品" :value="2" />
              <el-option label="物料" :value="3" />
              <el-option label="包装辅料" :value="4" />
            </el-select>
          </div>
          
          <!-- 查询按钮 -->
          <div class="filter-item">
            <el-button type="primary" icon="el-icon-search" size="small" @click="handleQuery">搜索</el-button>
            <el-button icon="el-icon-refresh" size="small" @click="resetQuery">重置</el-button>
          </div>
        </div>
        
        <!-- 类目标签 -->
        <div class="category-tags-container">
          <span 
            class="category-tag" 
            :class="{ active: queryParams.categoryId === '' }"
            @click="queryParams.categoryId = ''; handleQuery()"
            style="background: #8b5cf6;"
          >
            全类目
          </span>
          <span 
            class="category-tag" 
            :class="{ active: queryParams.categoryId === 1 }"
            @click="queryParams.categoryId = 1; handleQuery()"
            style="background: #ef4444;"
          >
            游戏
          </span>
          <span 
            class="category-tag" 
            :class="{ active: queryParams.categoryId === 2 }"
            @click="queryParams.categoryId = 2; handleQuery()"
            style="background: #3b82f6;"
          >
            3C类
          </span>
          <span 
            class="category-tag" 
            :class="{ active: queryParams.categoryId === 3 }"
            @click="queryParams.categoryId = 3; handleQuery()"
            style="background: #f59e0b;"
          >
            母婴
          </span>
          <span 
            class="category-tag" 
            :class="{ active: queryParams.categoryId === 4 }"
            @click="queryParams.categoryId = 4; handleQuery()"
            style="background: #10b981;"
          >
            汽配
          </span>
          <span 
            class="category-tag" 
            :class="{ active: queryParams.categoryId === 5 }"
            @click="queryParams.categoryId = 5; handleQuery()"
            style="background: #06b6d4;"
          >
            户外运动
          </span>
          <span 
            class="category-tag" 
            :class="{ active: queryParams.categoryId === 6 }"
            @click="queryParams.categoryId = 6; handleQuery()"
            style="background: #ec4899;"
          >
            玩具
          </span>
          <span 
            class="category-tag" 
            :class="{ active: queryParams.categoryId === 7 }"
            @click="queryParams.categoryId = 7; handleQuery()"
            style="background: #84cc16;"
          >
            家居
          </span>
        </div>
        
        <!-- 分类标签 -->
        <div class="category-tags-container">
          <span 
            class="classification-tag" 
            :class="{ active: queryParams.classificationId === '' }"
            @click="queryParams.classificationId = ''; handleQuery()"
            style="background: #6b7280;"
          >
            全部分类
          </span>
          <span 
            class="classification-tag" 
            :class="{ active: queryParams.classificationId === 1 }"
            @click="queryParams.classificationId = 1; handleQuery()"
            style="background: #059669;"
          >
            成品
          </span>
          <span 
            class="classification-tag" 
            :class="{ active: queryParams.classificationId === 2 }"
            @click="queryParams.classificationId = 2; handleQuery()"
            style="background: #dc2626;"
          >
            半成品
          </span>
          <span 
            class="classification-tag" 
            :class="{ active: queryParams.classificationId === 3 }"
            @click="queryParams.classificationId = 3; handleQuery()"
            style="background: #7c3aed;"
          >
            物料
          </span>
          <span 
            class="classification-tag" 
            :class="{ active: queryParams.classificationId === 4 }"
            @click="queryParams.classificationId = 4; handleQuery()"
            style="background: #ea580c;"
          >
            包装辅料
          </span>
        </div>
      </el-card>
    </div>

    <!-- 产品列表 -->
    <el-card shadow="never" class="table-card">
      <div class="table-header">
        <div class="table-title">
          <span>产品列表</span>
          <el-tag type="info" size="small" v-if="total > 0">共 {{ total }} 条记录</el-tag>
        </div>
        <div class="table-actions">
          <el-button
            size="mini"
            type="success"
            icon="el-icon-download"
            @click="handleExport"
            :loading="exportLoading"
          >
            导出
          </el-button>
        </div>
      </div>
      
      <el-table
        v-loading="loading"
        :data="productList"
        stripe
        border
        style="width: 100%"
        @sort-change="handleSortChange"
      >
        <el-table-column label="图片" align="center" width="80">
          <template slot-scope="scope">
            <div class="product-image" @click="handleDetail(scope.row)">
              <el-image
                :src="getProductImage(scope.row)"
                :preview-src-list="[getProductImage(scope.row)]"
                fit="cover"
                class="image-item"
              >
                <div slot="error" class="image-slot">
                  <i class="el-icon-picture-outline"></i>
                </div>
              </el-image>
            </div>
          </template>
        </el-table-column>
        
        <el-table-column label="SKU" prop="productCode" align="center" width="120" sortable="custom" />
        
        <el-table-column label="产品名称" prop="productName" min-width="150" show-overflow-tooltip />
        
        <el-table-column label="型号" prop="model" align="center" width="100" />
        
        <el-table-column label="类型" prop="productTypeName" align="center" width="80">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.productTypeName === '组合'" size="mini" type="warning">{{ scope.row.productTypeName }}</el-tag>
            <span v-else>{{ scope.row.productTypeName || '-' }}</span>
          </template>
        </el-table-column>
        
        <el-table-column label="类目" prop="categoryName" align="center" width="100" />
        
        <el-table-column label="分类" prop="classificationName" align="center" width="100">
          <template slot-scope="scope">
            <el-tag
              :type="getClassificationTagType(scope.row.classificationName)"
              size="mini"
            >
              {{ scope.row.classificationName }}
            </el-tag>
          </template>
        </el-table-column>
        
        <el-table-column label="库存" prop="stock" align="center" width="80" sortable="custom">
          <template slot-scope="scope">
            <span :class="getStockClass(scope.row.stock)">{{ scope.row.stock || 0 }}</span>
          </template>
        </el-table-column>
        
        <el-table-column label="交期(天)" prop="leadTime" align="center" width="80" />
        
        <el-table-column label="10天销量" prop="sales10days" align="center" width="100" sortable="custom">
          <template slot-scope="scope">
            <span :class="getSalesClass(scope.row.sales10days)">{{ scope.row.sales10days || 0 }}</span>
          </template>
        </el-table-column>
        
        <el-table-column label="30天销量" prop="sales30days" align="center" width="100" sortable="custom">
          <template slot-scope="scope">
            <span :class="getSalesClass(scope.row.sales30days)">{{ scope.row.sales30days || 0 }}</span>
          </template>
        </el-table-column>
        
        <el-table-column label="创建时间" prop="createTime" align="center" width="160" sortable="custom" />
        
        <el-table-column label="最后修改" prop="updateTime" align="center" width="160" sortable="custom" />
        
        <el-table-column label="操作" align="center" width="160" fixed="right">
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="text"
              icon="el-icon-view"
              @click="handleDetail(scope.row)"
            >
              详情
            </el-button>
            <el-button
              size="mini"
              type="text"
              icon="el-icon-edit"
              @click="handleUpdate(scope.row)"
            >
              修改
            </el-button>
            <el-button
              size="mini"
              type="text"
              icon="el-icon-shopping-cart-2"
              @click="handlePurchase(scope.row)"
            >
              采购
            </el-button>
            <el-button
              size="mini"
              type="text"
              icon="el-icon-delete"
              @click="handleDelete(scope.row)"
              class="delete-btn"
            >
              删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
      
      <!-- 分页 -->
      <pagination
        v-show="total > 0"
        :total="total"
        :page.sync="queryParams.pageNum"
        :limit.sync="queryParams.pageSize"
        @pagination="getList"
      />
    </el-card>
  </div>
</template>

<script>
import { listProduct, getProduct, delProduct, addProduct, updateProduct } from "@/api/product/product"

export default {
  name: "ProductManagement",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 导出遮罩层
      exportLoading: false,
      // 总条数
      total: 0,
      // 产品表格数据
      productList: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        searchKeyword: '',
        productCode: null,
        productName: null,
        productType: null,
        categoryName: null,
        classificationName: null,
        categoryId: null,
        classificationId: null,
        model: null,
        unit: null,
        purchasePrice: null,
        leadTime: null,
        weight: null,
        volume: null,
        length: null,
        width: null,
        height: null,
        standardBoxQty: null,
        sales30days: null,
        description: null,
        purchaseRemark: null,
        platform1688Url: null,
        qualityType: null,
        salesChannels: null,
        isActive: null,
      },
      // 排序参数
      sortParams: {
        sortField: null,
        sortOrder: null
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询产品列表 */
    getList() {
      this.loading = true
      
      // 构建查询参数
      const params = {
        ...this.queryParams,
        productCode: this.queryParams.searchKeyword,
        productName: this.queryParams.searchKeyword,
        ...this.sortParams
      }
      
      listProduct(params).then(response => {
        this.productList = response.rows || []
        this.total = response.total || 0
        this.loading = false
      }).catch(() => {
        this.$modal.msgError("获取产品列表失败")
        this.productList = []
        this.total = 0
        this.loading = false
      })
    },
    
        
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    
    /** 重置按钮操作 */
    resetQuery() {
      this.queryParams = {
        pageNum: 1,
        pageSize: 10,
        searchKeyword: '',
        productCode: null,
        productName: null,
        productType: null,
        categoryName: null,
        classificationName: null,
        categoryId: null,
        classificationId: null,
        model: null,
        unit: null,
        purchasePrice: null,
        leadTime: null,
        weight: null,
        volume: null,
        length: null,
        width: null,
        height: null,
        standardBoxQty: null,
        sales30days: null,
        description: null,
        purchaseRemark: null,
        platform1688Url: null,
        qualityType: null,
        salesChannels: null,
        isActive: null,
      }
      this.handleQuery()
    },
    
    /** 排序触发 */
    handleSortChange(column) {
      this.sortParams.sortField = column.prop
      this.sortParams.sortOrder = column.order === 'ascending' ? 'asc' : 'desc'
      this.getList()
    },
    
    /** 新增按钮操作 */
    handleAdd() {
      this.$router.push('/product/product/add')
    },
    
    /** 修改按钮操作 */
    handleUpdate(row) {
      const productId = row.productId
      this.$router.push(`/product/product/edit/${productId}`)
    },
    
    /** 详情按钮操作 */
    handleDetail(row) {
      this.$router.push(`/product/product/detail/${row.productId}`)
    },
    
    /** 采购按钮操作 */
    handlePurchase(row) {
      this.$message.success(`正在为产品 ${row.productCode} 创建采购单...`)
      // TODO: 跳转到采购页面或打开采购单创建模态框
      this.$router.push(`/purchase/create?sku=${row.productCode}`)
    },
    
    /** 删除按钮操作 */
    handleDelete(row) {
      const productIds = row.productId
      this.$modal.confirm('是否确认删除产品编号为"' + productIds + '"的数据项？').then(() => {
        return delProduct(productIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    
    /** 导出按钮操作 */
    handleExport() {
      this.exportLoading = true
      this.download('product/product/export', {
        ...this.queryParams
      }, `product_${new Date().getTime()}.xlsx`).then(response => {
        this.exportLoading = false
        this.$modal.msgSuccess("导出成功")
      }).catch(() => {
        this.exportLoading = false
      })
    },
    
    /** 获取产品图片 */
    getProductImage(row) {
      // 优先显示产品的主图
      if (row.primaryImage && row.primaryImage.imagePath) {
        return row.primaryImage.imagePath
      }
      
      // 如果没有主图，检查产品图片列表中的主图
      if (row.productImagesList && row.productImagesList.length > 0) {
        const primaryImage = row.productImagesList.find(img => img.isPrimary === '1')
        if (primaryImage && primaryImage.imagePath) {
          return primaryImage.imagePath
        }
        // 如果没有主图，显示第一张图片
        const firstImage = row.productImagesList[0]
        if (firstImage && firstImage.imagePath) {
          return firstImage.imagePath
        }
      }
      
      // 都没有的话，根据产品类目返回不同的默认图片
      const typeImages = {
        '游戏': '/images/game-product.jpg',
        '3C类': '/images/3c-product.jpg',
        '母婴': '/images/baby-product.jpg',
        '汽配': '/images/auto-product.jpg',
        '户外运动': '/images/sports-product.jpg',
        '玩具': '/images/toy-product.jpg',
        '家居': '/images/home-product.jpg'
      }
      return typeImages[row.categoryName] || '/images/default-product.jpg'
    },
    
    /** 获取分类标签类型 */
    getClassificationTagType(classification) {
      const typeMap = {
        '成品': 'success',
        '半成品': 'warning',
        '物料': 'info',
        '包装辅料': 'danger'
      }
      return typeMap[classification] || 'info'
    },
    
    /** 获取库存样式类 */
    getStockClass(stock) {
      if (stock < 20) return 'stock-warning'
      if (stock > 200) return 'stock-success'
      return ''
    },
    
    /** 获取销量样式类 */
    getSalesClass(sales) {
      if (sales > 50) return 'sales-success'
      return ''
    }
  }
}
</script>

<style scoped lang="scss">
.product-management {
  .page-header {
    margin-bottom: 16px;
    
    .header-content {
      display: flex;
      justify-content: space-between;
      align-items: center;
      
      .header-info {
        h2 {
          margin: 0 0 8px 0;
          font-size: 24px;
          font-weight: 600;
          color: #333;
        }
        
        p {
          margin: 0;
          color: #666;
          font-size: 14px;
        }
      }
      
      .header-actions {
        display: flex;
        gap: 12px;
      }
    }
  }
  
  .toolbar-section {
    margin-bottom: 16px;
    
    .filter-card {
      border: 1px solid #e4e7ed;
      
      :deep(.el-card__body) {
        padding: 16px;
      }
    }
    
    .filter-row {
      display: flex;
      gap: 12px;
      align-items: center;
      flex-wrap: wrap;
      margin-bottom: 12px;
      
      .filter-item {
        display: flex;
        align-items: center;
        
        &.search-item {
          flex: 1;
          min-width: 200px;
        }
      }
    }
    
    .category-tags-container {
      display: flex;
      flex-wrap: wrap;
      gap: 6px;
      margin: 8px 0;
      
      .category-tag, .classification-tag {
        display: inline-block;
        padding: 6px 12px;
        border-radius: 12px;
        color: white;
        font-size: 13px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
        user-select: none;
        
        &.active {
          transform: scale(1.05);
          box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
        }
        
        &:hover {
          opacity: 0.8;
          transform: translateY(-1px);
        }
      }
    }
  }
  
  .table-card {
    .table-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 16px;
      
      .table-title {
        display: flex;
        align-items: center;
        gap: 8px;
        
        span {
          font-weight: 600;
          font-size: 16px;
        }
      }
    }
  }
  
  .product-image {
    width: 50px;
    height: 50px;
    border-radius: 4px;
    overflow: hidden;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    
    .image-item {
      width: 100%;
      height: 100%;
    }
    
    .image-slot {
      font-size: 20px;
      color: #ddd;
    }
  }
  
  .stock-warning {
    color: #f56c6c;
    font-weight: 600;
  }
  
  .stock-success {
    color: #67c23a;
    font-weight: 600;
  }
  
  .sales-success {
    color: #67c23a;
    font-weight: 600;
  }
  
  .delete-btn {
    color: #f56c6c;
    
    &:hover {
      color: #f78989;
    }
  }
}

// 响应式设计
@media (max-width: 768px) {
  .product-management {
    .header-content {
      flex-direction: column;
      gap: 16px;
      text-align: center;
      
      .header-actions {
        justify-content: center;
      }
    }
    
    .filter-row {
      flex-direction: column;
      align-items: stretch;
      
      .filter-item {
        &.search-item {
          min-width: auto;
        }
      }
    }
    
    .table-header {
      flex-direction: column;
      gap: 12px;
      text-align: center;
    }
  }
}
</style>