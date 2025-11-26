<template>
  <div class="share-poster-container">
    <!-- 海报预览区域 -->
    <div class="poster-preview">
      <div class="poster-frame" :style="posterStyle">
        <!-- 背景图片 -->
        <div class="poster-background">
          <img 
            v-if="posterData.backgroundUrl" 
            :src="posterData.backgroundUrl" 
            alt="海报背景"
            class="background-image"
          />
          <div v-else class="background-placeholder">
            <i class="el-icon-picture-outline"></i>
            <span>点击设置背景图片</span>
          </div>
        </div>

        <!-- 作品图片 -->
        <div class="work-image-container">
          <img 
            v-if="posterData.workImageUrl" 
            :src="posterData.workImageUrl" 
            :alt="posterData.workTitle"
            class="work-image"
          />
          <div v-else class="work-image-placeholder">
            <i class="el-icon-picture"></i>
            <span>作品图片</span>
          </div>
        </div>

        <!-- 作品信息 -->
        <div class="work-info">
          <h3 class="work-title">{{ posterData.workTitle || '作品标题' }}</h3>
          <p class="work-subtitle">{{ posterData.workSubtitle || '作品副标题' }}</p>
          <p class="designer-name">设计师：{{ posterData.designerName || '设计师名称' }}</p>
        </div>

        <!-- 二维码区域 -->
        <div class="qr-code-container">
          <div class="qr-code">
            <img 
              v-if="posterData.qrCodeUrl" 
              :src="posterData.qrCodeUrl" 
              alt="二维码"
              class="qr-image"
            />
            <div v-else class="qr-placeholder">
              <i class="el-icon-grid"></i>
              <span>二维码</span>
            </div>
          </div>
          <p class="scan-text">扫码查看详情</p>
        </div>

        <!-- 装饰元素 -->
        <div class="decorative-elements">
          <div class="corner-decoration top-left"></div>
          <div class="corner-decoration top-right"></div>
          <div class="corner-decoration bottom-left"></div>
          <div class="corner-decoration bottom-right"></div>
        </div>
      </div>
    </div>

    <!-- 海报配置面板 -->
    <div class="poster-config">
      <el-tabs v-model="activeTab">
        <!-- 基础信息 -->
        <el-tab-pane label="基础信息" name="basic">
          <el-form :model="posterData" label-width="80px">
            <el-form-item label="作品标题">
              <el-input v-model="posterData.workTitle" placeholder="请输入作品标题"></el-input>
            </el-form-item>
            <el-form-item label="作品副标题">
              <el-input v-model="posterData.workSubtitle" placeholder="请输入作品副标题"></el-input>
            </el-form-item>
            <el-form-item label="设计师名称">
              <el-input v-model="posterData.designerName" placeholder="请输入设计师名称"></el-input>
            </el-form-item>
          </el-form>
        </el-tab-pane>

        <!-- 背景设置 -->
        <el-tab-pane label="背景设置" name="background">
          <el-form :model="posterData" label-width="80px">
            <el-form-item label="背景图片">
              <el-upload
                class="background-uploader"
                action="/dev-api/upload"
                :show-file-list="false"
                :on-success="handleBackgroundSuccess"
                :before-upload="beforeBackgroundUpload"
              >
                <img v-if="posterData.backgroundUrl" :src="posterData.backgroundUrl" class="background-preview" />
                <i v-else class="el-icon-plus background-uploader-icon"></i>
              </el-upload>
            </el-form-item>
            <el-form-item label="背景颜色">
              <el-color-picker v-model="posterData.backgroundColor"></el-color-picker>
            </el-form-item>
          </el-form>
        </el-tab-pane>

        <!-- 作品图片 -->
        <el-tab-pane label="作品图片" name="workImage">
          <el-form :model="posterData" label-width="80px">
            <el-form-item label="作品图片">
              <el-upload
                class="work-image-uploader"
                action="/dev-api/upload"
                :show-file-list="false"
                :on-success="handleWorkImageSuccess"
                :before-upload="beforeWorkImageUpload"
              >
                <img v-if="posterData.workImageUrl" :src="posterData.workImageUrl" class="work-image-preview" />
                <i v-else class="el-icon-plus work-image-uploader-icon"></i>
              </el-upload>
            </el-form-item>
          </el-form>
        </el-tab-pane>

        <!-- 二维码设置 -->
        <el-tab-pane label="二维码设置" name="qrcode">
          <el-form :model="posterData" label-width="80px">
            <el-form-item label="二维码内容">
              <el-input v-model="posterData.qrContent" placeholder="请输入二维码内容或URL"></el-input>
            </el-form-item>
            <el-form-item label="二维码图片">
              <el-upload
                class="qr-uploader"
                action="/dev-api/upload"
                :show-file-list="false"
                :on-success="handleQrSuccess"
                :before-upload="beforeQrUpload"
              >
                <img v-if="posterData.qrCodeUrl" :src="posterData.qrCodeUrl" class="qr-preview" />
                <i v-else class="el-icon-plus qr-uploader-icon"></i>
              </el-upload>
            </el-form-item>
          </el-form>
        </el-tab-pane>

        <!-- 样式设置 -->
        <el-tab-pane label="样式设置" name="style">
          <el-form :model="posterData" label-width="80px">
            <el-form-item label="主题风格">
              <el-select v-model="posterData.theme" placeholder="请选择主题风格">
                <el-option label="简约风格" value="minimal"></el-option>
                <el-option label="优雅风格" value="elegant"></el-option>
                <el-option label="现代风格" value="modern"></el-option>
                <el-option label="经典风格" value="classic"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="文字颜色">
              <el-color-picker v-model="posterData.textColor"></el-color-picker>
            </el-form-item>
            <el-form-item label="装饰元素">
              <el-switch v-model="posterData.showDecorations"></el-switch>
            </el-form-item>
          </el-form>
        </el-tab-pane>
      </el-tabs>
    </div>

    <!-- 操作按钮 -->
    <div class="poster-actions">
      <el-button @click="resetPoster">重置</el-button>
      <el-button type="primary" @click="generateQrCode">生成二维码</el-button>
      <el-button type="success" @click="downloadPoster">下载海报</el-button>
      <el-button type="info" @click="sharePoster">分享</el-button>
    </div>
  </div>
