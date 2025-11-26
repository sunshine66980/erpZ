<template>
  <div class="product-edit-container">
    <!-- 页面头部 -->
    <div class="page-header">
      <div class="header-content">
        <div class="header-info">
          <h2>编辑产品</h2>
          <p>修改产品信息，SKU: {{ formData.productCode }}</p>
        </div>
        <div class="header-actions">
          <el-button icon="el-icon-arrow-left" @click="goBack">返回详情</el-button>
        </div>
      </div>
    </div>

    <!-- 表单内容 -->
    <el-card shadow="never" class="form-card" v-loading="loading">
      <div slot="header" class="card-header">
        <span class="header-title">编辑产品信息</span>
        <div class="header-actions">
          <el-button @click="resetForm">重置</el-button>
          <el-button type="primary" @click="handleUpdate" :loading="saveLoading">更新产品</el-button>
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
                  placeholder="产品SKU编码，可重新生成"
                  maxlength="50"
                  :readonly="!skuEditMode"
                  :class="{ 'sku-generated': skuGenerated, 'sku-edit-mode': skuEditMode }"
                >
                  <template slot="append">
                    <el-button 
                      v-if="!skuEditMode" 
                      type="primary" 
                      size="mini"
                      @click="toggleSkuEditMode"
                    >
                      编辑
                    </el-button>
                    <el-button 
                      v-else 
                      type="success" 
                      size="mini"
                      @click="saveSkuChanges"
                    >
                      保存
                    </el-button>
                    <el-button 
                      v-if="skuEditMode" 
                      type="info" 
                      size="mini"
                      @click="cancelSkuEdit"
                    >
                      取消
                    </el-button>
                  </template>
                </el-input>
                <div class="sku-hint" v-if="!skuEditMode">
                  点击编辑按钮可修改SKU
                </div>
                <div class="sku-info" v-if="skuGenerated && parsedSku && !skuEditMode">
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
                  placeholder="请输入销售渠道"
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

        <!-- 产品图片管理 -->
        <div class="form-section">
          <h3 class="section-title">产品图片管理</h3>
          <el-form-item label="产品图片">
            <div class="product-images-container">
              <!-- 图片上传区域 -->
              <div class="image-upload-area">
                <el-upload
                  ref="imageUpload"
                  :action="uploadUrl"
                  :headers="uploadHeaders"
                  :file-list="imageList"
                  :on-success="handleImageSuccess"
                  :on-remove="handleImageRemove"
                  :on-preview="handleImagePreview"
                  :before-upload="beforeImageUpload"
                  list-type="picture-card"
                  :limit="10"
                  :on-exceed="handleImageExceed"
                  multiple
                  accept="image/*"
                >
                  <i class="el-icon-plus"></i>
                  <div class="upload-tip">
                    <div>上传产品图片</div>
                    <div>最多10张，支持JPG/PNG</div>
                  </div>
                </el-upload>
                
                <!-- 图片预览对话框 -->
                <el-dialog :visible.sync="imagePreviewVisible" title="图片预览" width="50%">
                  <img :src="imagePreviewUrl" style="width: 100%; height: auto;" />
                </el-dialog>
              </div>
              
              <!-- 图片列表管理 -->
              <div class="image-management" v-if="imageList.length > 0">
                <div class="management-header">
                  <h4>图片管理</h4>
                  <el-button type="primary" size="small" @click="showImageSelector = true">设置主图</el-button>
                </div>
                <div class="image-list">
                  <div 
                    v-for="(image, index) in imageList" 
                    :key="image.uid || index"
                    class="image-item"
                    :class="{ 'is-primary': image.isPrimary === '1' }"
                  >
                    <img :src="image.url" :alt="`产品图片${index + 1}`" />
                    <div class="image-overlay">
                      <div class="image-actions">
                        <el-button 
                          type="text" 
                          icon="el-icon-view" 
                          @click="previewImage(image)"
                          title="预览"
                        />
                        <el-button 
                          type="text" 
                          icon="el-icon-crown" 
                          @click="setPrimaryImage(image)"
                          :class="{ 'primary-image': image.isPrimary === '1' }"
                          title="设为主图"
                        />
                        <el-button 
                          type="text" 
                          icon="el-icon-delete" 
                          @click="removeImage(image)"
                          title="删除"
                          style="color: #f56c6c;"
                        />
                      </div>
                      <div class="primary-badge" v-if="image.isPrimary === '1'">
                        <i class="el-icon-crown"></i> 主图
                      </div>
                    </div>
                    <div class="sort-handle">
                      <i class="el-icon-sort"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
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
            />
          </el-form-item>
        </div>
      </el-form>
    </el-card>
  </div>
