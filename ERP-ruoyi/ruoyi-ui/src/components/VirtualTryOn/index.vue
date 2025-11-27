<template>
  <div class="virtual-try-on-container">
    <div class="camera-container">
      <video ref="videoElement" autoplay playsinline></video>
      <canvas ref="canvasElement" style="display: none;"></canvas>
    </div>
    <div class="model-container">
      <div ref="modelElement" class="model-wrapper"></div>
    </div>
    <div class="controls-container">
      <el-button type="primary" @click="startCamera" :disabled="isCameraActive">启动摄像头</el-button>
      <el-button type="success" @click="loadModel" :disabled="!modelPath || isModelLoaded">加载3D模型</el-button>
      <el-button type="warning" @click="toggleFullscreen">全屏模式</el-button>
      <el-button type="danger" @click="stopCamera" :disabled="!isCameraActive">停止摄像头</el-button>
      <el-button type="info" @click="resetModelPosition">重置模型位置</el-button>
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
    modelPath: {
      type: String,
      default: ''
    },
    productType: {
      type: String,
      default: 'jewelry', // jewelry, watch, etc.
      validator: (value) => ['jewelry', 'watch', 'glasses'].includes(value)
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
      isModelLoaded: false,
      modelScale: 1,
      modelPosition: { x: 0, y: 0, z: 0 }
    }
  },
  mounted() {
    this.initThreeJS()
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
      this.controls.enablePan = false
      this.controls.minDistance = 0.5
      this.controls.maxDistance = 10
      
      // 添加光照
      const ambientLight = new THREE.AmbientLight(0xffffff, 0.5)
      this.scene.add(ambientLight)
      
      const directionalLight1 = new THREE.DirectionalLight(0xffffff, 0.8)
      directionalLight1.position.set(1, 1, 1)
      this.scene.add(directionalLight1)
      
      const directionalLight2 = new THREE.DirectionalLight(0xffffff, 0.5)
      directionalLight2.position.set(-1, 1, -1)
      this.scene.add(directionalLight2)
      
      // 渲染循环
      const animate = () => {
        requestAnimationFrame(animate)
        
        if (this.controls) {
          this.controls.update()
        }
        
        if (this.model) {
          // 轻微旋转模型以展示细节
          this.model.rotation.y += 0.002
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
        this.$modal.msgWarning('请先设置3D模型路径')
        return
      }
      
      // 使用GLTFLoader加载3D模型
      const loader = new GLTFLoader()
      
      // 显示加载状态
      this.$modal.loading('正在加载3D模型，请稍候...')
      
      loader.load(
        this.modelPath,
        (gltf) => {
          // 移除旧模型
          if (this.model) {
            this.scene.remove(this.model)
            this.disposeModel(this.model)
          }
          
          // 获取模型
          this.model = gltf.scene
          
          // 根据产品类型设置默认位置和缩放
          this.setDefaultModelPosition()
          
          // 添加到场景
          this.scene.add(this.model)
          
          this.isModelLoaded = true
          this.$modal.closeLoading()
          this.$modal.msgSuccess('3D模型加载成功')
        },
        (xhr) => {
          console.log((xhr.loaded / xhr.total * 100) + '% loaded')
        },
        (error) => {
          console.error('模型加载失败:', error)
          this.$modal.closeLoading()
          this.$modal.msgError('3D模型加载失败，请检查模型文件')
        }
      )
    },
    
    /**
     * 设置默认模型位置和缩放
     */
    setDefaultModelPosition() {
      if (!this.model) return
      
      // 根据产品类型设置不同的默认位置和缩放
      switch (this.productType) {
        case 'jewelry':
          // 首饰默认位置（脸部前方）
          this.modelScale = 0.5
          this.modelPosition = { x: 0, y: -0.5, z: 2 }
          break
        case 'watch':
          // 手表默认位置（手部前方）
          this.modelScale = 0.8
          this.modelPosition = { x: 0, y: 0, z: 2 }
          break
        case 'glasses':
          // 眼镜默认位置（脸部前方）
          this.modelScale = 1.0
          this.modelPosition = { x: 0, y: -0.2, z: 1.5 }
          break
        default:
          this.modelScale = 1.0
          this.modelPosition = { x: 0, y: 0, z: 2 }
      }
      
      // 应用位置和缩放
      this.model.scale.set(this.modelScale, this.modelScale, this.modelScale)
      this.model.position.set(this.modelPosition.x, this.modelPosition.y, this.modelPosition.z)
    },
    
    /**
     * 重置模型位置
     */
    resetModelPosition() {
      this.setDefaultModelPosition()
      this.$modal.msgSuccess('模型位置已重置')
    },
    
    /**
     * 释放模型资源
     */
    disposeModel(model) {
      model.traverse((object) => {
        if (object.geometry) object.geometry.dispose()
        if (object.material) {
          if (Array.isArray(object.material)) {
            object.material.forEach(material => material.dispose())
          } else {
            object.material.dispose()
          }
        }
      })
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
        this.disposeModel(this.model)
      }
    }
  }
}
</script>

<style scoped>
.virtual-try-on-container {
  display: flex;
  flex-direction: column;
  height: 100vh;
  width: 100vw;
  overflow: hidden;
  background-color: #000;
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
  pointer-events: auto;
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
  flex-wrap: wrap;
  justify-content: center;
}

.controls-container .el-button {
  background-color: rgba(0, 0, 0, 0.7);
  border-color: rgba(255, 255, 255, 0.3);
  color: #fff;
  transition: all 0.3s ease;
}

.controls-container .el-button:hover {
  background-color: rgba(0, 0, 0, 0.9);
  border-color: rgba(255, 255, 255, 0.5);
  transform: translateY(-2px);
}

.controls-container .el-button:disabled {
  background-color: rgba(0, 0, 0, 0.3);
  border-color: rgba(255, 255, 255, 0.1);
  color: rgba(255, 255, 255, 0.5);
  cursor: not-allowed;
}
</style>