</template>

<script>
import html2canvas from 'html2canvas'
import QRCode from 'qrcode'

export default {
  name: 'SharePoster',
  props: {
    // 作品数据
    workData: {
      type: Object,
      default: () => ({})
    }
  },
  data() {
    return {
      activeTab: 'basic',
      posterData: {
        // 基础信息
        workTitle: '',
        workSubtitle: '',
        designerName: '',
        
        // 背景设置
        backgroundUrl: '',
        backgroundColor: '#ffffff',
        
        // 作品图片
        workImageUrl: '',
        
        // 二维码设置
        qrContent: '',
        qrCodeUrl: '',
        
        // 样式设置
        theme: 'minimal',
        textColor: '#333333',
        showDecorations: true,
        
        // 海报尺寸
        posterWidth: 375,
        posterHeight: 667
      }
    }
  },
  computed: {
    posterStyle() {
      return {
        width: this.posterData.posterWidth + 'px',
        height: this.posterData.posterHeight + 'px',
        backgroundColor: this.posterData.backgroundColor,
        color: this.posterData.textColor,
        position: 'relative',
        overflow: 'hidden'
      }
    }
  },
  created() {
    this.initPosterData()
  },
  methods: {
    // 初始化海报数据
    initPosterData() {
      if (this.workData && Object.keys(this.workData).length > 0) {
        this.posterData.workTitle = this.workData.title || ''
        this.posterData.workSubtitle = this.workData.subtitle || ''
        this.posterData.designerName = this.workData.designerName || ''
        this.posterData.workImageUrl = this.workData.coverUrl || ''
        this.posterData.qrContent = window.location.href
      }
    },

    // 背景图片上传成功
    handleBackgroundSuccess(response, file) {
      if (response.code === 200) {
        this.posterData.backgroundUrl = response.data.url
      } else {
        this.$message.error('背景图片上传失败')
      }
    },

    // 背景图片上传前校验
    beforeBackgroundUpload(file) {
      const isImage = file.type.startsWith('image/')
      const isLt2M = file.size / 1024 / 1024 < 2

      if (!isImage) {
        this.$message.error('只能上传图片文件！')
        return false
      }
      if (!isLt2M) {
        this.$message.error('图片大小不能超过 2MB！')
        return false
      }
      return true
    },

    // 作品图片上传成功
    handleWorkImageSuccess(response, file) {
      if (response.code === 200) {
        this.posterData.workImageUrl = response.data.url
      } else {
        this.$message.error('作品图片上传失败')
      }
    },

    // 作品图片上传前校验
    beforeWorkImageUpload(file) {
      const isImage = file.type.startsWith('image/')
      const isLt5M = file.size / 1024 / 1024 < 5

      if (!isImage) {
        this.$message.error('只能上传图片文件！')
        return false
      }
      if (!isLt5M) {
        this.$message.error('图片大小不能超过 5MB！')
        return false
      }
      return true
    },

    // 二维码上传成功
    handleQrSuccess(response, file) {
      if (response.code === 200) {
        this.posterData.qrCodeUrl = response.data.url
      } else {
        this.$message.error('二维码上传失败')
      }
    },

    // 二维码上传前校验
    beforeQrUpload(file) {
      const isImage = file.type.startsWith('image/')
      const isLt1M = file.size / 1024 / 1024 < 1

      if (!isImage) {
        this.$message.error('只能上传图片文件！')
        return false
      }
      if (!isLt1M) {
        this.$message.error('图片大小不能超过 1MB！')
        return false
      }
      return true
    },

    // 生成二维码
    async generateQrCode() {
      if (!this.posterData.qrContent) {
        this.$message.warning('请先输入二维码内容')
        return
      }

      try {
        const qrCodeDataUrl = await QRCode.toDataURL(this.posterData.qrContent, {
          width: 120,
          margin: 1,
          color: {
            dark: '#000000',
            light: '#FFFFFF'
          }
        })
        this.posterData.qrCodeUrl = qrCodeDataUrl
        this.$message.success('二维码生成成功')
      } catch (error) {
        this.$message.error('二维码生成失败')
        console.error('QR Code generation error:', error)
      }
    },

    // 下载海报
    async downloadPoster() {
      try {
        const posterFrame = document.querySelector('.poster-frame')
        const canvas = await html2canvas(posterFrame, {
          useCORS: true,
          scale: 2,
          backgroundColor: null
        })

        const link = document.createElement('a')
        link.download = `作品海报_${this.posterData.workTitle || '未命名'}.png`
        link.href = canvas.toDataURL()
        link.click()

        this.$message.success('海报下载成功')
      } catch (error) {
        this.$message.error('海报下载失败')
        console.error('Poster download error:', error)
      }
    },

    // 分享海报
    sharePoster() {
      // 这里可以调用分享API，如微信分享、QQ分享等
      this.$message.info('分享功能开发中...')
    },

    // 重置海报
    resetPoster() {
      this.posterData = {
        workTitle: '',
        workSubtitle: '',
        designerName: '',
        backgroundUrl: '',
        backgroundColor: '#ffffff',
        workImageUrl: '',
        qrContent: '',
        qrCodeUrl: '',
        theme: 'minimal',
        textColor: '#333333',
        showDecorations: true,
        posterWidth: 375,
        posterHeight: 667
      }
      this.initPosterData()
      this.$message.success('海报已重置')
    }
  }
}
</script>

