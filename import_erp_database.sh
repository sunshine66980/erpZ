#!/bin/bash

# ERP数据库完整导入脚本
# 使用方法: ./import_erp_database.sh [mysql_user] [mysql_password]

# 设置变量
MYSQL_USER=${1:-root}
MYSQL_PASSWORD=${2:-}
DB_NAME="erp_db"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}     ERP数据库导入脚本${NC}"
echo -e "${GREEN}========================================${NC}"

# 检查MySQL连接
echo -e "${YELLOW}1. 检查MySQL连接...${NC}"
if ! mysql -u $MYSQL_USER ${MYSQL_PASSWORD:+-p$MYSQL_PASSWORD} -e "SELECT 1;" &> /dev/null; then
    echo -e "${RED}MySQL连接失败，请检查用户名和密码${NC}"
    exit 1
fi
echo -e "${GREEN}MySQL连接成功${NC}"

# 创建数据库
echo -e "${YELLOW}2. 创建数据库 $DB_NAME...${NC}"
mysql -u $MYSQL_USER ${MYSQL_PASSWORD:+-p$MYSQL_PASSWORD} -e "DROP DATABASE IF EXISTS $DB_NAME; CREATE DATABASE $DB_NAME CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"
echo -e "${GREEN}数据库创建成功${NC}"

# 导入RuoYi基础表
echo -e "${YELLOW}3. 导入RuoYi框架基础表...${NC}"
if [ -f "ERP-ruoyi/sql/ry_20250522.sql" ]; then
    mysql -u $MYSQL_USER ${MYSQL_PASSWORD:+-p$MYSQL_PASSWORD} $DB_NAME < ERP-ruoyi/sql/ry_20250522.sql
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}RuoYi基础表导入成功${NC}"
    else
        echo -e "${RED}RuoYi基础表导入失败${NC}"
        exit 1
    fi
else
    echo -e "${RED}找不到文件 ERP-ruoyi/sql/ry_20250522.sql${NC}"
    exit 1
fi

# 导入ERP业务数据
echo -e "${YELLOW}4. 导入ERP业务表和数据...${NC}"
if [ -f "erp_business_init.sql" ]; then
    mysql -u $MYSQL_USER ${MYSQL_PASSWORD:+-p$MYSQL_PASSWORD} $DB_NAME < erp_business_init.sql
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}ERP业务数据导入成功${NC}"
    else
        echo -e "${RED}ERP业务数据导入失败${NC}"
        exit 1
    fi
else
    echo -e "${RED}找不到文件 erp_business_init.sql${NC}"
    exit 1
fi

# 验证导入结果
echo -e "${YELLOW}5. 验证导入结果...${NC}"
TABLE_COUNT=$(mysql -u $MYSQL_USER ${MYSQL_PASSWORD:+-p$MYSQL_PASSWORD} $DB_NAME -e "SHOW TABLES;" | wc -l)
DICT_COUNT=$(mysql -u $MYSQL_USER ${MYSQL_PASSWORD:+-p$MYSQL_PASSWORD} $DB_NAME -e "SELECT COUNT(*) FROM sys_dict_type;" 2>/dev/null | tail -1)

echo -e "${GREEN}导入完成！${NC}"
echo -e "${GREEN}数据库表总数: $((TABLE_COUNT-1))${NC}"
echo -e "${GREEN}字典类型数量: $DICT_COUNT${NC}"

echo -e "${YELLOW}========================================${NC}"
echo -e "${GREEN}数据库导入成功！${NC}"
echo -e "${YELLOW}默认管理员账号: admin/admin123${NC}"
echo -e "${GREEN}========================================${NC}"