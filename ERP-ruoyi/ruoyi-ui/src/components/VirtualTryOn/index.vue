<template>
  <div class="virtual-try-on-container" v-if="visible">
    <div class="close-button" @click="handleClose">
      <i class="el-icon-close"></i>
    </div>
    <div class="camera-container">
      <video ref="videoElement" autoplay playsinline></video>
      <canvas ref="canvasElement" style="display: none;"></canvas>
    </div>
    <div class="model-container">
      <div ref="modelElement" class="model-wrapper"></div>
    </div>
    <div class="controls-container">
      <el-button type="primary" @click="startCamera" :disabled="isCameraActive">启动摄像头</el-button>
      <el-button type="success" @click="loadModel" :disabled="isModelLoaded || !modelPath">加载3D模型</el-button>
      <el-button type="warning" @click="toggleFullscreen">全屏模式</el-button>
      <el-button type="danger" @click="stopCamera" :disabled="!isCameraActive">停止摄像头</el-button>
    </div>
    <div class="product-info">
      <h3>{{ productName || '产品虚拟试戴' }}</h3>
      <p v-if="productId">产品ID: {{ productId }}</p>
    </div>
  </div>
</template>

<script>
import * as THREE from 'three'
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js'
import { GLTFLoader } from 'three/examples/jsm/loaders/GLTFLoader.js'

export default {
  name: 'VirtualTryOn',
  props: {
    visible: {
      type: Boolean,
      default: false
    },
    productId: {
      type: [String, Number],
      default: ''
    },
    productName: {
      type: String,
      default: ''
    },
    modelPath: {
      type: String,
      default: ''
    }
  },
  data() {
    return {
      videoStream: null,
      scene: null,
      camera: null,
      renderer: null,
      controls: null,
      model: null,
      isCameraActive: false,
      isModelLoaded: false
    }
  },
  mounted() {
    if (this.visible) {
      this.initThreeJS()
    }
  },
  watch: {
    visible(newVal) {
      if (newVal) {
        this.initThreeJS()
      } else {
        this.stopCamera()
        this.disposeThreeJS()
      }
    }
  },
  beforeDestroy() {
    this.stopCamera()
    this.disposeThreeJS()
  },
  methods: {
    /**
     * 初始化Three.js场景
     */
    initThreeJS() {
      // 创建场景
      this.scene = new THREE.Scene()
      
      // 创建相机
      this.camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000)
      this.camera.position.z = 5
      
      // 创建渲染器
      this.renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true })
      this.renderer.setSize(window.innerWidth, window.innerHeight)
      this.renderer.setClearColor(0x000000, 0)
      this.$refs.modelElement.appendChild(this.renderer.domElement)
      
      // 添加轨道控制器
      this.controls = new OrbitControls(this.camera, this.renderer.domElement)
      this.controls.enableDamping = true
      this.controls.dampingFactor = 0.05
      
      // 添加光照
      const ambientLight = new THREE.AmbientLight(0xffffff, 0.5)
      this.scene.add(ambientLight)
      
      const directionalLight = new THREE.DirectionalLight(0xffffff, 0.8)
      directionalLight.position.set(1, 1, 1)
      this.scene.add(directionalLight)
      
      // 渲染循环
      const animate = () => {
        requestAnimationFrame(animate)
        
        if (this.controls) {
          this.controls.update()
        }
        
        if (this.model) {
          // 可以在这里添加模型动画
          this.model.rotation.y += 0.005
        }
        
        this.renderer.render(this.scene, this.camera)
      }
      
      animate()
      
      // 窗口大小调整
      window.addEventListener('resize', this.onWindowResize)
    },
    
    /**
     * 窗口大小调整处理
     */
    onWindowResize() {
      const width = window.innerWidth
      const height = window.innerHeight
      
      this.camera.aspect = width / height
      this.camera.updateProjectionMatrix()
      
      this.renderer.setSize(width, height)
    },
    
    /**
     * 启动摄像头
     */
    async startCamera() {
      try {
        this.videoStream = await navigator.mediaDevices.getUserMedia({
          video: {
            width: 1280,
            height: 720,
            facingMode: 'user'
          }
        })
        
        const videoElement = this.$refs.videoElement
        videoElement.srcObject = this.videoStream
        videoElement.play()
        
        this.isCameraActive = true
        this.$modal.msgSuccess('摄像头启动成功')
      } catch (error) {
        console.error('摄像头启动失败:', error)
        this.$modal.msgError('摄像头启动失败，请检查摄像头权限')
      }
    },
    
    /**
     * 停止摄像头
     */
    stopCamera() {
      if (this.videoStream) {
        const tracks = this.videoStream.getTracks()
        tracks.forEach(track => track.stop())
        this.videoStream = null
      }
      
      const videoElement = this.$refs.videoElement
      videoElement.srcObject = null
      
      this.isCameraActive = false
      this.$modal.msgSuccess('摄像头已停止')
    },
    
    /**
     * 加载3D模型
     */
    loadModel() {
      if (!this.modelPath) {
        this.$modal.msgWarning('请先生成3D模型')
        return
      }
      
      // 使用GLTFLoader加载3D模型
      const loader = new GLTFLoader()
      
      // 加载模型
      loader.load(
        this.modelPath,
        (gltf) => {
          // 清除之前的模型
          if (this.model) {
            this.scene.remove(this.model)
            this.model.geometry.dispose()
            this.model.material.dispose()
          }
          
          // 获取模型
          this.model = gltf.scene
          
          // 调整模型位置和大小
          this.model.position.set(0, 0, 2) // 调整模型位置，使其看起来像戴在手上
          this.model.scale.set(1, 1, 1) // 调整模型大小
          
          // 添加模型到场景
          this.scene.add(this.model)
          
          this.isModelLoaded = true
          this.$modal.msgSuccess('3D模型加载成功，可以开始虚拟试戴')
        },
        (xhr) => {
          // 加载进度
          console.log((xhr.loaded / xhr.total * 100) + '% loaded')
        },
        (error) => {
          // 加载错误
          console.error('3D模型加载失败:', error)
          this.$modal.msgError('3D模型加载失败，请检查模型文件是否正确')
        }
      )
    },
    
    /**
     * 关闭组件
     */
    handleClose() {
      this.$emit('close')
    },
    
    /**
     * 切换全屏模式
     */
    toggleFullscreen() {
      if (!document.fullscreenElement) {
        document.documentElement.requestFullscreen()
      } else {
        if (document.exitFullscreen) {
          document.exitFullscreen()
        }
      }
    },
    
    /**
     * 释放Three.js资源
     */
    disposeThreeJS() {
      window.removeEventListener('resize', this.onWindowResize)
      
      if (this.controls) {
        this.controls.dispose()
      }
      
      if (this.renderer) {
        this.renderer.dispose()
      }
      
      if (this.model) {
        this.scene.remove(this.model)
        this.model.geometry.dispose()
        this.model.material.dispose()
      }
    }
  }
}
</script>