<style scoped>
.share-poster-container {
  display: flex;
  gap: 20px;
  height: 100%;
}

/* 海报预览区域 */
.poster-preview {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #f5f7fa;
  border-radius: 8px;
  padding: 20px;
}

.poster-frame {
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
  transition: all 0.3s ease;
}

.poster-frame:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
}

/* 背景图片 */
.poster-background {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 1;
}

.background-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.background-placeholder {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background: #f0f2f5;
  color: #909399;
  font-size: 14px;
  cursor: pointer;
}

.background-placeholder i {
  font-size: 48px;
  margin-bottom: 10px;
}

/* 作品图片 */
.work-image-container {
  position: absolute;
  top: 50px;
  left: 50%;
  transform: translateX(-50%);
  width: 200px;
  height: 200px;
  z-index: 2;
}

.work-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border-radius: 8px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
}

.work-image-placeholder {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background: #e4e7ed;
  border-radius: 8px;
  color: #909399;
  font-size: 12px;
}

.work-image-placeholder i {
  font-size: 32px;
  margin-bottom: 5px;
}

/* 作品信息 */
.work-info {
  position: absolute;
  top: 270px;
  left: 20px;
  right: 20px;
  text-align: center;
  z-index: 3;
}

.work-title {
  margin: 0 0 8px 0;
  font-size: 20px;
  font-weight: bold;
  line-height: 1.2;
}

