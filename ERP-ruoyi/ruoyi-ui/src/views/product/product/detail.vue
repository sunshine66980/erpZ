<template>
  <div class="product-detail-container">
    <!-- VR虚拟试戴组件 -->
    <VirtualTryOn
      v-if="virtualTryOnVisible"
      :visible="virtualTryOnVisible"
      :product-id="productId"
      :product-name="productInfo.productName"
      :model-path="currentModelPath"
      @close="virtualTryOnVisible = false"
    />

    <!-- 返回按钮 -->
    <div class="back-section">
      <el-button icon="el-icon-arrow-left" @click="goBack">返回产品列表</el-button>
    </div>

    <!-- 产品基本信息 -->
    <el-card shadow="never" class="product-info-card">
      <div slot="header" class="card-header">
        <span class="header-title">产品详情</span>
        <div class="header-actions">
          <el-button type="primary" icon="el-icon-edit" @click="handleEdit">编辑产品</el-button>
          <el-button type="success" icon="el-icon-shopping-cart-2" @click="handlePurchase">采购产品</el-button>
          <el-button type="warning" icon="el-icon-camera" @click="handleVirtualTryOn" :disabled="!currentModelPath">VR虚拟试戴</el-button>
        </div>
      </div>
      
      <div class="product-detail-content">
        <div class="product-left">
          <!-- 产品图片 -->
          <div class="product-images">
            <div class="main-image">
              <el-image 
                :src="currentImage" 
                :preview-src-list="productImages"
                fit="contain"
                class="main-product-image"
              >
                <div slot="error" class="image-error">
                  <i class="el-icon-picture-outline"></i>
                  <span>暂无图片</span>
                </div>
              </el-image>
            </div>
            <div class="thumbnail-list" v-if="productImages.length > 1">
              <div 
                v-for="(image, index) in productImages"
                :key="index"
                class="thumbnail-item"
                :class="{ active: currentImageIndex === index, 'is-primary': isPrimaryImage(index) }"
                @click="setCurrentImage(index)"
              >
                <el-image :src="image" fit="cover" />
                <div class="primary-badge" v-if="isPrimaryImage(index)">
                  <i class="el-icon-crown"></i>
                </div>
              </div>
            </div>
            <!-- 图片上传和3D模型生成 -->
            <div class="image-upload-section">
              <el-form-item label="上传图片">
                <ImageUpload v-model="uploadedImagePath" :limit="1" @success="onImageUploadSuccess" />
              </el-form-item>
              <el-form-item>
                <el-button type="primary" @click="generate3DModel" :loading="generating3DModel" :disabled="!uploadedFile">
                  {{ generating3DModel ? '生成中...' : '生成3D模型' }}
                </el-button>
              </el-form-item>
              <el-form-item label="3D模型路径" v-if="currentModelPath">
                <el-input v-model="currentModelPath" readonly placeholder="3D模型路径" />
              </el-form-item>
            </div>
          </div>
        </div>
        
        <div class="product-right">
          <!-- 产品基本信息 -->
          <div class="product-basic-info">
            <div class="product-code">
              <span class="label">SKU：</span>
              <span class="value">{{ productInfo.productCode || '-' }}</span>
            </div>
            <h2 class="product-name">{{ productInfo.productName || '-' }}</h2>
            <div class="product-model">
              <span class="label">型号：</span>
              <span class="value">{{ productInfo.model || '-' }}</span>
            </div>
            
            <div class="product-tags">
              <el-tag v-if="productInfo.productType" type="warning" size="small">
                {{ productInfo.productType }}
              </el-tag>
              <el-tag 
                :type="getCategoryTagType(productInfo.categoryName)" 
                size="small"
              >
                {{ productInfo.categoryName }}
              </el-tag>
              <el-tag 
                :type="getClassificationTagType(productInfo.classificationName)" 
                size="small"
              >
                {{ productInfo.classificationName }}
              </el-tag>
            </div>
          </div>
          
          <!-- 库存和销量信息 -->
          <div class="product-sales-info">
            <div class="info-item">
              <div class="info-label">当前库存</div>
              <div class="info-value" :class="getStockClass(productInfo.stock)">
                {{ productInfo.stock || 0 }} 件
              </div>
            </div>
            <div class="info-item">
              <div class="info-label">交货期</div>
              <div class="info-value">{{ productInfo.leadTime || 0 }} 天</div>
            </div>
            <div class="info-item">
              <div class="info-label">10天销量</div>
              <div class="info-value sales-value">{{ productInfo.sales10days || 0 }} 件</div>
            </div>
            <div class="info-item">
              <div class="info-label">30天销量</div>
              <div class="info-value sales-value">{{ productInfo.sales30days || 0 }} 件</div>
            </div>
          </div>
          
          <!-- 产品状态 -->
          <div class="product-status">
            <div class="status-item">
              <span class="status-label">产品状态：</span>
              <el-tag :type="productInfo.isActive ? 'success' : 'danger'" size="small">
                {{ productInfo.isActive ? '启用' : '禁用' }}
              </el-tag>
            </div>
          </div>
        </div>
      </div>
    </el-card>

    <!-- 详细信息标签页 -->
    <el-card shadow="never" class="product-tabs-card">
      <el-tabs v-model="activeTab" type="border-card">
        <!-- 详细规格 -->
        <el-tab-pane label="详细规格" name="specs">
          <div class="specs-content">
            <el-descriptions :column="2" border>
              <el-descriptions-item label="产品SKU">{{ productInfo.productCode || '-' }}</el-descriptions-item>
              <el-descriptions-item label="产品名称">{{ productInfo.productName || '-' }}</el-descriptions-item>
              <el-descriptions-item label="型号">{{ productInfo.model || '-' }}</el-descriptions-item>
              <el-descriptions-item label="产品类型">{{ productInfo.productType || '-' }}</el-descriptions-item>
              <el-descriptions-item label="产品类目">{{ productInfo.categoryName || '-' }}</el-descriptions-item>
              <el-descriptions-item label="产品分类">{{ productInfo.classificationName || '-' }}</el-descriptions-item>
              <el-descriptions-item label="单位">{{ productInfo.unit || '-' }}</el-descriptions-item>
              <el-descriptions-item label="采购价格">{{ formatPrice(productInfo.purchasePrice) }}</el-descriptions-item>
              <el-descriptions-item label="重量">{{ productInfo.weight || '-' }} kg</el-descriptions-item>
              <el-descriptions-item label="体积">{{ productInfo.volume || '-' }} m³</el-descriptions-item>
              <el-descriptions-item label="长度">{{ productInfo.length || '-' }} mm</el-descriptions-item>
              <el-descriptions-item label="宽度">{{ productInfo.width || '-' }} mm</el-descriptions-item>
              <el-descriptions-item label="高度">{{ productInfo.height || '-' }} mm</el-descriptions-item>
              <el-descriptions-item label="标准箱装量">{{ productInfo.standardBoxQty || '-' }} 件/箱</el-descriptions-item>
              <el-descriptions-item label="交货期">{{ productInfo.leadTime || '-' }} 天</el-descriptions-item>
            </el-descriptions>
          </div>
        </el-tab-pane>
        
        <!-- 采购信息 -->
        <el-tab-pane label="采购信息" name="purchase">
          <div class="purchase-content">
            <el-descriptions :column="1" border>
              <el-descriptions-item label="采购备注">
                {{ productInfo.purchaseRemark || '暂无采购备注' }}
              </el-descriptions-item>
              <el-descriptions-item label="1688平台链接" v-if="productInfo.platform1688Url">
                <el-link :href="productInfo.platform1688Url" target="_blank" type="primary">
                  {{ productInfo.platform1688Url }}
                </el-link>
              </el-descriptions-item>
              <el-descriptions-item label="质量等级">
                {{ productInfo.qualityType || '-' }}
              </el-descriptions-item>
              <el-descriptions-item label="销售渠道">
                {{ productInfo.salesChannels || '-' }}
              </el-descriptions-item>
            </el-descriptions>
          </div>
        </el-tab-pane>
        
        <!-- 产品描述 -->
        <el-tab-pane label="产品描述" name="description">
          <div class="description-content">
            <div class="description-text">
              {{ productInfo.description || '暂无产品描述' }}
            </div>
          </div>
        </el-tab-pane>
        
        <!-- 操作记录 -->
        <el-tab-pane label="操作记录" name="history">
          <div class="history-content">
            <el-descriptions :column="1" border>
              <el-descriptions-item label="创建时间">{{ productInfo.createTime || '-' }}</el-descriptions-item>
              <el-descriptions-item label="最后修改">{{ productInfo.updateTime || '-' }}</el-descriptions-item>
            </el-descriptions>
          </div>
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script>
import { getProduct } from "@/api/product/product"
import { generate3DModel } from "@/api/product/images"
import VirtualTryOn from "@/components/VirtualTryOn"
import ImageUpload from "@/components/ImageUpload"

