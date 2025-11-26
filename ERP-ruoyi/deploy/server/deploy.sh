#!/bin/bash

# 部署脚本 - 自动化部署珠宝定制平台

set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 日志函数
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查必要文件
check_files() {
    log_info "检查部署文件..."
    
    if [ ! -f "backend/jar/ruoyi-admin.jar" ]; then
        log_error "后端jar包不存在: backend/jar/ruoyi-admin.jar"
        exit 1
    fi
    
    if [ ! -d "frontend/dist" ] || [ -z "$(ls -A frontend/dist)" ]; then
        log_error "前端文件不存在: frontend/dist"
        exit 1
    fi
    
    log_info "所有必要文件检查通过"
}

# 创建必要目录
create_dirs() {
    log_info "创建必要目录..."
    mkdir -p backend/logs
    mkdir -p frontend/logs
    mkdir -p uploadPath
    mkdir -p ssl
    log_info "目录创建完成"
}

# 备份旧版本
backup_old_version() {
    log_info "备份旧版本..."
    
    if [ -d "backup" ]; then
        rm -rf backup
    fi
    
    mkdir -p backup
    
    if [ -f "backend/jar/ruoyi-admin.jar" ]; then
        cp backend/jar/ruoyi-admin.jar backup/ 2>/dev/null || true
    fi
    
    if [ -d "frontend/dist" ]; then
        cp -r frontend/dist backup/ 2>/dev/null || true
    fi
    
    log_info "备份完成"
}

# 清理旧容器和镜像
cleanup() {
    log_info "清理旧容器和镜像..."
    
    # 停止并删除容器
    docker-compose down --remove-orphans
    
    # 删除旧镜像
    docker rmi $(docker images -q deploy_jw-backend) 2>/dev/null || true
    docker rmi $(docker images -q deploy_jw-frontend) 2>/dev/null || true
    
    log_info "清理完成"
}

# 构建和启动服务
deploy_services() {
    log_info "构建和启动服务..."
    
    # 构建镜像
    docker-compose build --no-cache
    
    # 启动服务
    docker-compose up -d
    
    log_info "服务启动完成"
}

# 健康检查
health_check() {
    log_info "进行健康检查..."
    
    # 等待服务启动
    sleep 30
    
    # 检查服务状态
    if docker-compose ps | grep -q "Up"; then
        log_info "服务运行正常"
        
        # 检查端口
        if netstat -tuln | grep -q ":443 "; then
            log_info "前端端口443正常"
        else
            log_warn "前端端口443未检测到"
        fi
        
        if netstat -tuln | grep -q ":48080 "; then
            log_info "后端端口48080正常"
        else
            log_warn "后端端口48080未检测到"
        fi
        
        if netstat -tuln | grep -q ":9736 "; then
            log_info "Redis端口9736正常"
        else
            log_warn "Redis端口9736未检测到"
        fi
    else
        log_error "服务启动失败"
        docker-compose logs
        exit 1
    fi
}

# 显示部署信息
show_info() {
    log_info "部署完成！"
    echo ""
    echo "=========================================="
    echo "访问地址："
    echo "  前端: https://localhost"
    echo "  后端API: http://localhost:48080"
    echo "  API文档: http://localhost:48080/swagger-ui.html"
    echo "  数据库监控: http://localhost:48080/druid"
    echo ""
    echo "服务状态："
    docker-compose ps
    echo "=========================================="
}

# 主函数
main() {
    log_info "开始部署珠宝定制平台..."
    
    check_files
    create_dirs
    backup_old_version
    cleanup
    deploy_services
    health_check
    show_info
    
    log_info "部署完成！"
}

# 执行主函数
main "$@"