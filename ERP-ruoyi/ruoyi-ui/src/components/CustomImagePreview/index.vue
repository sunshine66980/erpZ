<template>
  <div v-if="visible" class="custom-image-preview-overlay" @click="handleOverlayClick">
    <div class="custom-image-preview-container" @click.stop>
      <div class="preview-header">
        <span class="preview-title">{{ title }}</span>
        <el-button type="text" class="close-button" @click="close">
          <i class="el-icon-close"></i>
        </el-button>
      </div>
      <div class="preview-content">
        <img :src="imageUrl" :alt="title" class="preview-image" @load="onImageLoad" @error="onImageError" />
      </div>
    </div>
  </div>
</template>

<script>
import { Button, Message } from 'element-ui'

export default {
  name: 'CustomImagePreview',
  components: {
    'el-button': Button
  },
  data() {
    return {
      visible: false,
      imageUrl: '',
      title: '',
      loading: true
    }
  },
  methods: {
    show(options) {
      this.imageUrl = options.url
      this.title = options.title || '图片预览'
      this.visible = true
      this.loading = true
      document.body.style.overflow = 'hidden'
    },
    close() {
      this.visible = false
      this.imageUrl = ''
      this.title = ''
      this.loading = true
      document.body.style.overflow = ''
    },
    handleOverlayClick() {
      this.close()
    },
    onImageLoad() {
      this.loading = false
    },
    onImageError() {
      this.loading = false
      Message.error('图片加载失败')
    }
  },
  beforeDestroy() {
    document.body.style.overflow = ''
  }
}
</script>

<style scoped>
.custom-image-preview-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.8);
  z-index: 9999;
  display: flex;
  align-items: center;
  justify-content: center;
  backdrop-filter: blur(5px);
}

.custom-image-preview-container {
  position: relative;
  max-width: 90vw;
  max-height: 90vh;
  background: white;
  border-radius: 12px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
  overflow: hidden;
  animation: slideIn 0.3s ease-out;
}

@keyframes slideIn {
  from {
    transform: scale(0.8);
    opacity: 0;
  }
  to {
    transform: scale(1);
    opacity: 1;
  }
}

.preview-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 15px 20px;
  background: #fff;
  border-bottom: 1px solid #e4e7ed;
}

.preview-title {
  font-size: 16px;
  font-weight: 600;
  color: #303133;
}

.close-button {
  font-size: 20px;
  color: #909399;
  padding: 0;
  width: 32px;
  height: 32px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s;
}

.close-button:hover {
  background: #f5f7fa;
  color: #606266;
}

.preview-content {
  padding: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 200px;
  background: #f5f7fa;
}

.preview-image {
  max-width: 100%;
  max-height: 70vh;
  object-fit: contain;
  border-radius: 8px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}
</style>