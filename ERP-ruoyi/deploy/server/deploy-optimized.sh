#!/bin/bash

# 优化部署脚本 - 支持增量部署和选择性更新

set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
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

log_debug() {
    echo -e "${BLUE}[DEBUG]${NC} $1"
}

# 显示帮助信息
show_help() {
    echo "用法: $0 [选项]"
    echo ""
    echo "选项:"
    echo "  -h, --help          显示帮助信息"
    echo "  -b, --backend       仅部署后端"
    echo "  -f, --frontend      仅部署前端"
    echo "  -c, --config        仅更新配置文件"
    echo "  -n, --nginx         仅更新Nginx配置"
    echo "  --no-cache          不使用Docker缓存构建"
    echo "  --no-backup         跳过备份步骤"
    echo "  --no-cleanup        跳过清理步骤"
    echo "  --quick             快速部署模式（跳过健康检查）"
    echo ""
    echo "示例:"
    echo "  $0                  完整部署"
    echo "  $0 -b               仅部署后端"
    echo "  $0 -f --no-cache    仅部署前端并重新构建镜像"
    echo "  $0 -c --no-backup   仅更新配置文件且不备份"
}

# 解析命令行参数
BACKEND_ONLY=false
FRONTEND_ONLY=false
CONFIG_ONLY=false
NGINX_ONLY=false
NO_CACHE=false
NO_BACKUP=false
NO_CLEANUP=false
QUICK_MODE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -b|--backend)
            BACKEND_ONLY=true
            shift
            ;;
        -f|--frontend)
            FRONTEND_ONLY=true
            shift
            ;;
        -c|--config)
            CONFIG_ONLY=true
            shift
            ;;
        -n|--nginx)
            NGINX_ONLY=true
            shift
            ;;
        --no-cache)
            NO_CACHE=true
            shift
            ;;
        --no-backup)
            NO_BACKUP=true
            shift
            ;;
        --no-cleanup)
            NO_CLEANUP=true
            shift
            ;;
        --quick)
            QUICK_MODE=true
            shift
            ;;
        *)
            log_error "未知选项: $1"
            show_help
            exit 1
            ;;
    esac
done

# 检查参数冲突
if [[ "$BACKEND_ONLY" == true && "$FRONTEND_ONLY" == true ]]; then
    log_error "不能同时指定 -b 和 -f 选项"
    exit 1
fi

if [[ "$CONFIG_ONLY" == true && ("$BACKEND_ONLY" == true || "$FRONTEND_ONLY" == true) ]]; then
    log_error "不能同时指定 -c 和 -b/-f 选项"
    exit 1
fi

# 检查必要文件
check_files() {
    log_info "检查部署文件..."
    
    if [[ "$BACKEND_ONLY" == true || "$CONFIG_ONLY" == false ]]; then
        if [ ! -f "backend/jar/ruoyi-admin.jar" ]; then
            log_error "后端jar包不存在: backend/jar/ruoyi-admin.jar"
            exit 1
        fi
    fi
    
    if [[ "$FRONTEND_ONLY" == true || "$CONFIG_ONLY" == false ]]; then
        if [ ! -d "frontend/dist" ] || [ -z "$(ls -A frontend/dist)" ]; then
            log_error "前端文件不存在: frontend/dist"
            exit 1
        fi
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
    if [[ "$NO_BACKUP" == true ]]; then
        log_info "跳过备份步骤"
        return
    fi
    
    log_info "备份旧版本..."
    
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    BACKUP_DIR="backup_$TIMESTAMP"
    
    mkdir -p "$BACKUP_DIR"
    
    if [[ "$BACKEND_ONLY" == false && "$CONFIG_ONLY" == false ]]; then
        if [ -f "backend/jar/ruoyi-admin.jar" ]; then
            cp backend/jar/ruoyi-admin.jar "$BACKUP_DIR/" 2>/dev/null || true
            log_debug "备份后端jar包"
        fi
    fi
    
    if [[ "$FRONTEND_ONLY" == false && "$CONFIG_ONLY" == false ]]; then
        if [ -d "frontend/dist" ]; then
            cp -r frontend/dist "$BACKUP_DIR/" 2>/dev/null || true
            log_debug "备份前端文件"
        fi
    fi
    
    # 总是备份配置文件
    if [ -f "docker-compose.yml" ]; then
        cp docker-compose.yml "$BACKUP_DIR/" 2>/dev/null || true
    fi
    
    if [ -f "frontend/nginx.conf" ]; then
        cp frontend/nginx.conf "$BACKUP_DIR/" 2>/dev/null || true
    fi
    
    log_info "备份完成: $BACKUP_DIR"
}