export default {
  name: "ProductDetail",
  components: {
    VirtualTryOn,
    ImageUpload
  },
  data() {
    return {
      productId: null,
      loading: true,
      productInfo: {},
      activeTab: 'specs',
      currentImageIndex: 0,
      productImages: [],
      virtualTryOnVisible: false,
      uploadedImagePath: '',
      uploadedFile: null,
      currentModelPath: '',
      generating3DModel: false
    }
  },
  computed: {
    currentImage() {
      return this.productImages.length > 0 ? this.productImages[this.currentImageIndex] : ''
    }
  },
  created() {
    this.productId = this.$route.params.id
    if (this.productId) {
      this.getProductDetail()
    } else {
      this.mockProductDetail()
    }
  },
  methods: {
    /** VR虚拟试戴 */
    handleVirtualTryOn() {
      this.virtualTryOnVisible = true
    },

    /** 图片上传成功处理 */
    onImageUploadSuccess(file) {
      this.uploadedFile = file
      this.uploadedImagePath = file.response.data
    },

    /** 生成3D模型 */
    generate3DModel() {
      if (!this.uploadedFile) {
        this.$modal.msgWarning("请先上传图片")
        return
      }

      this.generating3DModel = true
      // 调用后端API生成3D模型
      generate3DModel(this.uploadedFile).then(response => {
        if (response.code === 200) {
          this.currentModelPath = response.data
          this.$modal.msgSuccess("3D模型生成成功")
        } else {
          this.$modal.msgError(response.msg)
        }
      }).catch(error => {
        this.$modal.msgError("3D模型生成失败：" + error.message)
      }).finally(() => {
        this.generating3DModel = false
      })
    },
    /** 获取产品详情 */
    getProductDetail() {
      this.loading = true
      getProduct(this.productId).then(response => {
        this.productInfo = response.data || {}
        this.initProductImages()
        this.loading = false
      }).catch(() => {
        this.mockProductDetail()
        this.loading = false
      })
    },
    
    /** 模拟产品详情数据 */
    mockProductDetail() {
      const mockData = {
        productId: this.productId || 1,
        productCode: "SKU001",
        productName: "无线游戏鼠标 RGB背光版 高精度传感器",
        model: "GM-001",
        productType: "普品",
        categoryName: "游戏",
        classificationName: "成品",
        unit: "件",
        purchasePrice: 89.50,
        stock: 156,
        leadTime: 7,
        sales10days: 89,
        sales30days: 267,
        weight: 0.125,
        volume: 0.001,
        length: 120,
        width: 65,
        height: 40,
        standardBoxQty: 20,
        description: "专业电竞游戏鼠标，配备高精度光学传感器，支持16000 DPI调节，RGB背光系统，人体工学设计，适合长时间游戏使用。兼容Windows/Mac/Linux系统。",
        purchaseRemark: "建议采购量不少于50件，可享受批量采购优惠。产品质保期为12个月。",
        platform1688Url: "https://detail.1688.com/offer/xxxxxx.html",
        qualityType: "A级",
        salesChannels: "线上销售",
        isActive: true,
        createTime: "2024-01-15 10:30:00",
        updateTime: "2024-11-01 14:20:00"
      }
      
      this.productInfo = mockData
      this.initProductImages()
      this.loading = false
    },
    
    /** 初始化产品图片 */
    initProductImages() {
      // 优先使用数据库中的真实产品图片
      if (this.productInfo.productImagesList && this.productInfo.productImagesList.length > 0) {
        // 对图片按排序和主图优先级排序
        const sortedImages = [...this.productInfo.productImagesList].sort((a, b) => {
          // 主图优先
          if (a.isPrimary === '1' && b.isPrimary !== '1') return -1
          if (a.isPrimary !== '1' && b.isPrimary === '1') return 1
          // 然后按排序字段
          return (a.sortOrder || 0) - (b.sortOrder || 0)
        })
        
        // 提取图片路径
        this.productImages = sortedImages.map(img => img.imagePath).filter(path => path && path.trim() !== '')
        
        // 如果有图片，默认显示主图或第一张图片
        if (this.productImages.length > 0) {
          // 找到主图的索引
          const primaryImageIndex = sortedImages.findIndex(img => img.isPrimary === '1')
          this.currentImageIndex = primaryImageIndex >= 0 ? primaryImageIndex : 0
        }
      } else {
        // 如果没有真实图片，根据产品类目生成模拟图片作为后备
        this.initMockImages()
      }
    },

    /** 初始化模拟图片（作为后备方案） */
    initMockImages() {
      const typeImages = {
        '游戏': [
          'https://images.unsplash.com/photo-1596727147705-61a532a659bd?w=600',
          'https://images.unsplash.com/photo-1572569511254-d8f925fe2cbb?w=600'
        ],
        '3C类': [
          'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=600',
          'https://images.unsplash.com/photo-1556656793-08538906a9f8?w=600'
        ],
        '母婴': [
          'https://images.unsplash.com/photo-1571769780946-9181c16a5ab4?w=600',
          'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=600'
        ],
        '汽配': [
          'https://images.unsplash.com/photo-1551936183-11b8c77f8c72?w=600',
          'https://images.unsplash.com/photo-1559717205-6943e343a762?w=600'
        ],
        '户外运动': [
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=600',
          'https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=600'
        ],
        '玩具': [
          'https://images.unsplash.com/photo-1596473931281-2a3b3c202b27?w=600',
          'https://images.unsplash.com/photo-1541749814-2cba6f58758a?w=600'
        ],
        '家居': [
          'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=600',
          'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=600'
        ]
      }
      
      this.productImages = typeImages[this.productInfo.categoryName] || 
        ['https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600']
    },
    
    /** 设置当前图片 */
    setCurrentImage(index) {
      this.currentImageIndex = index
    },

    /** 判断是否为主图 */
    isPrimaryImage(index) {
      if (!this.productInfo.productImagesList || this.productInfo.productImagesList.length === 0) {
        return false
      }
      
      // 对图片按排序和主图优先级排序，找到对应的图片
      const sortedImages = [...this.productInfo.productImagesList].sort((a, b) => {
        if (a.isPrimary === '1' && b.isPrimary !== '1') return -1
        if (a.isPrimary !== '1' && b.isPrimary === '1') return 1
        return (a.sortOrder || 0) - (b.sortOrder || 0)
      })
      
      const image = sortedImages[index]
      return image && image.isPrimary === '1'
    },
    
    /** 返回产品列表 */
    goBack() {
      this.$router.go(-1)
    },
    
    /** 编辑产品 */
    handleEdit() {
      this.$router.push(`/product/product/edit/${this.productId}`)
    },
    
    /** 采购产品 */
    handlePurchase() {
      this.$message.success(`正在为产品 ${this.productInfo.productCode} 创建采购单...`)
      this.$router.push(`/purchase/create?sku=${this.productInfo.productCode}`)
    },
    
    /** 获取类目标签类型 */
    getCategoryTagType(category) {
      const typeMap = {
        '游戏': 'primary',
        '3C类': 'success',
        '母婴': 'warning',
        '汽配': 'info',
        '户外运动': 'success',
        '玩具': 'warning',
        '家居': 'primary'
      }
      return typeMap[category] || 'info'
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
    
    /** 格式化价格 */
    formatPrice(price) {
      return price ? `¥${price.toFixed(2)}` : '-'
    }
  }
}
</script>

<style scoped lang="scss">
.product-detail-container {
  .back-section {
    margin-bottom: 16px;
  }
  
  .product-info-card {
    margin-bottom: 16px;
    
    .card-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      
      .header-title {
        font-size: 18px;
        font-weight: 600;
        color: #333;
      }
      
      .header-actions {
        display: flex;
        gap: 12px;
      }
    }
    
    .product-detail-content {
      display: flex;
      gap: 32px;
      
      .product-left {
        flex: 0 0 400px;
        
        .product-images {
            .main-image {
              margin-bottom: 12px;
              border: 1px solid #e4e7ed;
              border-radius: 8px;
              overflow: hidden;
              
              .main-product-image {
                width: 100%;
                height: 300px;
                display: flex;
                align-items: center;
                justify-content: center;
                background: #f5f7fa;
                
                .image-error {
                  display: flex;
                  flex-direction: column;
                  align-items: center;
                  color: #909399;
                  
                  i {
                    font-size: 48px;
                    margin-bottom: 8px;
                  }
                }
              }
            }
            
            .thumbnail-list {
              display: flex;
              gap: 8px;
              
              .thumbnail-item {
                width: 60px;
                height: 60px;
                border: 2px solid #e4e7ed;
                border-radius: 4px;
                cursor: pointer;
                overflow: hidden;
                transition: border-color 0.3s;
                position: relative;
                
                &.active {
                  border-color: #409eff;
                }
                
                &.is-primary {
                  border-color: #f56c6c;
                  
                  &.active {
                    border-color: #f56c6c;
                    box-shadow: 0 0 0 2px rgba(245, 108, 108, 0.2);
                  }
                }
                
                &:hover {
                  border-color: #409eff;
                }
                
                .primary-badge {
                  position: absolute;
                  top: 2px;
                  right: 2px;
                  background: #f56c6c;
                  color: #fff;
                  border-radius: 50%;
                  width: 16px;
                  height: 16px;
                  display: flex;
                  align-items: center;
                  justify-content: center;
                  font-size: 10px;
                  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
                }
                
                .el-image {
                  width: 100%;
                  height: 100%;
                }
              }
            }
            
            .image-upload-section {
              margin-top: 20px;
              padding: 16px;
              background: #f8f9fa;
              border-radius: 8px;
              
              .el-form-item {
                margin-bottom: 12px;
                
                &:last-child {
                  margin-bottom: 0;
                }
                
                .el-form-item__label {
                  font-weight: 500;
                  color: #606266;
                }
              }
              
              .el-button {
                width: 100%;
              }
            }
          }
      }
      
      .product-right {
        flex: 1;
        
        .product-basic-info {
          margin-bottom: 24px;
          
          .product-code {
            margin-bottom: 8px;
            
            .label {
              color: #909399;
              font-size: 14px;
            }
            
            .value {
              color: #409eff;
              font-weight: 600;
              font-size: 16px;
            }
          }
          
          .product-name {
            margin: 0 0 16px 0;
            font-size: 24px;
            font-weight: 600;
            color: #303133;
            line-height: 1.4;
          }
          
          .product-model {
            margin-bottom: 16px;
            
            .label {
              color: #909399;
              font-size: 14px;
            }
            
            .value {
              color: #606266;
              font-weight: 500;
            }
          }
          
          .product-tags {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
          }
        }
        
        .product-sales-info {
          display: grid;
          grid-template-columns: repeat(2, 1fr);
          gap: 20px;
          margin-bottom: 24px;
          padding: 20px;
          background: #f8f9fa;
          border-radius: 8px;
          
          .info-item {
            text-align: center;
            
            .info-label {
              color: #909399;
              font-size: 14px;
              margin-bottom: 8px;
            }
            
            .info-value {
              font-size: 20px;
              font-weight: 600;
              color: #303133;
              
              &.sales-value {
                color: #67c23a;
              }
              
              &.stock-warning {
                color: #f56c6c;
              }
              
              &.stock-success {
                color: #67c23a;
              }
            }
          }
        }
        
        .product-status {
          .status-item {
            display: flex;
            align-items: center;
            
            .status-label {
              color: #606266;
              font-size: 14px;
              margin-right: 8px;
            }
          }
        }
      }
    }
  }
  
  .product-tabs-card {
    .specs-content,
    .purchase-content,
    .description-content,
    .history-content {
      padding: 20px 0;
    }
    
    .description-content {
      .description-text {
        line-height: 1.6;
        color: #606266;
        font-size: 14px;
      }
    }
  }
}

// 响应式设计
@media (max-width: 768px) {
  .product-detail-container {
    .product-info-card {
      .product-detail-content {
        flex-direction: column;
        gap: 24px;
        
        .product-left {
          flex: none;
          width: 100%;
          
          .product-images {
            .main-image {
              .main-product-image {
                height: 250px;
              }
            }
          }
        }
      }
    }
    
    .product-sales-info {
      grid-template-columns: 1fr !important;
      gap: 16px !important;
    }
  }
}
</style>