.work-subtitle {
  margin: 0 0 12px 0;
  font-size: 14px;
  opacity: 0.8;
  line-height: 1.4;
}

.designer-name {
  margin: 0;
  font-size: 12px;
  opacity: 0.7;
}

/* 二维码区域 */
.qr-code-container {
  position: absolute;
  bottom: 30px;
  left: 50%;
  transform: translateX(-50%);
  text-align: center;
  z-index: 3;
}

.qr-code {
  width: 80px;
  height: 80px;
  background: white;
  border-radius: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.qr-image {
  width: 70px;
  height: 70px;
  object-fit: contain;
}

.qr-placeholder {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: #909399;
  font-size: 10px;
}

.qr-placeholder i {
  font-size: 24px;
  margin-bottom: 2px;
}

.scan-text {
  margin: 8px 0 0 0;
  font-size: 10px;
  opacity: 0.7;
}

/* 装饰元素 */
.decorative-elements {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 1;
  pointer-events: none;
}

.corner-decoration {
  position: absolute;
  width: 40px;
  height: 40px;
  border: 2px solid rgba(255, 255, 255, 0.8);
}

.corner-decoration.top-left {
  top: 10px;
  left: 10px;
  border-right: none;
  border-bottom: none;
}

.corner-decoration.top-right {
  top: 10px;
  right: 10px;
  border-left: none;
  border-bottom: none;
}

.corner-decoration.bottom-left {
  bottom: 10px;
  left: 10px;
  border-right: none;
  border-top: none;
}

.corner-decoration.bottom-right {
  bottom: 10px;
  right: 10px;
  border-left: none;
  border-top: none;
}

/* 海报配置面板 */
.poster-config {
  width: 400px;
  background: white;
  border-radius: 8px;
  padding: 20px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
}

.poster-config .el-tabs {
  height: 100%;
}

.poster-config .el-tab-pane {
  min-height: 300px;
}

/* 上传组件样式 */
.background-uploader,
.work-image-uploader,
.qr-uploader {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  display: inline-block;
}

.background-uploader {
  width: 100%;
  height: 120px;
  line-height: 120px;
}

.work-image-uploader {
  width: 150px;
  height: 150px;
  line-height: 150px;
}

.qr-uploader {
  width: 80px;
  height: 80px;
  line-height: 80px;
}

.background-uploader-icon,
.work-image-uploader-icon,
.qr-uploader-icon {
  font-size: 28px;
  color: #8c939d;
}

.background-preview,
.work-image-preview,
.qr-preview {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

/* 操作按钮 */
.poster-actions {
  position: absolute;
  bottom: 20px;
  left: 20px;
  right: 20px;
  display: flex;
  gap: 10px;
  justify-content: center;
}

/* 响应式设计 */
@media screen and (max-width: 768px) {
  .share-poster-container {
    flex-direction: column;
  }

  .poster-config {
    width: 100%;
  }

  .poster-frame {
    width: 300px !important;
    height: 533px !important;
  }

  .work-image-container {
    width: 150px;
    height: 150px;
  }
}
</style>