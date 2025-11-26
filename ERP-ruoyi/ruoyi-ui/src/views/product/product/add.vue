<template>
  <div class="product-add-container">
    <!-- 页面头部 -->
    <div class="page-header">
      <div class="header-content">
        <div class="header-info">
          <h2>新增产品</h2>
          <p>录入新产品信息到系统中</p>
        </div>
        <div class="header-actions">
          <el-button icon="el-icon-arrow-left" @click="goBack">返回列表</el-button>
        </div>
      </div>
    </div>

    <!-- 表单内容 -->
    <el-card shadow="never" class="form-card">
      <div slot="header" class="card-header">
        <span class="header-title">产品信息</span>
        <div class="header-actions">
          <el-button @click="resetForm">重置</el-button>
          <el-button type="primary" @click="handleSave" :loading="saveLoading">保存产品</el-button>
        </div>
      </div>

      <el-form
        ref="productForm"
        :model="formData"
        :rules="formRules"
        label-width="120px"
        class="product-form"
      >
        <!-- 基本信息 -->
        <div class="form-section">
          <h3 class="section-title">基本信息</h3>
          <el-row :gutter="20">
            <el-col :span="12">
              <el-form-item label="产品SKU" prop="productCode">
                <el-input
                  v-model="formData.productCode"
                  placeholder="请选择产品类型、类目、分类后自动生成"
                  maxlength="50"
                  readonly
                  :class="{ 'sku-generated': skuGenerated }"
                >
                  <template slot="append">
                    <el-button 
                      type="primary" 
                      size="mini"
                      :disabled="!canGenerateSku"
                      :loading="skuGenerating"
                      @click="handleGenerateSku"
                    >
                      生成SKU
                    </el-button>
                  </template>
                </el-input>
                <div class="sku-hint" v-if="!canGenerateSku">
                  请先选择产品类型、类目和分类
                </div>
                <div class="sku-info" v-if="skuGenerated && parsedSku">
                  SKU解析：{{ parsedSku.productTypeName }} - {{ parsedSku.categoryName }} - {{ parsedSku.classificationName }}
                </div>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="产品名称" prop="productName">
                <el-input
                  v-model="formData.productName"
                  placeholder="请输入产品名称"
                  maxlength="200"
                />
              </el-form-item>
            </el-col>
          </el-row>
          
          <el-row :gutter="20">
            <el-col :span="12">
              <el-form-item label="型号" prop="model">
                <el-input
                  v-model="formData.model"
                  placeholder="请输入产品型号"
                  maxlength="100"
                />
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="产品类型" prop="productType">
                <el-select 
                  v-model="formData.productType" 
                  placeholder="请选择产品类型" 
                  style="width: 100%"
                  @change="handleProductTypeChange"
                >
                  <el-option label="普通" :value="1" />
                  <el-option label="组合" :value="2" />
                  <el-option label="生产" :value="3" />
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>
          
          <el-row :gutter="20">
            <el-col :span="12">
              <el-form-item label="产品类目" prop="categoryId">
                <el-select 
                  v-model="formData.categoryId" 
                  placeholder="请选择产品类目" 
                  style="width: 100%"
                  @change="handleCategoryChange"
                >
                  <el-option label="游戏" :value="1" />
                  <el-option label="3C类" :value="2" />
                  <el-option label="母婴" :value="3" />
                  <el-option label="汽配" :value="4" />
                  <el-option label="户外运动" :value="5" />
                  <el-option label="玩具" :value="6" />
                  <el-option label="家居" :value="7" />
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="产品分类" prop="classificationId">
                <el-select 
                  v-model="formData.classificationId" 
                  placeholder="请选择产品分类" 
                  style="width: 100%"
                  @change="handleClassificationChange"
                >
                  <el-option label="成品(外采)" :value="1" />
                  <el-option label="成品(内部生产)" :value="2" />
                  <el-option label="半成品(可单售)" :value="3" />
                  <el-option label="半成品(需组合)" :value="4" />
                  <el-option label="物料(来料生产)" :value="5" />
                  <el-option label="物料(包装物料)" :value="6" />
                  <el-option label="包装辅料(彩盒)" :value="7" />
                  <el-option label="包装辅料(外箱)" :value="8" />
                  <el-option label="包装辅料(胶布)" :value="9" />
                  <el-option label="包装辅料(标签纸)" :value="10" />
                  <el-option label="包装辅料(其他辅料)" :value="11" />
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>
          
          <el-row :gutter="20">
            <el-col :span="12">
              <el-form-item label="单位" prop="unit">
                <el-select v-model="formData.unit" placeholder="请选择单位" style="width: 100%">
                  <el-option label="个" :value="1" />
                  <el-option label="套" :value="2" />
                  <el-option label="箱" :value="3" />
                  <el-option label="kg" :value="4" />
                  <el-option label="g" :value="5" />
                  <el-option label="件" :value="6" />
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="采购价格" prop="purchasePrice">
                <el-input-number
                  v-model="formData.purchasePrice"
                  :precision="2"
                  :min="0"
                  :max="99999"
                  placeholder="请输入采购价格"
                  style="width: 100%"
                />
              </el-form-item>
            </el-col>
          </el-row>
        </div>

        <!-- 库存和交期 -->
        <div class="form-section">
          <h3 class="section-title">库存和交期</h3>
          <el-row :gutter="20">
            <el-col :span="8">
              <el-form-item label="当前库存" prop="stock">
                <el-input-number
                  v-model="formData.stock"
                  :min="0"
                  :max="999999"
                  placeholder="请输入当前库存"
                  style="width: 100%"
                />
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-form-item label="交货期(天)" prop="leadTime">
                <el-input-number
                  v-model="formData.leadTime"
                  :min="0"
                  :max="365"
                  placeholder="请输入交货期"
                  style="width: 100%"
                />
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-form-item label="标准箱装量" prop="standardBoxQty">
                <el-input-number
                  v-model="formData.standardBoxQty"
                  :min="1"
                  :max="1000"
                  placeholder="请输入标准箱装量"
                  style="width: 100%"
                />
              </el-form-item>
            </el-col>
          </el-row>
        </div>

        <!-- 物理属性 -->
        <div class="form-section">
          <h3 class="section-title">物理属性</h3>
          <el-row :gutter="20">
            <el-col :span="6">
              <el-form-item label="重量(kg)" prop="weight">
                <el-input-number
                  v-model="formData.weight"
                  :precision="3"
                  :min="0"
                  :max="1000"
                  placeholder="重量"
                  style="width: 100%"
                />
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="体积(m³)" prop="volume">
                <el-input-number
                  v-model="formData.volume"
                  :precision="4"
                  :min="0"
                  :max="10"
                  placeholder="体积"
                  style="width: 100%"
                />
              </el-form-item>
            </el-col>
            <el-col :span="4">
              <el-form-item label="长度(mm)" prop="length">
                <el-input-number
                  v-model="formData.length"
                  :precision="1"
                  :min="0"
                  :max="10000"
                  placeholder="长度"
                  style="width: 100%"
                />
              </el-form-item>
            </el-col>
            <el-col :span="4">
              <el-form-item label="宽度(mm)" prop="width">
                <el-input-number
                  v-model="formData.width"
                  :precision="1"
                  :min="0"
                  :max="10000"
                  placeholder="宽度"
                  style="width: 100%"
                />
              </el-form-item>
            </el-col>
            <el-col :span="4">
              <el-form-item label="高度(mm)" prop="height">
                <el-input-number
                  v-model="formData.height"
                  :precision="1"
                  :min="0"
                  :max="10000"
                  placeholder="高度"
                  style="width: 100%"
                />
              </el-form-item>
            </el-col>
          </el-row>
        </div>

        <!-- 采购信息 -->
        <div class="form-section">
          <h3 class="section-title">采购信息</h3>
          <el-row :gutter="20">
            <el-col :span="12">
              <el-form-item label="质检类型" prop="qualityType">
                <el-select v-model="formData.qualityType" placeholder="请选择质检类型" style="width: 100%">
                  <el-option label="全检" :value="1" />
                  <el-option label="抽检" :value="2" />
                  <el-option label="免检" :value="3" />
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="销售渠道" prop="salesChannels">
                <el-input
                  v-model="formData.salesChannels"
                  placeholder="请输入销售渠道ID，多个用逗号分隔"
                  maxlength="100"
                />
              </el-form-item>
            </el-col>
          </el-row>
          
          <el-row :gutter="20">
            <el-col :span="24">
              <el-form-item label="1688链接" prop="platform1688Url">
                <el-input
                  v-model="formData.platform1688Url"
                  placeholder="请输入1688平台链接"
                  maxlength="500"
                />
              </el-form-item>
            </el-col>
          </el-row>
          
          <el-row :gutter="20">
            <el-col :span="24">
              <el-form-item label="采购备注" prop="purchaseRemark">
                <el-input
                  v-model="formData.purchaseRemark"
                  type="textarea"
                  :rows="3"
                  placeholder="请输入采购备注信息"
                  maxlength="1000"
                />
              </el-form-item>
            </el-col>
          </el-row>
        </div>

        <!-- 产品描述 -->
        <div class="form-section">
          <h3 class="section-title">产品描述</h3>
          <el-form-item label="产品描述" prop="description">
            <el-input
              v-model="formData.description"
              type="textarea"
              :rows="5"
              placeholder="请输入产品详细描述"
              maxlength="2000"
            />
          </el-form-item>
        </div>

        <!-- 产品状态 -->
        <div class="form-section">
          <h3 class="section-title">产品状态</h3>
          <el-form-item label="产品状态" prop="isActive">
            <el-switch
              v-model="formData.isActive"
              active-text="启用"
              inactive-text="禁用"
              :active-value="1"
              :inactive-value="0"
            />
          </el-form-item>
        </div>
      </el-form>
    </el-card>
  </div>
