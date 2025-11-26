#!/bin/bash

# 简化版前端打包脚本 - 只构建并压缩ZIP

set -e

# 获取脚本所在目录的绝对路径
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 前端目录（相对于脚本位置）
FRONTEND_DIR="$SCRIPT_DIR/../ruoyi-ui"

# 输出目录（与后端部署结构保持一致）
OUTPUT_DIR="$SCRIPT_DIR/server/frontend"

# 时间戳
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# ZIP文件名
ZIP_NAME="frontend-dist-$TIMESTAMP.zip"

echo "开始前端打包..."
echo "脚本目录: $SCRIPT_DIR"
echo "前端目录: $FRONTEND_DIR"
echo "输出目录: $OUTPUT_DIR"

# 检查前端目录是否存在
if [ ! -d "$FRONTEND_DIR" ]; then
    echo "错误：前端目录不存在: $FRONTEND_DIR"
    exit 1
fi

# 进入前端目录
cd "$FRONTEND_DIR"

# 安装依赖
if [ ! -d "node_modules" ]; then
    echo "安装依赖..."
    npm install
fi

# 构建生产版本
echo "构建生产版本..."
npm run build:prod

# 检查构建结果
if [ ! -d "dist" ]; then
    echo "构建失败：dist目录不存在"
    exit 1
fi

# 创建输出目录
mkdir -p "$OUTPUT_DIR"

# 创建ZIP包
echo "创建ZIP包: $ZIP_NAME"
zip -r "$OUTPUT_DIR/$ZIP_NAME" dist/

echo "打包完成！"
echo "ZIP文件位置: $OUTPUT_DIR/$ZIP_NAME"
echo "文件大小: $(ls -lh "$OUTPUT_DIR/$ZIP_NAME" | awk '{print $5}')"