@echo off
chcp 65001
setlocal enabledelayedexpansion

REM ERP数据库导入脚本 (Windows版本)
REM 使用方法: import_erp_database.bat [mysql_user] [mysql_password]

set MYSQL_USER=%1
set MYSQL_PASSWORD=%2
set DB_NAME=erp_db

if "%MYSQL_USER%"=="" set MYSQL_USER=root

echo ========================================
echo      ERP数据库导入脚本
echo ========================================

REM 检查MySQL是否可用
echo 1. 检查MySQL连接...
mysql -u %MYSQL_USER% %MYSQL_PASSWORD% -e "SELECT 1;" >nul 2>&1
if errorlevel 1 (
    echo MySQL连接失败，请检查用户名和密码
    pause
    exit /b 1
)
echo MySQL连接成功

REM 创建数据库
echo 2. 创建数据库 %DB_NAME%...
mysql -u %MYSQL_USER% %MYSQL_PASSWORD% -e "DROP DATABASE IF EXISTS %DB_NAME%; CREATE DATABASE %DB_NAME% CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"
if errorlevel 1 (
    echo 数据库创建失败
    pause
    exit /b 1
)
echo 数据库创建成功

REM 导入RuoYi基础表
echo 3. 导入RuoYi框架基础表...
if not exist "ERP-ruoyi\sql\ry_20250522.sql" (
    echo 找不到文件 ERP-ruoyi\sql\ry_20250522.sql
    pause
    exit /b 1
)
mysql -u %MYSQL_USER% %MYSQL_PASSWORD% %DB_NAME% < ERP-ruoyi\sql\ry_20250522.sql
if errorlevel 1 (
    echo RuoYi基础表导入失败
    pause
    exit /b 1
)
echo RuoYi基础表导入成功

REM 导入ERP业务数据
echo 4. 导入ERP业务表和数据...
if not exist "erp_business_init.sql" (
    echo 找不到文件 erp_business_init.sql
    pause
    exit /b 1
)
mysql -u %MYSQL_USER% %MYSQL_PASSWORD% %DB_NAME% < erp_business_init.sql
if errorlevel 1 (
    echo ERP业务数据导入失败
    pause
    exit /b 1
)
echo ERP业务数据导入成功

REM 验证导入结果
echo 5. 验证导入结果...
echo 导入完成！
echo 默认管理员账号: admin/admin123
echo ========================================
echo 数据库导入成功！
echo ========================================
pause