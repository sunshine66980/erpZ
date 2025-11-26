-- ===================================================================
-- ERP系统菜单配置
-- ===================================================================

-- 使用ERP数据库
USE erp_db;

-- 产品管理主菜单
INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES
('产品管理', 0, 1, 'product', NULL, 'M', '0', '0', NULL, 'product', 'admin', NOW(), '', NULL, '产品管理目录');

-- 获取产品管理主菜单ID
SET @product_main_menu_id = LAST_INSERT_ID();

-- 产品信息菜单
INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES
('产品信息', @product_main_menu_id, 1, 'product', 'product/product/index', 'C', '0', '0', 'product:product:list', 'list', 'admin', NOW(), '', NULL, '产品信息菜单');

-- 获取产品信息菜单ID
SET @product_info_menu_id = LAST_INSERT_ID();

-- 产品信息按钮权限
INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES
('产品查询', @product_info_menu_id, 1, '#', '', 'F', '0', '0', 'product:product:query', '#', 'admin', NOW(), '', NULL, ''),
('产品新增', @product_info_menu_id, 2, '#', '', 'F', '0', '0', 'product:product:add', '#', 'admin', NOW(), '', NULL, ''),
('产品修改', @product_info_menu_id, 3, '#', '', 'F', '0', '0', 'product:product:edit', '#', 'admin', NOW(), '', NULL, ''),
('产品删除', @product_info_menu_id, 4, '#', '', 'F', '0', '0', 'product:product:remove', '#', 'admin', NOW(), '', NULL, ''),
('产品导出', @product_info_menu_id, 5, '#', '', 'F', '0', '0', 'product:product:export', '#', 'admin', NOW(), '', NULL, '');

-- 产品图片管理菜单
INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES
('产品图片', @product_main_menu_id, 2, 'images', 'product/images/index', 'C', '0', '0', 'product:images:list', 'picture', 'admin', NOW(), '', NULL, '产品图片管理菜单');

-- 获取产品图片菜单ID
SET @product_images_menu_id = LAST_INSERT_ID();

-- 产品图片按钮权限
INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES
('图片查询', @product_images_menu_id, 1, '#', '', 'F', '0', '0', 'product:images:query', '#', 'admin', NOW(), '', NULL, ''),
('图片新增', @product_images_menu_id, 2, '#', '', 'F', '0', '0', 'product:images:add', '#', 'admin', NOW(), '', NULL, ''),
('图片修改', @product_images_menu_id, 3, '#', '', 'F', '0', '0', 'product:images:edit', '#', 'admin', NOW(), '', NULL, ''),
('图片删除', @product_images_menu_id, 4, '#', '', 'F', '0', '0', 'product:images:remove', '#', 'admin', NOW(), '', NULL, ''),
('图片导出', @product_images_menu_id, 5, '#', '', 'F', '0', '0', 'product:images:export', '#', 'admin', NOW(), '', NULL, '');

-- 为管理员角色分配产品管理权限
INSERT INTO sys_role_menu (role_id, menu_id) 
SELECT 1, menu_id FROM sys_menu 
WHERE menu_name IN ('产品管理', '产品信息', '产品查询', '产品新增', '产品修改', '产品删除', '产品导出', '产品图片', '图片查询', '图片新增', '图片修改', '图片删除', '图片导出');