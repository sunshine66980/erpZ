# ERP数据库导入说明

## 问题说明
如果在导入 `erp_business_init.sql` 时遇到错误 `erp_db.sys_dict_type' doesn't exist`，这是因为ERP业务数据依赖RuoYi框架的基础表结构。

## 解决方案

### 正确的导入顺序

**1. 创建数据库**
```sql
CREATE DATABASE erp_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE erp_db;
```

**2. 导入RuoYi框架基础表**
```bash
mysql -u root -p erp_db < ERP-ruoyi/sql/ry_20250522.sql
```

**3. 导入ERP业务表和数据**
```bash
mysql -u root -p erp_db < erp_business_init.sql
```

### 文件说明

- `ERP-ruoyi/sql/ry_20250522.sql` - RuoYi框架基础表结构和初始数据
  - 包含 `sys_dict_type` 和 `sys_dict_data` 字典表
  - 包含用户、部门、角色、菜单等基础系统表
  - 包含系统权限相关表结构

- `erp_business_init.sql` - ERP业务表结构和初始数据
  - 包含产品、采购、库存、销售、财务等业务表
  - 包含ERP相关的字典类型和字典数据
  - 依赖RuoYi框架的字典表结构

### 验证导入结果

导入完成后，可以检查以下表是否存在：

```sql
-- 检查基础表
SHOW TABLES LIKE 'sys_%';

-- 检查ERP业务表
SHOW TABLES LIKE 'product_%';
SHOW TABLES LIKE 'purchase_%';
SHOW TABLES LIKE 'inventory_%';
SHOW TABLES LIKE 'sales_%';
SHOW TABLES LIKE 'finance_%';

-- 检查字典数据
SELECT COUNT(*) FROM sys_dict_type;
SELECT COUNT(*) FROM sys_dict_data;
```

### 注意事项

1. **必须按顺序导入**：先导入基础框架，再导入业务数据
2. **字符集**：确保数据库使用 `utf8mb4` 字符集
3. **权限**：确保MySQL用户有CREATE、INSERT、UPDATE权限
4. **备份**：如果有现有数据，请先备份

### 常见错误

- `sys_dict_type doesn't exist` - 未先导入RuoYi基础表
- `Table 'xxx' doesn't exist` - 表创建失败或导入顺序错误
- `Duplicate entry` - 重复导入，需要清空数据库

### 完整的表列表

导入成功后，应该有以下表：

**系统基础表 (sys_*)**
- sys_dict_type, sys_dict_data (字典表)
- sys_user, sys_role, sys_dept (用户权限)
- sys_menu, sys_config (系统配置)
- 等其他RuoYi框架表

**ERP业务表**
- product_* (产品管理)
- purchase_* (采购管理) 
- inventory_* (库存管理)
- sales_* (销售管理)
- finance_* (财务管理)
- warehouse_info, supplier_info, customer_info (基础信息)

如果仍有问题，请检查MySQL版本兼容性和SQL语法。