# 清理旧容器和镜像
cleanup() {
    if [[ "$NO_CLEANUP" == true ]]; then
        log_info "跳过清理步骤"
        return
    fi
    
    log_info "清理旧容器和镜像..."
    
    # 停止并删除容器
    docker-compose down --remove-orphans
    
    # 仅在需要时删除镜像
    if [[ "$NO_CACHE" == true ]]; then
        log_info "删除旧镜像..."
        docker rmi $(docker images -q deploy_jw-backend) 2>/dev/null || true
        docker rmi $(docker images -q deploy_jw-frontend) 2>/dev/null || true
    fi
    
    log_info "清理完成"
}

# 构建和启动服务
deploy_services() {
    log_info "构建和启动服务..."
    
    BUILD_ARGS=""
    if [[ "$NO_CACHE" == true ]]; then
        BUILD_ARGS="--no-cache"
    fi
    
    if [[ "$BACKEND_ONLY" == true ]]; then
        log_info "仅构建和启动后端服务..."
        docker-compose build $BUILD_ARGS jw-backend
        docker-compose up -d jw-backend
    elif [[ "$FRONTEND_ONLY" == true ]]; then
        log_info "仅构建和启动前端服务..."
        docker-compose build $BUILD_ARGS jw-frontend
        docker-compose up -d jw-frontend
    elif [[ "$CONFIG_ONLY" == true ]]; then
        log_info "仅更新配置文件..."
        docker-compose up -d
    elif [[ "$NGINX_ONLY" == true ]]; then
        log_info "仅更新Nginx配置..."
        docker-compose build $BUILD_ARGS jw-frontend
        docker-compose up -d jw-frontend
    else
        log_info "构建和启动所有服务..."
        docker-compose build $BUILD_ARGS
        docker-compose up -d
    fi
    
    log_info "服务启动完成"
}

# 健康检查
health_check() {
    if [[ "$QUICK_MODE" == true ]]; then
        log_info "快速模式，跳过健康检查"
        return
    fi
    
    log_info "进行健康检查..."
    
    # 等待服务启动
    sleep 10
    
    # 检查服务状态
    if docker-compose ps | grep -q "Up"; then
        log_info "服务运行正常"
        
        # 根据部署模式检查相应端口
        if [[ "$BACKEND_ONLY" == false ]]; then
            if netstat -tuln | grep -q ":443 "; then
                log_info "前端端口443正常"
            else
                log_warn "前端端口443未检测到"
            fi
        fi
        
        if [[ "$FRONTEND_ONLY" == false ]]; then
            if netstat -tuln | grep -q ":48080 "; then
                log_info "后端端口48080正常"
            else
                log_warn "后端端口48080未检测到"
            fi
        fi
        
        if [[ "$CONFIG_ONLY" == false ]]; then
            if netstat -tuln | grep -q ":9736 "; then
                log_info "Redis端口9736正常"
            else
                log_warn "Redis端口9736未检测到"
            fi
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
    if [[ "$BACKEND_ONLY" == false ]]; then
        echo "  前端: https://localhost"
    fi
    if [[ "$FRONTEND_ONLY" == false ]]; then
        echo "  后端API: http://localhost:48080"
        echo "  API文档: http://localhost:48080/swagger-ui.html"
        echo "  数据库监控: http://localhost:48080/druid"
    fi
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