<style scoped>
.virtual-try-on-container {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100vh;
  background: #000;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  z-index: 9999;
}

.close-button {
  position: absolute;
  top: 20px;
  right: 20px;
  width: 40px;
  height: 40px;
  background: rgba(255, 255, 255, 0.2);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
  z-index: 10000;
}

.close-button:hover {
  background: rgba(255, 255, 255, 0.3);
  transform: scale(1.1);
}

.close-button i {
  color: white;
  font-size: 20px;
}

.product-info {
  position: absolute;
  top: 80px;
  left: 20px;
  color: white;
  text-align: left;
  z-index: 10000;
}

.product-info h3 {
  margin: 0 0 10px 0;
  font-size: 18px;
  font-weight: bold;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
}

.product-info p {
  margin: 0;
  font-size: 14px;
  opacity: 0.8;
  text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
}

.camera-container {
  flex: 1;
  position: relative;
  overflow: hidden;
}

video {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.model-container {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
}

.model-wrapper {
  width: 100%;
  height: 100%;
}

.controls-container {
  position: absolute;
  bottom: 20px;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  gap: 10px;
  z-index: 100;
}

.controls-container .el-button {
  background-color: rgba(0, 0, 0, 0.7);
  border-color: rgba(255, 255, 255, 0.3);
  color: #fff;
}

.controls-container .el-button:hover {
  background-color: rgba(0, 0, 0, 0.9);
  border-color: rgba(255, 255, 255, 0.5);
}
</style>