</template>

<script>
import { getProduct, updateProduct, generateSku, checkSkuDuplicate } from "@/api/product/product"
import { 
  canGenerateSku, 
  generateLocalSku, 
  parseSku,
  validateSkuFormat 
} from "@/utils/skuGenerator"

export default {
  name: "ProductEdit",
  data() {
    return {
      productId: null,
      loading: true,
      saveLoading: false,
      skuEditMode: false,
      originalProductCode: '',
      skuGenerated: false,
      formData: {
        productId: null,
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
        isActive: 1,
        productImagesList: []
      },
      originalFormData: {},
      imagesModified: false, // 标记图片是否被修改
      imagesCleared: false, // 标记是否主动清空了所有图片
      
      // 图片管理相关数据
      imageList: [],
      uploadUrl: process.env.VUE_APP_BASE_API + '/common/upload',
      uploadHeaders: {
        Authorization: 'Bearer ' + this.$store.state.user.token
      },
      imagePreviewVisible: false,
      imagePreviewUrl: '',
      showImageSelector: false,
      formRules: {
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
      if (this.formData.productCode && validateSkuFormat(this.formData.productCode)) {
        return parseSku(this.formData.productCode)
      }
      return null
    }
  },
  created() {
    this.productId = this.$route.params.id
    if (this.productId) {
      this.getProductDetail()
    }
  },
  methods: {
    /** 获取产品详情 */
    getProductDetail() {
      this.loading = true
      getProduct(this.productId).then(response => {
        const data = response.data || {}
        
        // 确保数值字段有默认值
        const processedData = {
          ...data,
          productId: this.productId,
          stock: data.stock != null ? data.stock : 0,
          leadTime: data.leadTime != null ? data.leadTime : 0,
          standardBoxQty: data.standardBoxQty != null ? data.standardBoxQty : 1,
          purchasePrice: data.purchasePrice != null ? data.purchasePrice : 0,
          weight: data.weight != null ? data.weight : 0,
          volume: data.volume != null ? data.volume : 0,
          length: data.length != null ? data.length : 0,
          width: data.width != null ? data.width : 0,
          height: data.height != null ? data.height : 0,
          sales30days: data.sales30days != null ? data.sales30days : 0,
          isActive: data.isActive === 1 // 将数据库的int(0/1)转换为boolean
        }
        
        this.formData = processedData
        this.originalFormData = { ...processedData }
        this.originalProductCode = data.productCode || ''
        this.skuGenerated = validateSkuFormat(data.productCode || '')
        
        // 初始化图片数据
        this.initImageData()
        
        this.loading = false
      }).catch(() => {
        this.$modal.msgError("获取产品信息失败")
        this.goBack()
        this.loading = false
      })
    },

    /** SKU编辑模式切换 */
    toggleSkuEditMode() {
      this.skuEditMode = true
    },

    /** 取消SKU编辑 */
    cancelSkuEdit() {
      this.skuEditMode = false
      this.formData.productCode = this.originalProductCode
    },

    /** 保存SKU更改 */
    async saveSkuChanges() {
      if (!this.formData.productCode) {
        this.$message.error('SKU不能为空')
        return
      }

      if (!validateSkuFormat(this.formData.productCode)) {
        this.$message.error('SKU格式不正确，应为：类型-类目-分类-序号')
        return
      }

      try {
        const response = await checkSkuDuplicate(this.formData.productCode, this.productId)
        if (response.code === 200 && response.data === true) {
          this.$message.error('SKU已存在，请使用其他SKU')
          return
        }
      } catch (error) {
        console.warn('SKU查重失败:', error)
      }

      this.originalProductCode = this.formData.productCode
      this.skuEditMode = false
      this.skuGenerated = validateSkuFormat(this.formData.productCode)
      this.$message.success('SKU修改成功')
    },

    /** 产品类型变化处理 */
    handleProductTypeChange(value) {
      if (this.canGenerateSku && this.skuEditMode) {
        this.generateNewSku()
      }
    },

    /** 类目变化处理 */
    handleCategoryChange(value) {
      if (this.canGenerateSku && this.skuEditMode) {
        this.generateNewSku()
      }
    },

    /** 分类变化处理 */
    handleClassificationChange(value) {
      if (this.canGenerateSku && this.skuEditMode) {
        this.generateNewSku()
      }
    },

    /** 生成新SKU */
    async generateNewSku() {
      if (!this.canGenerateSku) return

      try {
        const response = await generateSku({
          productType: this.formData.productType,
          categoryId: this.formData.categoryId,
          classificationId: this.formData.classificationId
        })
        
        if (response.code === 200 && response.data) {
          this.formData.productCode = response.data
          this.$message.success('SKU已更新')
        }
      } catch (error) {
        console.warn('SKU生成失败:', error)
        // 降级方案：使用本地生成
        this.formData.productCode = generateLocalSku(
          this.formData.productType,
          this.formData.categoryId,
          this.formData.classificationId,
          1
        )
      }
    },
    
    /** 更新产品 */
    handleUpdate() {
      this.$refs.productForm.validate(valid => {
        if (valid) {
          this.saveLoading = true
          
          // 只有当图片被修改时才更新图片列表
          if (this.imagesModified) {
            this.updateProductImagesList()
            
            // 添加调试信息
            console.log('图片已修改，发送productImagesList:', this.formData.productImagesList)
            console.log('imagesCleared:', this.imagesCleared)
          } else {
            // 如果图片没有被修改，不发送productImagesList字段
            delete this.formData.productImagesList
            console.log('图片未修改，不发送productImagesList')
          }
          
          // 准备提交数据，转换boolean为int
          const submitData = {
            ...this.formData,
            isActive: this.formData.isActive ? 1 : 0  // 将boolean转换为int(0/1)
          }
          
          updateProduct(submitData).then(response => {
            this.$modal.msgSuccess("更新成功")
            this.goBack()
          }).catch(() => {
            this.$modal.msgError("更新失败")
          }).finally(() => {
            this.saveLoading = false
          })
        }
      })
    },
    
    /** 重置表单 */
    resetForm() {
      this.formData = { ...this.originalFormData }
    },
    
    /** 返回详情页 */
    goBack() {
      this.$router.push(`/product/product/detail/${this.productId}`)
    },

    // ========== 图片管理相关方法 ==========
    
    /** 初始化图片数据 */
    initImageData() {
      if (this.formData.productImagesList && this.formData.productImagesList.length > 0) {
        this.imageList = this.formData.productImagesList.map((img, index) => ({
          uid: img.imageId || `img_${index}`,
          name: img.imagePath ? img.imagePath.split('/').pop() : `image_${index}`,
          url: img.imagePath,
          isPrimary: img.isPrimary,
          imageId: img.imageId,
          sortOrder: img.sortOrder || index
        }))
      } else {
        // 确保imageList总是被初始化为空数组
        this.imageList = []
      }
      
      // 重置图片修改标志
      this.imagesModified = false
      this.imagesCleared = false
    },

    /** 图片上传成功回调 */
    handleImageSuccess(response, file, fileList) {
      if (response.code === 200 && response.url) {
        // 更新文件列表中的URL
        const uploadedFile = fileList.find(f => f.uid === file.uid)
        if (uploadedFile) {
          uploadedFile.url = response.url
          uploadedFile.isPrimary = '0'
          uploadedFile.imageId = null
          
          // 如果这是第一张图片，自动设为主图
          if (fileList.length === 1) {
            uploadedFile.isPrimary = '1'
          }
        }
        
        // 同步更新imageList
        this.imageList = fileList.map(file => ({
          uid: file.uid,
          name: file.name,
          url: file.url,
          isPrimary: file.isPrimary || '0',
          imageId: file.imageId || null,
          sortOrder: this.imageList.findIndex(img => img.uid === file.uid) >= 0 ? 
                   this.imageList.find(img => img.uid === file.uid).sortOrder : 
                   this.imageList.length
        }))
        
        console.log('更新后的imageList:', this.imageList)
        
        // 重置清空标志（有新图片上传）
        this.imagesCleared = false
        
        // 标记图片已修改
        this.imagesModified = true
        
        // 更新formData中的图片列表
        this.updateProductImagesList()
        
        this.$message.success('图片上传成功')
      } else {
        this.$message.error('图片上传失败：' + (response.msg || '未知错误'))
      }
    },

    /** 图片删除回调 */
    handleImageRemove(file, fileList) {
      // 如果删除的是主图，需要重新指定主图
      if (file.isPrimary === '1' && fileList.length > 0) {
        fileList[0].isPrimary = '1'
      }
      
      // 如果删除后没有图片了，标记为已清空
      if (fileList.length === 0) {
        this.imagesCleared = true
      }
      
      // 同步更新imageList - 从fileList重新构建
      this.imageList = fileList.map(file => ({
        uid: file.uid,
        name: file.name,
        url: file.url,
        isPrimary: file.isPrimary || '0',
        imageId: file.imageId || null,
        sortOrder: this.imageList.findIndex(img => img.uid === file.uid) >= 0 ? 
                 this.imageList.find(img => img.uid === file.uid).sortOrder : 
                 this.imageList.length
      }))
      
      console.log('删除图片后更新imageList:', this.imageList)
      
      // 标记图片已修改
      this.imagesModified = true
      
      this.updateProductImagesList()
    },

    /** 图片预览 */
    handleImagePreview(file) {
      this.imagePreviewUrl = file.url
      this.imagePreviewVisible = true
    },

    /** 上传前验证 */
    beforeImageUpload(file) {
      const isImage = file.type.startsWith('image/')
      const isLt5M = file.size / 1024 / 1024 < 5

      if (!isImage) {
        this.$message.error('只能上传图片文件!')
        return false
      }
      if (!isLt5M) {
        this.$message.error('图片大小不能超过 5MB!')
        return false
      }
      return true
    },

    /** 图片数量超限 */
    handleImageExceed(files, fileList) {
      this.$message.warning(`最多只能上传 10 张图片，当前已上传 ${fileList.length} 张`)
    },

    /** 预览图片 */
    previewImage(image) {
      this.imagePreviewUrl = image.url
      this.imagePreviewVisible = true
    },

    /** 设置主图 */
    setPrimaryImage(image) {
      // 清除所有图片的主图标记
      this.imageList.forEach(img => {
        img.isPrimary = '0'
      })
      
      // 设置当前图片为主图
      image.isPrimary = '1'
      
      // 标记图片已修改
      this.imagesModified = true
      
      this.updateProductImagesList()
      this.$message.success('主图设置成功')
    },

    /** 删除图片 */
    removeImage(image) {
      this.$confirm('确定要删除这张图片吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        const index = this.imageList.findIndex(img => 
          (img.uid && img.uid === image.uid) || 
          (img.imageId && img.imageId === image.imageId)
        )
        
        if (index > -1) {
          const isPrimary = this.imageList[index].isPrimary === '1'
          this.imageList.splice(index, 1)
          
          // 如果删除的是主图，重新指定主图
          if (isPrimary && this.imageList.length > 0) {
            this.imageList[0].isPrimary = '1'
          }
          
          // 如果删除后没有图片了，标记为已清空
          if (this.imageList.length === 0) {
            this.imagesCleared = true
          }
          
          // 标记图片已修改
          this.imagesModified = true
          
          this.updateProductImagesList()
          this.$message.success('图片删除成功')
        }
      }).catch(() => {
        // 用户取消删除
      })
    },

    /** 格式化日期为 yyyy-MM-dd HH:mm:ss */
    formatDate(date) {
      if (!date) return null
      const d = new Date(date)
      const year = d.getFullYear()
      const month = String(d.getMonth() + 1).padStart(2, '0')
      const day = String(d.getDate()).padStart(2, '0')
      const hours = String(d.getHours()).padStart(2, '0')
      const minutes = String(d.getMinutes()).padStart(2, '0')
      const seconds = String(d.getSeconds()).padStart(2, '0')
      return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`
    },

    /** 更新产品图片列表数据 */
    updateProductImagesList() {
      if (this.imageList && this.imageList.length > 0) {
        this.formData.productImagesList = this.imageList.map((img, index) => ({
          imageId: img.imageId || null,
          productId: this.productId,
          imagePath: img.url,
          imageType: 1, // 默认图片类型
          sortOrder: index,
          isPrimary: img.isPrimary || '0',
          createTime: this.formatDate(new Date())
        }))
      } else {
        // 如果没有图片，设置为空数组
        this.formData.productImagesList = []
      }
    },
  }
}
</script>

<style scoped lang="scss">
.product-edit-container {
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

// SKU相关样式
.sku-generated {
  .el-input__inner {
    background-color: #f0f9ff;
    border-color: #409eff;
    color: #409eff;
    font-weight: 500;
  }
}

.sku-edit-mode {
  .el-input__inner {
    background-color: #fff;
    border-color: #409eff;
    font-weight: 500;
  }
}

.sku-hint {
  font-size: 12px;
  color: #909399;
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

// 图片管理相关样式
.product-images-container {
  .image-upload-area {
    margin-bottom: 20px;
    
    .upload-tip {
      font-size: 12px;
      color: #909399;
      margin-top: 4px;
      line-height: 1.2;
    }
  }
  
  .image-management {
    border: 1px solid #e4e7ed;
    border-radius: 4px;
    padding: 16px;
    
    .management-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 16px;
      
      h4 {
        margin: 0;
        font-size: 14px;
        font-weight: 500;
        color: #303133;
      }
    }
    
    .image-list {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
      gap: 16px;
      
      .image-item {
        position: relative;
        border: 2px solid #e4e7ed;
        border-radius: 4px;
        overflow: hidden;
        cursor: pointer;
        transition: all 0.3s;
        
        &:hover {
          border-color: #409eff;
          
          .image-overlay {
            opacity: 1;
          }
          
          .sort-handle {
            opacity: 1;
          }
        }
        
        &.is-primary {
          border-color: #f56c6c;
          box-shadow: 0 0 0 2px rgba(245, 108, 108, 0.2);
        }
        
        img {
          width: 100%;
          height: 120px;
          object-fit: cover;
          display: block;
        }
        
        .image-overlay {
          position: absolute;
          top: 0;
          left: 0;
          right: 0;
          bottom: 0;
          background: rgba(0, 0, 0, 0.5);
          display: flex;
          flex-direction: column;
          justify-content: center;
          align-items: center;
          opacity: 0;
          transition: opacity 0.3s;
          
          .image-actions {
            display: flex;
            gap: 8px;
            margin-bottom: 8px;
            
            .el-button {
              color: #fff;
              padding: 6px;
              
              &.primary-image {
                color: #f56c6c;
              }
              
              &:hover {
                background: rgba(255, 255, 255, 0.2);
                border-radius: 4px;
              }
            }
          }
          
          .primary-badge {
            background: #f56c6c;
            color: #fff;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 4px;
          }
        }
        
        .sort-handle {
          position: absolute;
          top: 8px;
          right: 8px;
          background: rgba(0, 0, 0, 0.6);
          color: #fff;
          padding: 4px;
          border-radius: 4px;
          opacity: 0;
          transition: opacity 0.3s;
          cursor: move;
          
          &:hover {
            background: rgba(0, 0, 0, 0.8);
          }
        }
      }
    }
  }
}

// 响应式设计
@media (max-width: 768px) {
  .product-edit-container {
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
</style>