</template>

<script>
import { addProduct, generateSku, getNextSequence } from "@/api/product/product"
import { 
  canGenerateSku, 
  generateLocalSku, 
  parseSku,
  validateSkuFormat 
} from "@/utils/skuGenerator"

export default {
  name: "ProductAdd",
  data() {
    return {
      saveLoading: false,
      skuGenerating: false,
      skuGenerated: false,
      formData: {
        productCode: '',
        productName: '',
        model: '',
        productType: null,
        categoryId: null,
        classificationId: null,
        unit: null,
        purchasePrice: null,
        stock: null,
        leadTime: null,
        weight: null,
        volume: null,
        length: null,
        width: null,
        height: null,
        standardBoxQty: null,
        description: '',
        purchaseRemark: '',
        platform1688Url: '',
        qualityType: null,
        salesChannels: '',
        isActive: 1
      },
      formRules: {
        productCode: [
          { required: true, message: "请生成或输入产品SKU编码", trigger: "blur" },
          { validator: this.validateSku, trigger: "blur" }
        ],
        productName: [
          { required: true, message: "请输入产品名称", trigger: "blur" },
          { min: 2, max: 200, message: "长度在 2 到 200 个字符", trigger: "blur" }
        ],
        productType: [
          { required: true, message: "请选择产品类型", trigger: "change" }
        ],
        categoryId: [
          { required: true, message: "请选择产品类目", trigger: "change" }
        ],
        classificationId: [
          { required: true, message: "请选择产品分类", trigger: "change" }
        ],
        unit: [
          { required: true, message: "请选择单位", trigger: "change" }
        ],
        purchasePrice: [
          { required: true, message: "请输入采购价格", trigger: "blur" }
        ],
        stock: [
          { required: true, message: "请输入当前库存", trigger: "blur" }
        ],
        leadTime: [
          { required: true, message: "请输入交货期", trigger: "blur" }
        ]
      }
    }
  },
  computed: {
    /** 是否可以生成SKU */
    canGenerateSku() {
      return canGenerateSku(this.formData.productType, this.formData.categoryId, this.formData.classificationId)
    },
    /** 解析后的SKU信息 */
    parsedSku() {
      if (this.skuGenerated && this.formData.productCode) {
        return parseSku(this.formData.productCode)
      }
      return null
    }
  },
  methods: {
    /** SKU验证器 */
    validateSku(rule, value, callback) {
      if (!value) {
        callback(new Error('请生成或输入产品SKU编码'))
      } else if (!validateSkuFormat(value)) {
        callback(new Error('SKU格式不正确，应为：类型-类目-分类-序号'))
      } else {
        callback()
      }
    },

    /** 产品类型变化处理 */
    handleProductTypeChange() {
      this.skuGenerated = false
      this.formData.productCode = ''
      if (this.canGenerateSku) {
        this.autoGenerateSku()
      }
    },

    /** 类目变化处理 */
    handleCategoryChange() {
      this.skuGenerated = false
      this.formData.productCode = ''
      if (this.canGenerateSku) {
        this.autoGenerateSku()
      }
    },

    /** 分类变化处理 */
    handleClassificationChange() {
      this.skuGenerated = false
      this.formData.productCode = ''
      if (this.canGenerateSku) {
        this.autoGenerateSku()
      }
    },

    /** 自动生成SKU */
    async autoGenerateSku() {
      if (!this.canGenerateSku) return

      try {
        const response = await getNextSequence(
          this.formData.productType,
          this.formData.categoryId,
          this.formData.classificationId
        )
        
        if (response.code === 200 && response.data) {
          this.formData.productCode = generateLocalSku(
            this.formData.productType,
            this.formData.categoryId,
            this.formData.classificationId,
            response.data
          )
          this.skuGenerated = true
        }
      } catch (error) {
        console.warn('获取SKU序列号失败，使用本地生成:', error)
        // 降级方案：使用本地生成
        this.formData.productCode = generateLocalSku(
          this.formData.productType,
          this.formData.categoryId,
          this.formData.classificationId,
          1
        )
        this.skuGenerated = true
      }
    },

    /** 手动生成SKU */
    async handleGenerateSku() {
      if (!this.canGenerateSku) return

      this.skuGenerating = true
      try {
        const response = await generateSku({
          productType: this.formData.productType,
          categoryId: this.formData.categoryId,
          classificationId: this.formData.classificationId
        })
        
        if (response.code === 200 && response.data) {
          this.formData.productCode = response.data
          this.skuGenerated = true
          this.$message.success('SKU生成成功')
        }
      } catch (error) {
        console.error('SKU生成失败:', error)
        this.$message.error('SKU生成失败，请重试')
      } finally {
        this.skuGenerating = false
      }
    },

    /** 保存产品 */
    handleSave() {
      this.$refs.productForm.validate(valid => {
        if (valid) {
          this.saveLoading = true
          
          // 构建提交数据
          const submitData = {
            ...this.formData,
            sales30days: 0,
            sales10days: 0
          }
          
          addProduct(submitData).then(response => {
            this.$modal.msgSuccess("新增成功")
            this.$router.push('/product/product/index')
          }).catch(() => {
            this.$modal.msgError("新增失败")
          }).finally(() => {
            this.saveLoading = false
          })
        }
      })
    },
    
    /** 重置表单 */
    resetForm() {
      this.$refs.productForm.resetFields()
      this.skuGenerated = false
      this.formData = {
        productCode: '',
        productName: '',
        model: '',
        productType: null,
        categoryId: null,
        classificationId: null,
        unit: null,
        purchasePrice: null,
        stock: null,
        leadTime: null,
        weight: null,
        volume: null,
        length: null,
        width: null,
        height: null,
        standardBoxQty: null,
        description: '',
        purchaseRemark: '',
        platform1688Url: '',
        qualityType: null,
        salesChannels: '',
        isActive: 1
      }
    },
    
    /** 返回列表 */
    goBack() {
      this.$router.push('/product/product/index')
    }
  }
}
</script>

