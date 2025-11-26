<template>
  <div class="demo-container">
    <div class="demo-header">
      <div class="demo-title">
        <h2>💎 按需定制珠宝平台功能演示</h2>
        <p>无需登录即可预览平台核心功能</p>
      </div>
      <div class="demo-actions">
        <el-button type="primary" @click="goToLogin" icon="el-icon-user">
          返回登录
        </el-button>
      </div>
    </div>
    <div class="demo-content">
      <iframe 
        src="/html/pages/home.html" 
        class="demo-iframe"
        frameborder="0"
        scrolling="auto"
      ></iframe>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Demo',
  methods: {
    goToLogin() {
      this.$router.push('/login')
    }
  }
}
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
.demo-container {
  height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: #f5f5f5;
}

.demo-header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  
  .demo-title {
    h2 {
      margin: 0 0 5px 0;
      font-size: 1.5em;
      font-weight: 300;
    }
    
    p {
      margin: 0;
      opacity: 0.9;
      font-size: 0.9em;
    }
  }
  
  .demo-actions {
    .el-button {
      background: rgba(255, 255, 255, 0.2);
      border: 1px solid rgba(255, 255, 255, 0.3);
      color: white;
      
      &:hover {
        background: rgba(255, 255, 255, 0.3);
        border-color: rgba(255, 255, 255, 0.5);
      }
    }
  }
}

.demo-content {
  flex: 1;
  overflow: hidden;
  position: relative;
  
  .demo-iframe {
    width: 100%;
    height: 100%;
    border: none;
    background: white;
  }
}

@media (max-width: 768px) {
  .demo-header {
    flex-direction: column;
    text-align: center;
    
    .demo-title {
      h2 {
        font-size: 1.2em;
      }
      
      p {
        font-size: 0.8em;
      }
    }
    
    .demo-actions {
      margin-top: 15px;
    }
  }
}

@media (max-width: 480px) {
  .demo-header {
    padding: 15px;
    
    .demo-title {
      h2 {
        font-size: 1em;
      }
    }
  }
}
</style>