#!/bin/bash
# 服务器部署准备脚本

echo "=== 珠宝定制平台服务器部署准备 ==="

# 1. 创建部署目录
echo "1. 创建部署目录..."
mkdir -p /opt/jewelry-platform
cd /opt/jewelry-platform

# 2. 创建必要目录结构
echo "2. 创建目录结构..."
mkdir -p backend/jar
mkdir -p backend/logs
mkdir -p frontend/dist
mkdir -p frontend/logs
mkdir -p uploadPath
mkdir -p ssl
mkdir -p backup

# 3. 设置权限
echo "3. 设置目录权限..."
chmod 755 backend/jar
chmod 755 backend/logs
chmod 755 frontend/dist
chmod 755 frontend/logs
chmod 755 uploadPath
chmod 700 ssl

# 4. 创建数据目录（可选 - 如果想直接映射Redis数据）
echo "4. 创建Redis数据目录（可选）..."
mkdir -p redis/data
mkdir -p redis/logs

# 5. 安装必要工具
echo "5. 检查并安装必要工具..."
if ! command -v docker &> /dev/null; then
    echo "Docker未安装，请先安装Docker"
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose未安装，请先安装Docker Compose"
    exit 1
fi

# 6. 显示目录结构
echo "6. 创建的目录结构："
tree /opt/jewelry-platform -L 3

echo "=== 准备完成 ==="
echo "请将以下文件上传到对应目录："
echo "- 后端jar包: /opt/jewelry-platform/backend/jar/ruoyi-admin.jar"
echo "- 前端文件: /opt/jewelry-platform/frontend/dist/"
echo "- SSL证书(可选): /opt/jewelry-platform/ssl/"