<style scoped lang="scss">
.product-add-container {
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
    }
  }
  
  .form-card {
    .card-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      
      .header-title {
        font-size: 16px;
        font-weight: 600;
        color: #333;
      }
      
      .header-actions {
        display: flex;
        gap: 12px;
      }
    }
    
    .product-form {
      .form-section {
        margin-bottom: 32px;
        padding-bottom: 24px;
        border-bottom: 1px solid #f0f0f0;
        
        &:last-child {
          margin-bottom: 0;
          border-bottom: none;
        }
        
        .section-title {
          margin: 0 0 20px 0;
          font-size: 16px;
          font-weight: 600;
          color: #409eff;
          position: relative;
          padding-left: 12px;
          
          &::before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%);
            width: 4px;
            height: 16px;
            background: #409eff;
            border-radius: 2px;
          }
        }
      }
    }
  }
}

// 响应式设计
@media (max-width: 768px) {
  .product-add-container {
    .header-content {
      flex-direction: column;
      gap: 16px;
      text-align: center;
    }
    
    .card-header {
      flex-direction: column;
      gap: 16px;
      text-align: center;
    }
    
    .form-section {
      .el-row {
        .el-col {
          margin-bottom: 16px;
        }
      }
    }
  }
}

// SKU相关样式
.sku-generated {
  .el-input__inner {
    background-color: #f0f9ff;
    border-color: #409eff;
    color: #409eff;
    font-weight: 500;
  }
}

.sku-hint {
  font-size: 12px;
  color: #e6a23c;
  margin-top: 4px;
  line-height: 1.2;
}

.sku-info {
  font-size: 12px;
  color: #67c23a;
  margin-top: 4px;
  line-height: 1.2;
  font-weight: 500;
}
</style>