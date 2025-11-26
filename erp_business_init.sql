-- ===================================================================
-- MySQL 8 ERP Database for RuoYi System
-- 适配RuoYi若依框架的ERP业务表
-- 
-- 重要提醒：请确保已先导入 RuoYi 框架基础表！
-- 导入顺序：
-- 1. CREATE DATABASE erp_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
-- 2. USE erp_db;
-- 3. SOURCE ERP-ruoyi/sql/ry_20250522.sql;  -- 先导入基础框架
-- 4. SOURCE erp_business_init.sql;          -- 再导入ERP业务数据
-- 
-- 使用RuoYi现有的字典表体系(sys_dict_type, sys_dict_data)
-- ===================================================================

-- 使用ERP数据库
USE erp_db;

-- ================================
-- ERP业务字典类型初始化
-- ================================

-- 产品管理字典类型
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('产品类型', 'erp_product_type', '0', 'admin', NOW(), '产品类型列表');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('产品单位', 'erp_product_unit', '0', 'admin', NOW(), '产品单位列表');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('产品类目', 'erp_product_category', '0', 'admin', NOW(), '产品业务类目');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('产品分类', 'erp_product_classification', '0', 'admin', NOW(), '产品生产类型');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('图片类型', 'erp_image_type', '0', 'admin', NOW(), '产品图片类型');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('质检类型', 'erp_quality_type', '0', 'admin', NOW(), '产品质量检验类型');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('销售渠道', 'erp_sales_channel', '0', 'admin', NOW(), '产品销售渠道');

-- 采购管理字典类型
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('结算方式', 'erp_settlement_method', '0', 'admin', NOW(), '供应商结算方式');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('合同状态', 'erp_contract_status', '0', 'admin', NOW(), '供应商合同状态');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('需求来源', 'erp_source_type', '0', 'admin', NOW(), '采购需求来源');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('紧急程度', 'erp_urgent_level', '0', 'admin', NOW(), '采购紧急程度');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('计划状态', 'erp_plan_status', '0', 'admin', NOW(), '采购计划状态');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('订单类型', 'erp_order_type', '0', 'admin', NOW(), '采购订单类型');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('订单状态', 'erp_order_status', '0', 'admin', NOW(), '采购订单状态');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('送货类型', 'erp_delivery_type', '0', 'admin', NOW(), '送货类型');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('发货状态', 'erp_delivery_status', '0', 'admin', NOW(), '发货状态');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('发票状态', 'erp_invoice_status', '0', 'admin', NOW(), '供应商发票状态');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('采购类型', 'erp_procurement_type', '0', 'admin', NOW(), '采购策略类型');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('检验类型', 'erp_inspection_type', '0', 'admin', NOW(), '采购检验要求');

-- 销售管理字典类型
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('客户类型', 'erp_customer_type', '0', 'admin', NOW(), '客户类型');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('业务类型', 'erp_business_type', '0', 'admin', NOW(), '客户业务类型');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('信用等级', 'erp_credit_rating', '0', 'admin', NOW(), '客户信用等级');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('报价状态', 'erp_quote_status', '0', 'admin', NOW(), '销售报价状态');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('销售订单类型', 'erp_sales_order_type', '0', 'admin', NOW(), '销售订单类型');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('付款状态', 'erp_payment_status', '0', 'admin', NOW(), '销售付款状态');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('销售订单状态', 'erp_sales_order_status', '0', 'admin', NOW(), '销售订单状态');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('退货类型', 'erp_return_type', '0', 'admin', NOW(), '退货类型');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('退货状态', 'erp_return_status', '0', 'admin', NOW(), '退货状态');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('发票申请状态', 'erp_invoice_app_status', '0', 'admin', NOW(), '发票申请状态');

-- 库存管理字典类型
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('仓库类型', 'erp_warehouse_type', '0', 'admin', NOW(), '仓库类型');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('质量状态', 'erp_quality_status', '0', 'admin', NOW(), '库存质量状态');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('交易类型', 'erp_transaction_type', '0', 'admin', NOW(), '库存交易类型');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('交易来源', 'erp_transaction_source', '0', 'admin', NOW(), '库存交易来源');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('交易方向', 'erp_transaction_direction', '0', 'admin', NOW(), '库存交易方向');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('调整类型', 'erp_adjustment_type', '0', 'admin', NOW(), '库存调整类型');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('调整状态', 'erp_adjustment_status', '0', 'admin', NOW(), '库存调整状态');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('盘点类型', 'erp_check_type', '0', 'admin', NOW(), '库存盘点类型');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('盘点状态', 'erp_check_status', '0', 'admin', NOW(), '库存盘点状态');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('调拨状态', 'erp_transfer_status', '0', 'admin', NOW(), '库存调拨状态');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('预警类型', 'erp_alert_type', '0', 'admin', NOW(), '库存预警类型');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('预警级别', 'erp_alert_level', '0', 'admin', NOW(), '库存预警级别');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('预警状态', 'erp_alert_status', '0', 'admin', NOW(), '库存预警状态');

-- 财务管理字典类型
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('应收款状态', 'erp_ar_status', '0', 'admin', NOW(), '应收款状态');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('付款方式', 'erp_payment_method', '0', 'admin', NOW(), '付款方式');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('收款状态', 'erp_payment_record_status', '0', 'admin', NOW(), '收款状态');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('应付款状态', 'erp_ap_status', '0', 'admin', NOW(), '应付款状态');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('供应商付款方式', 'erp_supplier_payment_method', '0', 'admin', NOW(), '供应商付款方式');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('供应商付款状态', 'erp_supplier_payment_status', '0', 'admin', NOW(), '供应商付款状态');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('部门类型', 'erp_department_type', '0', 'admin', NOW(), '部门类型');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('职级', 'erp_position_level', '0', 'admin', NOW(), '员工职级');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('雇佣类型', 'erp_employment_type', '0', 'admin', NOW(), '雇佣类型');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('性别', 'erp_gender', '0', 'admin', NOW(), '员工性别');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('员工状态', 'erp_employee_status', '0', 'admin', NOW(), '员工状态');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('薪资状态', 'erp_salary_status', '0', 'admin', NOW(), '薪资状态');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('考勤状态', 'erp_attendance_status', '0', 'admin', NOW(), '考勤状态');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('请假类型', 'erp_leave_type', '0', 'admin', NOW(), '请假类型');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('加班类型', 'erp_overtime_type', '0', 'admin', NOW(), '加班类型');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('数据来源', 'erp_data_source', '0', 'admin', NOW(), '考勤数据来源');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('科目类型', 'erp_subject_type', '0', 'admin', NOW(), '财务科目类型');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('余额方向', 'erp_balance_direction', '0', 'admin', NOW(), '科目余额方向');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('凭证类型', 'erp_voucher_type', '0', 'admin', NOW(), '凭证类型');
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) VALUES 
('凭证状态', 'erp_voucher_status', '0', 'admin', NOW(), '凭证状态');

-- ================================
-- ERP业务字典数据初始化
-- ================================

-- 产品类型
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '普通', 'normal', 'erp_product_type', '', '', 'Y', '0', 'admin', NOW(), '普通产品');
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(2, '组合', 'combo', 'erp_product_type', '', '', 'N', '0', 'admin', NOW(), '组合产品');
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(3, '生产', 'production', 'erp_product_type', '', '', 'N', '0', 'admin', NOW(), '生产产品');

-- 产品单位
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '个', 'piece', 'erp_product_unit', '', '', 'Y', '0', 'admin', NOW(), '个'),
(2, '套', 'set', 'erp_product_unit', '', '', 'N', '0', 'admin', NOW(), '套'),
(3, '箱', 'box', 'erp_product_unit', '', '', 'N', '0', 'admin', NOW(), '箱'),
(4, 'kg', 'kg', 'erp_product_unit', '', '', 'N', '0', 'admin', NOW(), 'kg'),
(5, 'g', 'g', 'erp_product_unit', '', '', 'N', '0', 'admin', NOW(), '克'),
(6, '件', 'item', 'erp_product_unit', '', '', 'N', '0', 'admin', NOW(), '件');

-- 图片类型
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '正面', 'front', 'erp_image_type', '', '', 'Y', '0', 'admin', NOW(), '正面图'),
(2, '反面', 'back', 'erp_image_type', '', '', 'N', '0', 'admin', NOW(), '反面图'),
(3, '侧面', 'side', 'erp_image_type', '', '', 'N', '0', 'admin', NOW(), '侧面图'),
(4, '细节', 'detail', 'erp_image_type', '', '', 'N', '0', 'admin', NOW(), '细节图'),
(5, '包装', 'package', 'erp_image_type', '', '', 'N', '0', 'admin', NOW(), '包装图');

-- 质检类型
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '全检', 'full', 'erp_quality_type', '', '', 'N', '0', 'admin', NOW(), '全检'),
(2, '抽检', 'sample', 'erp_quality_type', '', '', 'Y', '0', 'admin', NOW(), '抽检'),
(3, '免检', 'exempt', 'erp_quality_type', '', '', 'N', '0', 'admin', NOW(), '免检');

-- 结算方式
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '月结', 'monthly', 'erp_settlement_method', '', '', 'N', '0', 'admin', NOW(), '月度结算'),
(2, '现结', 'immediate', 'erp_settlement_method', '', '', 'Y', '0', 'admin', NOW(), '立即结算'),
(3, '货到付款', 'payment_on_delivery', 'erp_settlement_method', '', '', 'N', '0', 'admin', NOW(), '货到付款');

-- 需求来源
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '业务需求', 'business', 'erp_source_type', '', '', 'Y', '0', 'admin', NOW(), '业务部门需求'),
(2, '库存警告', 'stock_alert', 'erp_source_type', '', '', 'N', '0', 'admin', NOW(), '库存预警触发'),
(3, '老板指定', 'boss', 'erp_source_type', '', '', 'N', '0', 'admin', NOW(), '老板指定采购');

-- 紧急程度
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '普通', 'normal', 'erp_urgent_level', '', '', 'Y', '0', 'admin', NOW(), '普通'),
(2, '紧急', 'urgent', 'erp_urgent_level', 'warning', '', 'N', '0', 'admin', NOW(), '紧急'),
(3, '特急', 'critical', 'erp_urgent_level', 'danger', '', 'N', '0', 'admin', NOW(), '特急');

-- 计划状态
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '草稿', 'draft', 'erp_plan_status', '', '', 'Y', '0', 'admin', NOW(), '草稿'),
(2, '待审核', 'pending', 'erp_plan_status', 'warning', '', 'N', '0', 'admin', NOW(), '待审核'),
(3, '已通过', 'approved', 'erp_plan_status', 'success', '', 'N', '0', 'admin', NOW(), '已通过'),
(4, '已驳回', 'rejected', 'erp_plan_status', 'danger', '', 'N', '0', 'admin', NOW(), '已驳回'),
(5, '已取消', 'cancelled', 'erp_plan_status', 'info', '', 'N', '0', 'admin', NOW(), '已取消');

-- 订单类型
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '普通采购', 'normal', 'erp_order_type', '', '', 'Y', '0', 'admin', NOW(), '普通采购订单'),
(2, '委外加工', 'outsourcing', 'erp_order_type', '', '', 'N', '0', 'admin', NOW(), '委外加工订单'),
(3, '平台采购', 'platform', 'erp_order_type', '', '', 'N', '0', 'admin', NOW(), '平台采购订单');

-- 送货类型
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '供应商自送', 'self_delivery', 'erp_delivery_type', '', '', 'Y', '0', 'admin', NOW(), '供应商自送'),
(2, '供应商叫车', 'supplier_truck', 'erp_delivery_type', '', '', 'N', '0', 'admin', NOW(), '供应商叫车'),
(3, '快递物流', 'express_logistics', 'erp_delivery_type', '', '', 'N', '0', 'admin', NOW(), '快递物流'),
(4, '上门自提', 'self_pickup', 'erp_delivery_type', '', '', 'N', '0', 'admin', NOW(), '上门自提');

-- 采购类型
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '外采', 'external', 'erp_procurement_type', '', '', 'Y', '0', 'admin', NOW(), '外部采购'),
(2, '内部生产', 'internal', 'erp_procurement_type', '', '', 'N', '0', 'admin', NOW(), '内部生产'),
(3, '来料加工', 'material', 'erp_procurement_type', '', '', 'N', '0', 'admin', NOW(), '来料加工'),
(4, '委外加工', 'outsourcing', 'erp_procurement_type', '', '', 'N', '0', 'admin', NOW(), '委外加工');

-- 检验类型
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '全检', 'full', 'erp_inspection_type', '', '', 'N', '0', 'admin', NOW(), '全检'),
(2, '抽检', 'sample', 'erp_inspection_type', '', '', 'Y', '0', 'admin', NOW(), '抽检'),
(3, '免检', 'exempt', 'erp_inspection_type', '', '', 'N', '0', 'admin', NOW(), '免检');

-- 客户类型
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '1688客户', '1688', 'erp_customer_type', '', '', 'N', '0', 'admin', NOW(), '1688平台客户'),
(2, '线下合作', 'offline', 'erp_customer_type', '', '', 'Y', '0', 'admin', NOW(), '线下合作客户'),
(3, '月结客户', 'monthly', 'erp_customer_type', '', '', 'N', '0', 'admin', NOW(), '月度结算客户'),
(4, '现金客户', 'cash', 'erp_customer_type', '', '', 'N', '0', 'admin', NOW(), '现金结算客户');

-- 业务类型
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '批发', 'wholesale', 'erp_business_type', '', '', 'Y', '0', 'admin', NOW(), '批发业务'),
(2, '零售', 'retail', 'erp_business_type', '', '', 'N', '0', 'admin', NOW(), '零售业务'),
(3, '平台', 'platform', 'erp_business_type', '', '', 'N', '0', 'admin', NOW(), '平台业务');

-- 信用等级
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, 'A级', 'A', 'erp_credit_rating', 'success', '', 'N', '0', 'admin', NOW(), 'A级'),
(2, 'B级', 'B', 'erp_credit_rating', 'primary', '', 'Y', '0', 'admin', NOW(), 'B级'),
(3, 'C级', 'C', 'erp_credit_rating', 'warning', '', 'N', '0', 'admin', NOW(), 'C级'),
(4, 'D级', 'D', 'erp_credit_rating', 'danger', '', 'N', '0', 'admin', NOW(), 'D级');

-- 销售订单类型
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '1688订单', '1688', 'erp_sales_order_type', '', '', 'N', '0', 'admin', NOW(), '1688平台订单'),
(2, '线下订单', 'offline', 'erp_sales_order_type', '', '', 'Y', '0', 'admin', NOW(), '线下订单'),
(3, '平台订单', 'platform', 'erp_sales_order_type', '', '', 'N', '0', 'admin', NOW(), '平台订单');

-- 付款状态
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '未付款', 'unpaid', 'erp_payment_status', 'warning', '', 'Y', '0', 'admin', NOW(), '未付款'),
(2, '部分付款', 'partial', 'erp_payment_status', 'info', '', 'N', '0', 'admin', NOW(), '部分付款'),
(3, '已付款', 'paid', 'erp_payment_status', 'success', '', 'N', '0', 'admin', NOW(), '已付款'),
(4, '已退款', 'refunded', 'erp_payment_status', 'danger', '', 'N', '0', 'admin', NOW(), '已退款');

-- 仓库类型
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '主仓', 'main', 'erp_warehouse_type', '', '', 'Y', '0', 'admin', NOW(), '主仓库'),
(2, '分仓', 'branch', 'erp_warehouse_type', '', '', 'N', '0', 'admin', NOW(), '分仓库'),
(3, '海外仓', 'overseas', 'erp_warehouse_type', '', '', 'N', '0', 'admin', NOW(), '海外仓库'),
(4, '原材料仓', 'raw_material', 'erp_warehouse_type', '', '', 'N', '0', 'admin', NOW(), '原材料仓库'),
(5, '成品仓', 'finished', 'erp_warehouse_type', '', '', 'N', '0', 'admin', NOW(), '成品仓库'),
(6, '辅料仓', 'auxiliary', 'erp_warehouse_type', '', '', 'N', '0', 'admin', NOW(), '辅料仓库');

-- 交易类型
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '入库', 'in', 'erp_transaction_type', 'success', '', 'N', '0', 'admin', NOW(), '入库'),
(2, '出库', 'out', 'erp_transaction_type', 'danger', '', 'N', '0', 'admin', NOW(), '出库'),
(3, '调整', 'adjust', 'erp_transaction_type', 'warning', '', 'N', '0', 'admin', NOW(), '调整'),
(4, '盘点', 'check', 'erp_transaction_type', 'info', '', 'N', '0', 'admin', NOW(), '盘点'),
(5, '调拨', 'transfer', 'erp_transaction_type', 'primary', '', 'N', '0', 'admin', NOW(), '调拨');

-- 交易方向
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '入库', 'IN', 'erp_transaction_direction', 'success', '', 'Y', '0', 'admin', NOW(), '入库方向'),
(2, '出库', 'OUT', 'erp_transaction_direction', 'danger', '', 'N', '0', 'admin', NOW(), '出库方向');

-- 部门类型
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '业务部', 'sales', 'erp_department_type', '', '', 'N', '0', 'admin', NOW(), '业务部'),
(2, '采购部', 'procurement', 'erp_department_type', '', '', 'N', '0', 'admin', NOW(), '采购部'),
(3, '财务部', 'finance', 'erp_department_type', '', '', 'N', '0', 'admin', NOW(), '财务部'),
(4, '仓储部', 'warehouse', 'erp_department_type', '', '', 'N', '0', 'admin', NOW(), '仓储部'),
(5, '生产部', 'production', 'erp_department_type', '', '', 'N', '0', 'admin', NOW(), '生产部'),
(6, '技术部', 'technical', 'erp_department_type', '', '', 'N', '0', 'admin', NOW(), '技术部'),
(7, '行政部', 'admin', 'erp_department_type', '', '', 'N', '0', 'admin', NOW(), '行政部'),
(8, '人事部', 'hr', 'erp_department_type', '', '', 'N', '0', 'admin', NOW(), '人事部');

-- 职级
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '普通员工', 'normal', 'erp_position_level', '', '', 'Y', '0', 'admin', NOW(), '普通员工'),
(2, '主管', 'supervisor', 'erp_position_level', '', '', 'N', '0', 'admin', NOW(), '主管'),
(3, '经理', 'manager', 'erp_position_level', '', '', 'N', '0', 'admin', NOW(), '经理'),
(4, '总监', 'director', 'erp_position_level', '', '', 'N', '0', 'admin', NOW(), '总监'),
(5, '副总经理', 'vice_president', 'erp_position_level', '', '', 'N', '0', 'admin', NOW(), '副总经理'),
(6, '总经理', 'president', 'erp_position_level', '', '', 'N', '0', 'admin', NOW(), '总经理');

-- 雇佣类型
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '全职', 'fulltime', 'erp_employment_type', '', '', 'Y', '0', 'admin', NOW(), '全职'),
(2, '兼职', 'parttime', 'erp_employment_type', '', '', 'N', '0', 'admin', NOW(), '兼职'),
(3, '实习', 'intern', 'erp_employment_type', '', '', 'N', '0', 'admin', NOW(), '实习'),
(4, '外包', 'outsourcing', 'erp_employment_type', '', '', 'N', '0', 'admin', NOW(), '外包');

-- 科目类型
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '资产', 'asset', 'erp_subject_type', '', '', 'N', '0', 'admin', NOW(), '资产类'),
(2, '负债', 'liability', 'erp_subject_type', '', '', 'N', '0', 'admin', NOW(), '负债类'),
(3, '权益', 'equity', 'erp_subject_type', '', '', 'N', '0', 'admin', NOW(), '权益类'),
(4, '成本', 'cost', 'erp_subject_type', '', '', 'N', '0', 'admin', NOW(), '成本类'),
(5, '费用', 'expense', 'erp_subject_type', '', '', 'N', '0', 'admin', NOW(), '费用类'),
(6, '收入', 'income', 'erp_subject_type', '', '', 'N', '0', 'admin', NOW(), '收入类');

-- 余额方向
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '借方', 'debit', 'erp_balance_direction', '', '', 'Y', '0', 'admin', NOW(), '借方'),
(2, '贷方', 'credit', 'erp_balance_direction', '', '', 'N', '0', 'admin', NOW(), '贷方');

-- 合作级别
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '一星', '1', 'erp_cooperation_level', 'warning', '', 'N', '0', 'admin', NOW(), '一星供应商'),
(2, '二星', '2', 'erp_cooperation_level', 'primary', '', 'N', '0', 'admin', NOW(), '二星供应商'),
(3, '三星', '3', 'erp_cooperation_level', 'info', '', 'Y', '0', 'admin', NOW(), '三星供应商'),
(4, '四星', '4', 'erp_cooperation_level', 'success', '', 'N', '0', 'admin', NOW(), '四星供应商'),
(5, '五星', '5', 'erp_cooperation_level', 'danger', '', 'N', '0', 'admin', NOW(), '五星供应商');

-- 合同状态
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '草稿', 'draft', 'erp_contract_status', '', '', 'Y', '0', 'admin', NOW(), '草稿'),
(2, '执行中', 'active', 'erp_contract_status', 'success', '', 'N', '0', 'admin', NOW(), '执行中'),
(3, '已完成', 'completed', 'erp_contract_status', 'info', '', 'N', '0', 'admin', NOW(), '已完成'),
(4, '已终止', 'terminated', 'erp_contract_status', 'danger', '', 'N', '0', 'admin', NOW(), '已终止');

-- 发票状态
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '待认证', 'pending', 'erp_invoice_status', 'warning', '', 'Y', '0', 'admin', NOW(), '待认证'),
(2, '已认证', 'verified', 'erp_invoice_status', 'success', '', 'N', '0', 'admin', NOW(), '已认证'),
(3, '已抵扣', 'deducted', 'erp_invoice_status', 'info', '', 'N', '0', 'admin', NOW(), '已抵扣'),
(4, '已过期', 'expired', 'erp_invoice_status', 'danger', '', 'N', '0', 'admin', NOW(), '已过期');

-- 订单状态
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '草稿', 'draft', 'erp_order_status', '', '', 'Y', '0', 'admin', NOW(), '草稿'),
(2, '待审核', 'pending', 'erp_order_status', 'warning', '', 'N', '0', 'admin', NOW(), '待审核'),
(3, '待采购', 'purchasing', 'erp_order_status', 'info', '', 'N', '0', 'admin', NOW(), '待采购'),
(4, '已取消', 'cancelled', 'erp_order_status', 'danger', '', 'N', '0', 'admin', NOW(), '已取消'),
(5, '已完成', 'completed', 'erp_order_status', 'success', '', 'N', '0', 'admin', NOW(), '已完成');

-- 发货状态
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '未发货', 'pending', 'erp_delivery_status', 'warning', '', 'Y', '0', 'admin', NOW(), '未发货'),
(2, '部分发货', 'partial', 'erp_delivery_status', 'info', '', 'N', '0', 'admin', NOW(), '部分发货'),
(3, '已发货', 'shipped', 'erp_delivery_status', 'success', '', 'N', '0', 'admin', NOW(), '已发货'),
(4, '已送达', 'delivered', 'erp_delivery_status', 'primary', '', 'N', '0', 'admin', NOW(), '已送达');

-- 报价状态
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '草稿', 'draft', 'erp_quote_status', '', '', 'Y', '0', 'admin', NOW(), '草稿'),
(2, '待审核', 'pending', 'erp_quote_status', 'warning', '', 'N', '0', 'admin', NOW(), '待审核'),
(3, '已通过', 'approved', 'erp_quote_status', 'success', '', 'N', '0', 'admin', NOW(), '已通过'),
(4, '已驳回', 'rejected', 'erp_quote_status', 'danger', '', 'N', '0', 'admin', NOW(), '已驳回'),
(5, '已过期', 'expired', 'erp_quote_status', 'info', '', 'N', '0', 'admin', NOW(), '已过期');

-- 销售订单状态
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '草稿', 'draft', 'erp_sales_order_status', '', '', 'Y', '0', 'admin', NOW(), '草稿'),
(2, '待审核', 'pending', 'erp_sales_order_status', 'warning', '', 'N', '0', 'admin', NOW(), '待审核'),
(3, '待发货', 'pending_shipment', 'erp_sales_order_status', 'info', '', 'N', '0', 'admin', NOW(), '待发货'),
(4, '已驳回', 'rejected', 'erp_sales_order_status', 'danger', '', 'N', '0', 'admin', NOW(), '已驳回'),
(5, '已发货', 'shipped', 'erp_sales_order_status', 'primary', '', 'N', '0', 'admin', NOW(), '已发货'),
(6, '已完成', 'completed', 'erp_sales_order_status', 'success', '', 'N', '0', 'admin', NOW(), '已完成'),
(7, '已取消', 'cancelled', 'erp_sales_order_status', 'danger', '', 'N', '0', 'admin', NOW(), '已取消');

-- 退货类型
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '质量问题', 'quality', 'erp_return_type', 'danger', '', 'N', '0', 'admin', NOW(), '质量问题'),
(2, '发错货', 'wrong_item', 'erp_return_type', 'warning', '', 'N', '0', 'admin', NOW(), '发错货'),
(3, '多发货', 'excess', 'erp_return_type', 'info', '', 'N', '0', 'admin', NOW(), '多发货'),
(4, '客户退货', 'customer_return', 'erp_return_type', 'primary', '', 'Y', '0', 'admin', NOW(), '客户退货'),
(5, '其他', 'other', 'erp_return_type', '', '', 'N', '0', 'admin', NOW(), '其他');

-- 退货状态
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '待审核', 'pending', 'erp_return_status', 'warning', '', 'Y', '0', 'admin', NOW(), '待审核'),
(2, '已通过', 'approved', 'erp_return_status', 'success', '', 'N', '0', 'admin', NOW(), '已通过'),
(3, '已驳回', 'rejected', 'erp_return_status', 'danger', '', 'N', '0', 'admin', NOW(), '已驳回'),
(4, '已入库', 'received', 'erp_return_status', 'info', '', 'N', '0', 'admin', NOW(), '已入库');

-- 发票申请状态
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '待审核', 'pending', 'erp_invoice_app_status', 'warning', '', 'Y', '0', 'admin', NOW(), '待审核'),
(2, '已通过', 'approved', 'erp_invoice_app_status', 'success', '', 'N', '0', 'admin', NOW(), '已通过'),
(3, '已驳回', 'rejected', 'erp_invoice_app_status', 'danger', '', 'N', '0', 'admin', NOW(), '已驳回'),
(4, '已开票', 'invoiced', 'erp_invoice_app_status', 'info', '', 'N', '0', 'admin', NOW(), '已开票'),
(5, '已寄出', 'mailed', 'erp_invoice_app_status', 'primary', '', 'N', '0', 'admin', NOW(), '已寄出');

-- 质量状态
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '正常', 'normal', 'erp_quality_status', 'success', '', 'Y', '0', 'admin', NOW(), '正常'),
(2, '待检', 'pending', 'erp_quality_status', 'warning', '', 'N', '0', 'admin', NOW(), '待检'),
(3, '不合格', 'unqualified', 'erp_quality_status', 'danger', '', 'N', '0', 'admin', NOW(), '不合格'),
(4, '返修', 'repair', 'erp_quality_status', 'info', '', 'N', '0', 'admin', NOW(), '返修');

-- 交易来源
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '采购入库', 'purchase_in', 'erp_transaction_source', 'success', '', 'N', '0', 'admin', NOW(), '采购入库'),
(2, '销售出库', 'sale_out', 'erp_transaction_source', 'danger', '', 'N', '0', 'admin', NOW(), '销售出库'),
(3, '库存调拨', 'transfer', 'erp_transaction_source', 'primary', '', 'N', '0', 'admin', NOW(), '库存调拨'),
(4, '库存调整', 'adjust', 'erp_transaction_source', 'warning', '', 'N', '0', 'admin', NOW(), '库存调整'),
(5, '库存盘点', 'check', 'erp_transaction_source', 'info', '', 'Y', '0', 'admin', NOW(), '库存盘点');

-- 调整类型
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '盘盈', 'profit', 'erp_adjustment_type', 'success', '', 'N', '0', 'admin', NOW(), '盘盈'),
(2, '盘亏', 'loss', 'erp_adjustment_type', 'danger', '', 'N', '0', 'admin', NOW(), '盘亏'),
(3, '报损', 'damage', 'erp_adjustment_type', 'warning', '', 'N', '0', 'admin', NOW(), '报损'),
(4, '其他调整', 'other', 'erp_adjustment_type', 'info', '', 'Y', '0', 'admin', NOW(), '其他调整');

-- 调整状态
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '草稿', 'draft', 'erp_adjustment_status', '', '', 'Y', '0', 'admin', NOW(), '草稿'),
(2, '待审核', 'pending', 'erp_adjustment_status', 'warning', '', 'N', '0', 'admin', NOW(), '待审核'),
(3, '已通过', 'approved', 'erp_adjustment_status', 'success', '', 'N', '0', 'admin', NOW(), '已通过'),
(4, '已驳回', 'rejected', 'erp_adjustment_status', 'danger', '', 'N', '0', 'admin', NOW(), '已驳回'),
(5, '已完成', 'completed', 'erp_adjustment_status', 'info', '', 'N', '0', 'admin', NOW(), '已完成');

-- 盘点类型
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '全面盘点', 'full', 'erp_check_type', '', '', 'Y', '0', 'admin', NOW(), '全面盘点'),
(2, '抽查盘点', 'sample', 'erp_check_type', '', '', 'N', '0', 'admin', NOW(), '抽查盘点'),
(3, '类别盘点', 'category', 'erp_check_type', '', '', 'N', '0', 'admin', NOW(), '类别盘点'),
(4, '单品盘点', 'single', 'erp_check_type', '', '', 'N', '0', 'admin', NOW(), '单品盘点');

-- 盘点状态
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '草稿', 'draft', 'erp_check_status', '', '', 'Y', '0', 'admin', NOW(), '草稿'),
(2, '盘点中', 'checking', 'erp_check_status', 'warning', '', 'N', '0', 'admin', NOW(), '盘点中'),
(3, '已完成', 'completed', 'erp_check_status', 'info', '', 'N', '0', 'admin', NOW(), '已完成'),
(4, '已审核', 'approved', 'erp_check_status', 'success', '', 'N', '0', 'admin', NOW(), '已审核'),
(5, '已取消', 'cancelled', 'erp_check_status', 'danger', '', 'N', '0', 'admin', NOW(), '已取消');

-- 调拨状态
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '草稿', 'draft', 'erp_transfer_status', '', '', 'Y', '0', 'admin', NOW(), '草稿'),
(2, '待审核', 'pending', 'erp_transfer_status', 'warning', '', 'N', '0', 'admin', NOW(), '待审核'),
(3, '已通过', 'approved', 'erp_transfer_status', 'success', '', 'N', '0', 'admin', NOW(), '已通过'),
(4, '调拨中', 'transferring', 'erp_transfer_status', 'info', '', 'N', '0', 'admin', NOW(), '调拨中'),
(5, '已完成', 'completed', 'erp_transfer_status', 'primary', '', 'N', '0', 'admin', NOW(), '已完成');

-- 预警类型
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '最小库存', 'min_stock', 'erp_alert_type', 'warning', '', 'Y', '0', 'admin', NOW(), '最小库存预警'),
(2, '最大库存', 'max_stock', 'erp_alert_type', 'info', '', 'N', '0', 'admin', NOW(), '最大库存预警'),
(3, '过期预警', 'expiry', 'erp_alert_type', 'danger', '', 'N', '0', 'admin', NOW(), '过期预警'),
(4, '滞销预警', 'slow_moving', 'erp_alert_type', 'primary', '', 'N', '0', 'admin', NOW(), '滞销预警');

-- 预警级别
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '提示', 'info', 'erp_alert_level', 'info', '', 'Y', '0', 'admin', NOW(), '提示级别'),
(2, '警告', 'warning', 'erp_alert_level', 'warning', '', 'N', '0', 'admin', NOW(), '警告级别'),
(3, '严重', 'danger', 'erp_alert_level', 'danger', '', 'N', '0', 'admin', NOW(), '严重级别');

-- 预警状态
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '待处理', 'pending', 'erp_alert_status', 'warning', '', 'Y', '0', 'admin', NOW(), '待处理'),
(2, '处理中', 'processing', 'erp_alert_status', 'info', '', 'N', '0', 'admin', NOW(), '处理中'),
(3, '已解决', 'resolved', 'erp_alert_status', 'success', '', 'N', '0', 'admin', NOW(), '已解决'),
(4, '已忽略', 'ignored', 'erp_alert_status', 'danger', '', 'N', '0', 'admin', NOW(), '已忽略');

-- 应收款状态
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '未收款', 'unpaid', 'erp_ar_status', 'warning', '', 'Y', '0', 'admin', NOW(), '未收款'),
(2, '部分收款', 'partial', 'erp_ar_status', 'info', '', 'N', '0', 'admin', NOW(), '部分收款'),
(3, '已收款', 'paid', 'erp_ar_status', 'success', '', 'N', '0', 'admin', NOW(), '已收款'),
(4, '逾期', 'overdue', 'erp_ar_status', 'danger', '', 'N', '0', 'admin', NOW(), '逾期');

-- 付款方式
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '现金', 'cash', 'erp_payment_method', '', '', 'Y', '0', 'admin', NOW(), '现金支付'),
(2, '银行转账', 'bank_transfer', 'erp_payment_method', '', '', 'N', '0', 'admin', NOW(), '银行转账'),
(3, '支付宝', 'alipay', 'erp_payment_method', '', '', 'N', '0', 'admin', NOW(), '支付宝'),
(4, '微信', 'wechat', 'erp_payment_method', '', '', 'N', '0', 'admin', NOW(), '微信'),
(5, '银行卡', 'card', 'erp_payment_method', '', '', 'N', '0', 'admin', NOW(), '银行卡');

-- 收款状态
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '待确认', 'pending', 'erp_payment_record_status', 'warning', '', 'Y', '0', 'admin', NOW(), '待确认'),
(2, '已确认', 'confirmed', 'erp_payment_record_status', 'success', '', 'N', '0', 'admin', NOW(), '已确认'),
(3, '已取消', 'cancelled', 'erp_payment_record_status', 'danger', '', 'N', '0', 'admin', NOW(), '已取消');

-- 应付款状态
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '未付款', 'unpaid', 'erp_ap_status', 'warning', '', 'Y', '0', 'admin', NOW(), '未付款'),
(2, '部分付款', 'partial', 'erp_ap_status', 'info', '', 'N', '0', 'admin', NOW(), '部分付款'),
(3, '已付款', 'paid', 'erp_ap_status', 'success', '', 'N', '0', 'admin', NOW(), '已付款'),
(4, '逾期', 'overdue', 'erp_ap_status', 'danger', '', 'N', '0', 'admin', NOW(), '逾期');

-- 供应商付款方式
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '对公转账', 'public_transfer', 'erp_supplier_payment_method', '', '', 'Y', '0', 'admin', NOW(), '对公转账'),
(2, '1688结算', 'alibaba_settlement', 'erp_supplier_payment_method', '', '', 'N', '0', 'admin', NOW(), '1688结算'),
(3, '私卡转账', 'private_transfer', 'erp_supplier_payment_method', '', '', 'N', '0', 'admin', NOW(), '私卡转账'),
(4, '支付宝', 'alipay', 'erp_supplier_payment_method', '', '', 'N', '0', 'admin', NOW(), '支付宝'),
(5, '微信', 'wechat', 'erp_supplier_payment_method', '', '', 'N', '0', 'admin', NOW(), '微信');

-- 供应商付款状态
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '待确认', 'pending', 'erp_supplier_payment_status', 'warning', '', 'Y', '0', 'admin', NOW(), '待确认'),
(2, '已确认', 'confirmed', 'erp_supplier_payment_status', 'success', '', 'N', '0', 'admin', NOW(), '已确认'),
(3, '已取消', 'cancelled', 'erp_supplier_payment_status', 'danger', '', 'N', '0', 'admin', NOW(), '已取消');

-- 凭证类型
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '记账凭证', 'general', 'erp_voucher_type', '', '', 'Y', '0', 'admin', NOW(), '记账凭证'),
(2, '收款凭证', 'receipt', 'erp_voucher_type', '', '', 'N', '0', 'admin', NOW(), '收款凭证'),
(3, '付款凭证', 'payment', 'erp_voucher_type', '', '', 'N', '0', 'admin', NOW(), '付款凭证'),
(4, '转账凭证', 'transfer', 'erp_voucher_type', '', '', 'N', '0', 'admin', NOW(), '转账凭证');

-- 凭证状态
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES 
(1, '草稿', 'draft', 'erp_voucher_status', '', '', 'Y', '0', 'admin', NOW(), '草稿'),
(2, '待审核', 'pending', 'erp_voucher_status', 'warning', '', 'N', '0', 'admin', NOW(), '待审核'),
(3, '已过账', 'posted', 'erp_voucher_status', 'success', '', 'N', '0', 'admin', NOW(), '已过账'),
(4, '已取消', 'cancelled', 'erp_voucher_status', 'danger', '', 'N', '0', 'admin', NOW(), '已取消');

-- ================================
-- ERP业务表创建
-- ================================

-- 产品类目表 (业务品类分类)
CREATE TABLE product_category (
    category_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL COMMENT '类目名称：游戏/3C类/母婴/汽配/户外运动/玩具/家居',
    parent_id BIGINT DEFAULT 0 COMMENT '父类目ID，支持多级分类',
    sort_order INT DEFAULT 0 COMMENT '排序顺序',
    status CHAR(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME COMMENT '更新时间',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    INDEX idx_parent_id (parent_id),
    INDEX idx_status (status)
) COMMENT='产品类目表';

-- 产品分类表 (生产类型分类)
CREATE TABLE product_classification (
    classification_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    classification_name VARCHAR(50) NOT NULL COMMENT '分类名称：成品/半成品/物料/包装辅料',
    subtype_name VARCHAR(100) COMMENT '子类型：外采-入库-销售/内部生产-入库-销售等',
    description TEXT COMMENT '分类描述',
    sort_order INT DEFAULT 0 COMMENT '排序顺序',
    status CHAR(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME COMMENT '更新时间',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    INDEX idx_status (status)
) COMMENT='产品分类表';

-- 产品信息主表
CREATE TABLE product_info (
    product_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    product_code VARCHAR(50) NOT NULL UNIQUE COMMENT '产品SKU',
    product_name VARCHAR(200) NOT NULL COMMENT '产品名称',
    product_type INT DEFAULT 1 COMMENT '产品类型，参考字典表sys_dict_data.dict_value, dict_type=erp_product_type',
    category_id BIGINT NOT NULL COMMENT '产品类目ID',
    classification_id BIGINT NOT NULL COMMENT '产品分类ID',
    model VARCHAR(100) COMMENT '产品型号',
    unit INT DEFAULT 1 COMMENT '单位，参考字典表sys_dict_data.dict_value, dict_type=erp_product_unit',
    purchase_price DECIMAL(12,2) DEFAULT 0 COMMENT '采购价格',
    lead_time INT COMMENT '采购交期（天）',
    weight DECIMAL(10,2) COMMENT '重量(g/kg)',
    volume DECIMAL(10,2) COMMENT '体积(cm³)',
    length DECIMAL(8,2) COMMENT '长度(cm)',
    width DECIMAL(8,2) COMMENT '宽度(cm)',
    height DECIMAL(8,2) COMMENT '高度(cm)',
    standard_box_qty INT DEFAULT 0 COMMENT '标准箱数量',
    sales_30days INT DEFAULT 0 COMMENT '30天销量',
    description TEXT COMMENT '产品说明',
    purchase_remark TEXT COMMENT '采购备注',
    platform_1688_url VARCHAR(500) COMMENT '1688采购链接',
    quality_type INT COMMENT '质检类型，参考字典表sys_dict_data.dict_value, dict_type=erp_quality_type',
    sales_channels TEXT COMMENT '销售渠道：多个渠道ID用逗号分隔，参考字典表sys_dict_data.dict_value, dict_type=erp_sales_channel',
    is_active CHAR(1) DEFAULT '0' COMMENT '是否启用（0禁用 1启用）',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME COMMENT '更新时间',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    INDEX idx_category_id (category_id),
    INDEX idx_classification_id (classification_id),
    INDEX idx_product_code (product_code),
    INDEX idx_product_name (product_name),
    INDEX idx_is_active (is_active),
    FOREIGN KEY (category_id) REFERENCES product_category(category_id),
    FOREIGN KEY (classification_id) REFERENCES product_classification(classification_id)
) COMMENT='产品信息表';

-- 产品图片表
CREATE TABLE product_images (
    image_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    product_id BIGINT NOT NULL,
    image_path VARCHAR(500) NOT NULL COMMENT '图片路径',
    image_type INT DEFAULT 1 COMMENT '图片类型，参考字典表sys_dict_data.dict_value, dict_type=erp_image_type',
    sort_order INT DEFAULT 0 COMMENT '排序顺序',
    is_primary CHAR(1) DEFAULT '0' COMMENT '是否主图（0否 1是）',
    create_time DATETIME COMMENT '创建时间',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    update_time DATETIME COMMENT '更新时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    INDEX idx_product_id (product_id),
    INDEX idx_image_type (image_type),
    FOREIGN KEY (product_id) REFERENCES product_info(product_id) ON DELETE CASCADE
) COMMENT='产品图片表';

-- 产品辅料关联表
CREATE TABLE product_material_relation (
    relation_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    product_id BIGINT NOT NULL,
    material_id BIGINT NOT NULL COMMENT '辅料产品ID',
    quantity_per_unit DECIMAL(10,2) DEFAULT 1 COMMENT '每单位产品所需辅料数量',
    create_time DATETIME COMMENT '创建时间',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    update_time DATETIME COMMENT '更新时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    INDEX idx_product_id (product_id),
    INDEX idx_material_id (material_id),
    FOREIGN KEY (product_id) REFERENCES product_info(product_id),
    FOREIGN KEY (material_id) REFERENCES product_info(product_id)
) COMMENT='产品辅料关联表';

-- ================================
-- 采购管理表
-- ================================

-- 供应商信息表
CREATE TABLE supplier_info (
    supplier_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    supplier_code VARCHAR(20) NOT NULL UNIQUE COMMENT '供应商代码',
    supplier_name VARCHAR(100) NOT NULL COMMENT '供应商名称',
    cooperation_level INT DEFAULT 3 COMMENT '合作级别(1-5星)，参考字典表sys_dict_data.dict_value, dict_type=erp_cooperation_level',
    scale VARCHAR(50) COMMENT '公司规模',
    contact_person VARCHAR(50) COMMENT '联系人',
    contact_phone VARCHAR(20) COMMENT '联系电话',
    wechat VARCHAR(50) COMMENT '微信号',
    company_phone VARCHAR(20) COMMENT '公司固话',
    business_license_path VARCHAR(500) COMMENT '营业执照附件路径',
    credit_code VARCHAR(50) COMMENT '统一社会信用代码',
    office_address VARCHAR(200) COMMENT '办公地址',
    production_address VARCHAR(200) COMMENT '生产地址',
    warehouse_address VARCHAR(200) COMMENT '仓库地址',
    delivery_type INT COMMENT '配送方式，参考字典表sys_dict_data.dict_value, dict_type=erp_delivery_type',
    invoice_type VARCHAR(50) COMMENT '税票类型',
    tax_rate DECIMAL(5,2) COMMENT '税点(%)',
    settlement_method INT COMMENT '结算方式，参考字典表sys_dict_data.dict_value, dict_type=erp_settlement_method',
    settlement_desc TEXT COMMENT '结算描述',
    payment_method INT COMMENT '支付方式，参考字典表sys_dict_data.dict_value, dict_type=erp_supplier_payment_method',
    payment_info TEXT COMMENT '收款信息',
    website VARCHAR(200) COMMENT '网址',
    status CHAR(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME COMMENT '更新时间',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    INDEX idx_supplier_code (supplier_code),
    INDEX idx_supplier_name (supplier_name),
    INDEX idx_status (status)
) COMMENT='供应商信息表';

-- 供应商合同表
CREATE TABLE supplier_contract (
    contract_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    supplier_id BIGINT NOT NULL COMMENT '供应商ID',
    contract_name VARCHAR(100) NOT NULL COMMENT '合同名称',
    contract_no VARCHAR(50) NOT NULL UNIQUE COMMENT '合同编号',
    contract_path VARCHAR(500) COMMENT '合同文件路径',
    start_date DATE COMMENT '合同开始日期',
    end_date DATE COMMENT '合同结束日期',
    amount DECIMAL(12,2) COMMENT '合同金额',
    status INT COMMENT '合同状态，参考字典表sys_dict_data.dict_value, dict_type=erp_contract_status',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME COMMENT '更新时间',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    INDEX idx_supplier_id (supplier_id),
    INDEX idx_contract_no (contract_no),
    INDEX idx_status (status),
    FOREIGN KEY (supplier_id) REFERENCES supplier_info(supplier_id)
) COMMENT='供应商合同表';

-- 供应商发票表
CREATE TABLE supplier_invoice (
    invoice_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    supplier_id BIGINT NOT NULL COMMENT '供应商ID',
    invoice_no VARCHAR(50) NOT NULL UNIQUE COMMENT '发票编号',
    invoice_amount DECIMAL(12,2) NOT NULL COMMENT '发票金额',
    invoice_date DATE COMMENT '发票日期',
    tax_amount DECIMAL(12,2) COMMENT '税额',
    invoice_path VARCHAR(500) COMMENT '发票附件路径',
    status INT COMMENT '发票状态，参考字典表sys_dict_data.dict_value, dict_type=erp_invoice_status',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME COMMENT '更新时间',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    INDEX idx_supplier_id (supplier_id),
    INDEX idx_invoice_no (invoice_no),
    INDEX idx_status (status),
    FOREIGN KEY (supplier_id) REFERENCES supplier_info(supplier_id)
) COMMENT='供应商发票表';

-- 采购计划表
CREATE TABLE purchase_plan (
    plan_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    plan_no VARCHAR(30) NOT NULL UNIQUE COMMENT '计划编号',
    source_type INT NOT NULL COMMENT '需求来源，参考字典表sys_dict_data.dict_value, dict_type=erp_source_type',
    urgent_level INT DEFAULT 1 COMMENT '紧急程度，参考字典表sys_dict_data.dict_value, dict_type=erp_urgent_level',
    total_amount DECIMAL(12,2) DEFAULT 0 COMMENT '总金额',
    expect_date DATE COMMENT '期望到货日期',
    status INT DEFAULT 1 COMMENT '计划状态，参考字典表sys_dict_data.dict_value, dict_type=erp_plan_status',
    reject_reason TEXT COMMENT '驳回原因',
    applicant VARCHAR(64) DEFAULT '' COMMENT '申请人',
    apply_time DATETIME COMMENT '申请时间',
    approver VARCHAR(64) DEFAULT '' COMMENT '审批人',
    approve_time DATETIME COMMENT '审批时间',
    approve_remark TEXT COMMENT '审批意见',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME COMMENT '更新时间',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    INDEX idx_plan_no (plan_no),
    INDEX idx_status (status),
    INDEX idx_urgent_level (urgent_level),
    INDEX idx_apply_time (apply_time)
) COMMENT='采购计划表';

-- 采购计划明细表
CREATE TABLE purchase_plan_detail (
    detail_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    plan_id BIGINT NOT NULL COMMENT '采购计划ID',
    product_id BIGINT NOT NULL COMMENT '产品ID',
    quantity DECIMAL(10,2) NOT NULL COMMENT '采购数量',
    unit_price DECIMAL(10,2) NOT NULL COMMENT '单价',
    total_price DECIMAL(12,2) NOT NULL COMMENT '总价',
    supplier_id BIGINT COMMENT '建议供应商ID',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    create_time DATETIME COMMENT '创建时间',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    update_time DATETIME COMMENT '更新时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    INDEX idx_plan_id (plan_id),
    INDEX idx_product_id (product_id),
    INDEX idx_supplier_id (supplier_id),
    FOREIGN KEY (plan_id) REFERENCES purchase_plan(plan_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product_info(product_id),
    FOREIGN KEY (supplier_id) REFERENCES supplier_info(supplier_id)
) COMMENT='采购计划明细表';

-- 采购订单表
CREATE TABLE purchase_order (
    order_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_no VARCHAR(30) NOT NULL UNIQUE COMMENT '订单编号',
    plan_id BIGINT COMMENT '关联采购计划ID',
    supplier_id BIGINT NOT NULL COMMENT '供应商ID',
    order_type INT DEFAULT 1 COMMENT '订单类型，参考字典表sys_dict_data.dict_value, dict_type=erp_order_type',
    order_amount DECIMAL(12,2) DEFAULT 0 COMMENT '订单金额',
    delivery_type INT COMMENT '送货类型，参考字典表sys_dict_data.dict_value, dict_type=erp_delivery_type',
    delivery_address TEXT COMMENT '送货地址',
    delivery_status INT DEFAULT 1 COMMENT '发货状态，参考字典表sys_dict_data.dict_value, dict_type=erp_delivery_status',
    query_code VARCHAR(10) COMMENT '查询码',
    quality_inspection_type INT COMMENT '检验要求，参考字典表sys_dict_data.dict_value, dict_type=erp_inspection_type',
    quality_report_path VARCHAR(500) COMMENT '品质报告附件路径',
    contract_path VARCHAR(500) COMMENT '采购合同附件路径',
    status INT DEFAULT 1 COMMENT '订单状态，参考字典表sys_dict_data.dict_value, dict_type=erp_order_status',
    reject_reason TEXT COMMENT '驳回原因',
    procurement_type INT COMMENT '采购类型，参考字典表sys_dict_data.dict_value, dict_type=erp_procurement_type',
    applicant VARCHAR(64) DEFAULT '' COMMENT '申请人',
    apply_time DATETIME COMMENT '申请时间',
    approver VARCHAR(64) DEFAULT '' COMMENT '审批人',
    approve_time DATETIME COMMENT '审批时间',
    approve_remark TEXT COMMENT '审批意见',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME COMMENT '更新时间',
    remark TEXT COMMENT '备注',
    INDEX idx_order_no (order_no),
    INDEX idx_plan_id (plan_id),
    INDEX idx_supplier_id (supplier_id),
    INDEX idx_status (status),
    INDEX idx_delivery_status (delivery_status),
    INDEX idx_apply_time (apply_time),
    FOREIGN KEY (plan_id) REFERENCES purchase_plan(plan_id),
    FOREIGN KEY (supplier_id) REFERENCES supplier_info(supplier_id)
) COMMENT='采购订单表';

-- 采购订单明细表
CREATE TABLE purchase_order_detail (
    detail_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_id BIGINT NOT NULL COMMENT '采购订单ID',
    plan_detail_id BIGINT COMMENT '关联计划明细ID',
    product_id BIGINT NOT NULL COMMENT '产品ID',
    quantity DECIMAL(10,2) NOT NULL COMMENT '采购数量',
    delivery_quantity DECIMAL(10,2) DEFAULT 0 COMMENT '送货数量',
    unit_price DECIMAL(10,2) NOT NULL COMMENT '单价',
    total_price DECIMAL(12,2) NOT NULL COMMENT '总价',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    create_time DATETIME COMMENT '创建时间',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    update_time DATETIME COMMENT '更新时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    INDEX idx_order_id (order_id),
    INDEX idx_plan_detail_id (plan_detail_id),
    INDEX idx_product_id (product_id),
    FOREIGN KEY (order_id) REFERENCES purchase_order(order_id) ON DELETE CASCADE,
    FOREIGN KEY (plan_detail_id) REFERENCES purchase_plan_detail(detail_id),
    FOREIGN KEY (product_id) REFERENCES product_info(product_id)
) COMMENT='采购订单明细表';

-- 采购退货单表
CREATE TABLE purchase_return (
    return_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    return_no VARCHAR(30) NOT NULL UNIQUE COMMENT '退货单编号',
    order_id BIGINT NOT NULL COMMENT '关联采购订单ID',
    supplier_id BIGINT NOT NULL COMMENT '供应商ID',
    return_amount DECIMAL(12,2) DEFAULT 0 COMMENT '退货金额',
    return_reason TEXT COMMENT '退货原因',
    return_type INT COMMENT '退货类型，参考字典表sys_dict_data.dict_value, dict_type=erp_return_type',
    status INT DEFAULT 1 COMMENT '退货状态，参考字典表sys_dict_data.dict_value, dict_type=erp_return_status',
    applicant VARCHAR(64) DEFAULT '' COMMENT '申请人',
    apply_time DATETIME COMMENT '申请时间',
    approver VARCHAR(64) DEFAULT '' COMMENT '审批人',
    approve_time DATETIME COMMENT '审批时间',
    approve_remark TEXT COMMENT '审批意见',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME COMMENT '更新时间',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    INDEX idx_return_no (return_no),
    INDEX idx_order_id (order_id),
    INDEX idx_supplier_id (supplier_id),
    INDEX idx_status (status),
    FOREIGN KEY (order_id) REFERENCES purchase_order(order_id),
    FOREIGN KEY (supplier_id) REFERENCES supplier_info(supplier_id)
) COMMENT='采购退货单表';

-- 采购退货单明细表
CREATE TABLE purchase_return_detail (
    detail_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    return_id BIGINT NOT NULL COMMENT '退货单ID',
    order_detail_id BIGINT NOT NULL COMMENT '关联采购订单明细ID',
    product_id BIGINT NOT NULL COMMENT '产品ID',
    quantity DECIMAL(10,2) NOT NULL COMMENT '退货数量',
    unit_price DECIMAL(10,2) NOT NULL COMMENT '单价',
    total_price DECIMAL(12,2) NOT NULL COMMENT '总价',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    create_time DATETIME COMMENT '创建时间',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    update_time DATETIME COMMENT '更新时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    INDEX idx_return_id (return_id),
    INDEX idx_order_detail_id (order_detail_id),
    INDEX idx_product_id (product_id),
    FOREIGN KEY (return_id) REFERENCES purchase_return(return_id) ON DELETE CASCADE,
    FOREIGN KEY (order_detail_id) REFERENCES purchase_order_detail(detail_id),
    FOREIGN KEY (product_id) REFERENCES product_info(product_id)
) COMMENT='采购退货单明细表';

-- ================================
-- 库存管理表
-- ================================

-- 仓库信息表
CREATE TABLE warehouse_info (
    warehouse_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    warehouse_code VARCHAR(20) NOT NULL UNIQUE COMMENT '仓库编码',
    warehouse_name VARCHAR(100) NOT NULL COMMENT '仓库名称',
    warehouse_type INT NOT NULL COMMENT '仓库类型，参考字典表sys_dict_data.dict_value, dict_type=erp_warehouse_type',
    address VARCHAR(200) COMMENT '仓库地址',
    contact_person VARCHAR(50) COMMENT '联系人',
    contact_phone VARCHAR(20) COMMENT '联系电话',
    capacity DECIMAL(12,2) COMMENT '仓库容量',
    area DECIMAL(10,2) COMMENT '仓库面积(平方米)',
    status CHAR(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME COMMENT '更新时间',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    INDEX idx_warehouse_code (warehouse_code),
    INDEX idx_status (status)
) COMMENT='仓库信息表';

-- 库存表
CREATE TABLE inventory_stock (
    stock_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    product_id BIGINT NOT NULL COMMENT '产品ID',
    warehouse_id BIGINT NOT NULL COMMENT '仓库ID',
    batch_no VARCHAR(50) COMMENT '批次号',
    quantity DECIMAL(12,2) DEFAULT 0 COMMENT '库存数量',
    available_quantity DECIMAL(12,2) DEFAULT 0 COMMENT '可用数量',
    locked_quantity DECIMAL(12,2) DEFAULT 0 COMMENT '锁定数量',
    unit_cost DECIMAL(10,2) DEFAULT 0 COMMENT '单位成本',
    quality_status INT DEFAULT 1 COMMENT '质量状态，参考字典表sys_dict_data.dict_value, dict_type=erp_quality_status',
    production_date DATE COMMENT '生产日期',
    expiry_date DATE COMMENT '过期日期',
    in_date DATE COMMENT '入库日期',
    supplier_id BIGINT COMMENT '供应商ID',
    last_transaction_time DATETIME COMMENT '最后交易时间',
    create_time DATETIME COMMENT '创建时间',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    update_time DATETIME COMMENT '更新时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    INDEX idx_product_id (product_id),
    INDEX idx_warehouse_id (warehouse_id),
    INDEX idx_batch_no (batch_no),
    INDEX idx_quality_status (quality_status),
    UNIQUE KEY uk_product_warehouse_batch (product_id, warehouse_id, batch_no),
    FOREIGN KEY (product_id) REFERENCES product_info(product_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouse_info(warehouse_id),
    FOREIGN KEY (supplier_id) REFERENCES supplier_info(supplier_id)
) COMMENT='库存表';

-- 库存交易记录表
CREATE TABLE inventory_transaction (
    transaction_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    transaction_no VARCHAR(30) NOT NULL UNIQUE COMMENT '交易编号',
    product_id BIGINT NOT NULL COMMENT '产品ID',
    warehouse_id BIGINT NOT NULL COMMENT '仓库ID',
    batch_no VARCHAR(50) COMMENT '批次号',
    transaction_type INT NOT NULL COMMENT '交易类型，参考字典表sys_dict_data.dict_value, dict_type=erp_transaction_type',
    transaction_source INT NOT NULL COMMENT '交易来源，参考字典表sys_dict_data.dict_value, dict_type=erp_transaction_source',
    transaction_direction INT NOT NULL COMMENT '交易方向，参考字典表sys_dict_data.dict_value, dict_type=erp_transaction_direction',
    quantity DECIMAL(12,2) NOT NULL COMMENT '交易数量',
    before_quantity DECIMAL(12,2) NOT NULL COMMENT '交易前数量',
    after_quantity DECIMAL(12,2) NOT NULL COMMENT '交易后数量',
    unit_cost DECIMAL(10,2) COMMENT '单位成本',
    total_cost DECIMAL(12,2) COMMENT '总成本',
    reference_no VARCHAR(50) COMMENT '关联单号',
    reference_type VARCHAR(50) COMMENT '关联单类型',
    remark TEXT COMMENT '备注',
    operator VARCHAR(64) DEFAULT '' COMMENT '操作人',
    transaction_time DATETIME NOT NULL COMMENT '交易时间',
    create_time DATETIME COMMENT '创建时间',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    update_time DATETIME COMMENT '更新时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    INDEX idx_transaction_no (transaction_no),
    INDEX idx_product_id (product_id),
    INDEX idx_warehouse_id (warehouse_id),
    INDEX idx_transaction_type (transaction_type),
    INDEX idx_transaction_time (transaction_time),
    INDEX idx_reference_no (reference_no),
    FOREIGN KEY (product_id) REFERENCES product_info(product_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouse_info(warehouse_id)
) COMMENT='库存交易记录表';

-- 库存调整单表
CREATE TABLE inventory_adjustment (
    adjustment_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    adjustment_no VARCHAR(30) NOT NULL UNIQUE COMMENT '调整单编号',
    warehouse_id BIGINT NOT NULL COMMENT '仓库ID',
    adjustment_type INT NOT NULL COMMENT '调整类型，参考字典表sys_dict_data.dict_value, dict_type=erp_adjustment_type',
    adjustment_reason TEXT COMMENT '调整原因',
    total_amount DECIMAL(12,2) DEFAULT 0 COMMENT '调整总金额',
    status INT DEFAULT 1 COMMENT '调整状态，参考字典表sys_dict_data.dict_value, dict_type=erp_adjustment_status',
    applicant VARCHAR(64) DEFAULT '' COMMENT '申请人',
    apply_time DATETIME COMMENT '申请时间',
    approver VARCHAR(64) DEFAULT '' COMMENT '审批人',
    approve_time DATETIME COMMENT '审批时间',
    approve_remark TEXT COMMENT '审批意见',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME COMMENT '更新时间',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    INDEX idx_adjustment_no (adjustment_no),
    INDEX idx_warehouse_id (warehouse_id),
    INDEX idx_status (status),
    INDEX idx_apply_time (apply_time),
    FOREIGN KEY (warehouse_id) REFERENCES warehouse_info(warehouse_id)
) COMMENT='库存调整单表';

-- 库存调整单明细表
CREATE TABLE inventory_adjustment_detail (
    detail_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    adjustment_id BIGINT NOT NULL COMMENT '调整单ID',
    product_id BIGINT NOT NULL COMMENT '产品ID',
    batch_no VARCHAR(50) COMMENT '批次号',
    before_quantity DECIMAL(12,2) NOT NULL COMMENT '调整前数量',
    after_quantity DECIMAL(12,2) NOT NULL COMMENT '调整后数量',
    adjustment_quantity DECIMAL(12,2) NOT NULL COMMENT '调整数量',
    unit_cost DECIMAL(10,2) COMMENT '单位成本',
    adjustment_amount DECIMAL(12,2) COMMENT '调整金额',
    quality_status INT COMMENT '调整后质量状态，参考字典表sys_dict_data.dict_value, dict_type=erp_quality_status',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    create_time DATETIME COMMENT '创建时间',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    update_time DATETIME COMMENT '更新时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    INDEX idx_adjustment_id (adjustment_id),
    INDEX idx_product_id (product_id),
    INDEX idx_batch_no (batch_no),
    FOREIGN KEY (adjustment_id) REFERENCES inventory_adjustment(adjustment_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product_info(product_id)
) COMMENT='库存调整单明细表';

-- 库存盘点单表
CREATE TABLE inventory_check (
    check_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    check_no VARCHAR(30) NOT NULL UNIQUE COMMENT '盘点单编号',
    warehouse_id BIGINT NOT NULL COMMENT '仓库ID',
    check_type INT NOT NULL COMMENT '盘点类型，参考字典表sys_dict_data.dict_value, dict_type=erp_check_type',
    check_status INT DEFAULT 1 COMMENT '盘点状态，参考字典表sys_dict_data.dict_value, dict_type=erp_check_status',
    system_total_quantity DECIMAL(12,2) DEFAULT 0 COMMENT '系统总数量',
    system_total_amount DECIMAL(12,2) DEFAULT 0 COMMENT '系统总金额',
    actual_total_quantity DECIMAL(12,2) DEFAULT 0 COMMENT '实际总数量',
    actual_total_amount DECIMAL(12,2) DEFAULT 0 COMMENT '实际总金额',
    difference_quantity DECIMAL(12,2) DEFAULT 0 COMMENT '差异数量',
    difference_amount DECIMAL(12,2) DEFAULT 0 COMMENT '差异金额',
    check_date DATE COMMENT '盘点日期',
    applicant VARCHAR(64) DEFAULT '' COMMENT '申请人',
    apply_time DATETIME COMMENT '申请时间',
    approver VARCHAR(64) DEFAULT '' COMMENT '审批人',
    approve_time DATETIME COMMENT '审批时间',
    approve_remark TEXT COMMENT '审批意见',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME COMMENT '更新时间',
    remark TEXT COMMENT '备注',
    INDEX idx_check_no (check_no),
    INDEX idx_warehouse_id (warehouse_id),
    INDEX idx_status (check_status),
    INDEX idx_check_date (check_date),
    FOREIGN KEY (warehouse_id) REFERENCES warehouse_info(warehouse_id)
) COMMENT='库存盘点单表';

-- 库存盘点单明细表
CREATE TABLE inventory_check_detail (
    detail_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    check_id BIGINT NOT NULL COMMENT '盘点单ID',
    product_id BIGINT NOT NULL COMMENT '产品ID',
    warehouse_id BIGINT NOT NULL COMMENT '仓库ID',
    batch_no VARCHAR(50) COMMENT '批次号',
    system_quantity DECIMAL(12,2) NOT NULL COMMENT '系统数量',
    actual_quantity DECIMAL(12,2) NOT NULL COMMENT '实际数量',
    difference_quantity DECIMAL(12,2) NOT NULL COMMENT '差异数量',
    unit_cost DECIMAL(10,2) COMMENT '单位成本',
    difference_amount DECIMAL(12,2) COMMENT '差异金额',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    create_time DATETIME COMMENT '创建时间',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    update_time DATETIME COMMENT '更新时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    INDEX idx_check_id (check_id),
    INDEX idx_product_id (product_id),
    INDEX idx_warehouse_id (warehouse_id),
    INDEX idx_batch_no (batch_no),
    FOREIGN KEY (check_id) REFERENCES inventory_check(check_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product_info(product_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouse_info(warehouse_id)
) COMMENT='库存盘点单明细表';

-- 库存调拨单表
CREATE TABLE inventory_transfer (
    transfer_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    transfer_no VARCHAR(30) NOT NULL UNIQUE COMMENT '调拨单编号',
    from_warehouse_id BIGINT NOT NULL COMMENT '调出仓库ID',
    to_warehouse_id BIGINT NOT NULL COMMENT '调入仓库ID',
    transfer_reason TEXT COMMENT '调拨原因',
    total_amount DECIMAL(12,2) DEFAULT 0 COMMENT '调拨总金额',
    status INT DEFAULT 1 COMMENT '调拨状态，参考字典表sys_dict_data.dict_value, dict_type=erp_transfer_status',
    applicant VARCHAR(64) DEFAULT '' COMMENT '申请人',
    apply_time DATETIME COMMENT '申请时间',
    approver VARCHAR(64) DEFAULT '' COMMENT '审批人',
    approve_time DATETIME COMMENT '审批时间',
    approve_remark TEXT COMMENT '审批意见',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME COMMENT '更新时间',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    INDEX idx_transfer_no (transfer_no),
    INDEX idx_from_warehouse_id (from_warehouse_id),
    INDEX idx_to_warehouse_id (to_warehouse_id),
    INDEX idx_status (status),
    INDEX idx_apply_time (apply_time),
    FOREIGN KEY (from_warehouse_id) REFERENCES warehouse_info(warehouse_id),
    FOREIGN KEY (to_warehouse_id) REFERENCES warehouse_info(warehouse_id)
) COMMENT='库存调拨单表';

-- 库存调拨单明细表
CREATE TABLE inventory_transfer_detail (
    detail_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    transfer_id BIGINT NOT NULL COMMENT '调拨单ID',
    product_id BIGINT NOT NULL COMMENT '产品ID',
    from_batch_no VARCHAR(50) COMMENT '调出批次号',
    to_batch_no VARCHAR(50) COMMENT '调入批次号',
    quantity DECIMAL(12,2) NOT NULL COMMENT '调拨数量',
    unit_cost DECIMAL(10,2) NOT NULL COMMENT '单位成本',
    total_cost DECIMAL(12,2) NOT NULL COMMENT '总成本',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    create_time DATETIME COMMENT '创建时间',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    update_time DATETIME COMMENT '更新时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    INDEX idx_transfer_id (transfer_id),
    INDEX idx_product_id (product_id),
    FOREIGN KEY (transfer_id) REFERENCES inventory_transfer(transfer_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product_info(product_id)
) COMMENT='库存调拨单明细表';

-- 库存预警表
CREATE TABLE inventory_alert (
    alert_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    product_id BIGINT NOT NULL COMMENT '产品ID',
    warehouse_id BIGINT NOT NULL COMMENT '仓库ID',
    alert_type INT NOT NULL COMMENT '预警类型，参考字典表sys_dict_data.dict_value, dict_type=erp_alert_type',
    alert_level INT NOT NULL COMMENT '预警级别，参考字典表sys_dict_data.dict_value, dict_type=erp_alert_level',
    alert_status INT DEFAULT 1 COMMENT '预警状态，参考字典表sys_dict_data.dict_value, dict_type=erp_alert_status',
    min_quantity DECIMAL(12,2) COMMENT '最小库存量',
    max_quantity DECIMAL(12,2) COMMENT '最大库存量',
    current_quantity DECIMAL(12,2) COMMENT '当前库存量',
    alert_message TEXT COMMENT '预警信息',
    create_time DATETIME COMMENT '创建时间',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    update_time DATETIME COMMENT '更新时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    INDEX idx_product_id (product_id),
    INDEX idx_warehouse_id (warehouse_id),
    INDEX idx_alert_type (alert_type),
    INDEX idx_alert_level (alert_level),
    INDEX idx_alert_status (alert_status),
    FOREIGN KEY (product_id) REFERENCES product_info(product_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouse_info(warehouse_id)
) COMMENT='库存预警表';

-- ================================
-- 销售管理表
-- ================================

-- 客户信息表
CREATE TABLE customer_info (
    customer_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    customer_code VARCHAR(20) NOT NULL UNIQUE COMMENT '客户编码',
    customer_name VARCHAR(100) NOT NULL COMMENT '客户名称',
    customer_type INT NOT NULL COMMENT '客户类型，参考字典表sys_dict_data.dict_value, dict_type=erp_customer_type',
    business_type INT NOT NULL COMMENT '业务类型，参考字典表sys_dict_data.dict_value, dict_type=erp_business_type',
    credit_rating INT DEFAULT 2 COMMENT '信用等级，参考字典表sys_dict_data.dict_value, dict_type=erp_credit_rating',
    contact_person VARCHAR(50) COMMENT '联系人',
    contact_phone VARCHAR(20) COMMENT '联系电话',
    wechat VARCHAR(50) COMMENT '微信号',
    email VARCHAR(100) COMMENT '邮箱',
    company_phone VARCHAR(20) COMMENT '公司固话',
    business_license_path VARCHAR(500) COMMENT '营业执照附件路径',
    credit_code VARCHAR(50) COMMENT '统一社会信用代码',
    office_address VARCHAR(200) COMMENT '办公地址',
    delivery_address VARCHAR(200) COMMENT '收货地址',
    invoice_title VARCHAR(200) COMMENT '发票抬头',
    tax_no VARCHAR(50) COMMENT '税号',
    bank_name VARCHAR(100) COMMENT '开户银行',
    bank_account VARCHAR(50) COMMENT '银行账号',
    settlement_method INT COMMENT '结算方式',
    credit_limit DECIMAL(12,2) DEFAULT 0 COMMENT '信用额度',
    credit_used DECIMAL(12,2) DEFAULT 0 COMMENT '已用额度',
    status CHAR(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME COMMENT '更新时间',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    INDEX idx_customer_code (customer_code),
    INDEX idx_customer_name (customer_name),
    INDEX idx_customer_type (customer_type),
    INDEX idx_credit_rating (credit_rating),
    INDEX idx_status (status)
) COMMENT='客户信息表';

-- 销售报价表
CREATE TABLE sales_quote (
    quote_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    quote_no VARCHAR(30) NOT NULL UNIQUE COMMENT '报价单编号',
    customer_id BIGINT NOT NULL COMMENT '客户ID',
    quote_name VARCHAR(200) NOT NULL COMMENT '报价名称',
    total_amount DECIMAL(12,2) DEFAULT 0 COMMENT '总金额',
    currency VARCHAR(10) DEFAULT 'CNY' COMMENT '币种',
    valid_from DATE COMMENT '有效开始日期',
    valid_to DATE COMMENT '有效结束日期',
    status INT DEFAULT 1 COMMENT '报价状态，参考字典表sys_dict_data.dict_value, dict_type=erp_quote_status',
    applicant VARCHAR(64) DEFAULT '' COMMENT '申请人',
    apply_time DATETIME COMMENT '申请时间',
    approver VARCHAR(64) DEFAULT '' COMMENT '审批人',
    approve_time DATETIME COMMENT '审批时间',
    approve_remark TEXT COMMENT '审批意见',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME COMMENT '更新时间',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    INDEX idx_quote_no (quote_no),
    INDEX idx_customer_id (customer_id),
    INDEX idx_status (status),
    INDEX idx_valid_from (valid_from),
    INDEX idx_valid_to (valid_to),
    FOREIGN KEY (customer_id) REFERENCES customer_info(customer_id)
) COMMENT='销售报价表';

-- 销售报价明细表
CREATE TABLE sales_quote_detail (
    detail_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    quote_id BIGINT NOT NULL COMMENT '报价单ID',
    product_id BIGINT NOT NULL COMMENT '产品ID',
    quantity DECIMAL(10,2) NOT NULL COMMENT '数量',
    unit_price DECIMAL(10,2) NOT NULL COMMENT '单价',
    total_price DECIMAL(12,2) NOT NULL COMMENT '总价',
    discount_rate DECIMAL(5,2) DEFAULT 0 COMMENT '折扣率(%)',
    discount_amount DECIMAL(12,2) DEFAULT 0 COMMENT '折扣金额',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    create_time DATETIME COMMENT '创建时间',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    update_time DATETIME COMMENT '更新时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    INDEX idx_quote_id (quote_id),
    INDEX idx_product_id (product_id),
    FOREIGN KEY (quote_id) REFERENCES sales_quote(quote_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product_info(product_id)
) COMMENT='销售报价明细表';

-- 销售订单表
CREATE TABLE sales_order (
    order_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_no VARCHAR(30) NOT NULL UNIQUE COMMENT '订单编号',
    customer_id BIGINT NOT NULL COMMENT '客户ID',
    quote_id BIGINT COMMENT '关联报价单ID',
    order_type INT NOT NULL COMMENT '订单类型，参考字典表sys_dict_data.dict_value, dict_type=erp_sales_order_type',
    order_amount DECIMAL(12,2) DEFAULT 0 COMMENT '订单金额',
    discount_amount DECIMAL(12,2) DEFAULT 0 COMMENT '折扣金额',
    actual_amount DECIMAL(12,2) DEFAULT 0 COMMENT '实际金额',
    payment_method INT COMMENT '付款方式，参考字典表sys_dict_data.dict_value, dict_type=erp_payment_method',
    payment_status INT DEFAULT 1 COMMENT '付款状态，参考字典表sys_dict_data.dict_value, dict_type=erp_payment_status',
    delivery_address TEXT COMMENT '收货地址',
    delivery_date DATE COMMENT '期望交货日期',
    delivery_method VARCHAR(50) COMMENT '配送方式',
    logistics_company VARCHAR(100) COMMENT '物流公司',
    tracking_no VARCHAR(50) COMMENT '物流单号',
    freight DECIMAL(10,2) DEFAULT 0 COMMENT '运费',
    weight DECIMAL(10,2) COMMENT '重量',
    invoice_requested CHAR(1) DEFAULT '0' COMMENT '是否需要开票（0否 1是）',
    invoice_title VARCHAR(200) COMMENT '发票抬头',
    tax_no VARCHAR(50) COMMENT '税号',
    salesman VARCHAR(64) DEFAULT '' COMMENT '业务员',
    order_source VARCHAR(100) COMMENT '订单来源',
    platform_order_no VARCHAR(50) COMMENT '平台订单号',
    status INT DEFAULT 1 COMMENT '订单状态，参考字典表sys_dict_data.dict_value, dict_type=erp_sales_order_status',
    reject_reason TEXT COMMENT '驳回原因',
    applicant VARCHAR(64) DEFAULT '' COMMENT '申请人',
    apply_time DATETIME COMMENT '申请时间',
    approver VARCHAR(64) DEFAULT '' COMMENT '审批人',
    approve_time DATETIME COMMENT '审批时间',
    approve_remark TEXT COMMENT '审批意见',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME COMMENT '更新时间',
    remark TEXT COMMENT '备注',
    INDEX idx_order_no (order_no),
    INDEX idx_customer_id (customer_id),
    INDEX idx_quote_id (quote_id),
    INDEX idx_order_type (order_type),
    INDEX idx_status (status),
    INDEX idx_payment_status (payment_status),
    INDEX idx_apply_time (apply_time),
    INDEX idx_platform_order_no (platform_order_no),
    FOREIGN KEY (customer_id) REFERENCES customer_info(customer_id),
    FOREIGN KEY (quote_id) REFERENCES sales_quote(quote_id)
) COMMENT='销售订单表';

-- 销售订单明细表
CREATE TABLE sales_order_detail (
    detail_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_id BIGINT NOT NULL COMMENT '销售订单ID',
    product_id BIGINT NOT NULL COMMENT '产品ID',
    quantity DECIMAL(10,2) NOT NULL COMMENT '销售数量',
    delivery_quantity DECIMAL(10,2) DEFAULT 0 COMMENT '发货数量',
    unit_price DECIMAL(10,2) NOT NULL COMMENT '销售单价',
    total_price DECIMAL(12,2) NOT NULL COMMENT '销售总价',
    discount_rate DECIMAL(5,2) DEFAULT 0 COMMENT '折扣率(%)',
    discount_amount DECIMAL(12,2) DEFAULT 0 COMMENT '折扣金额',
    actual_price DECIMAL(10,2) NOT NULL COMMENT '实际单价',
    actual_total DECIMAL(12,2) NOT NULL COMMENT '实际总价',
    warehouse_id BIGINT COMMENT '发货仓库ID',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    create_time DATETIME COMMENT '创建时间',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    update_time DATETIME COMMENT '更新时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    INDEX idx_order_id (order_id),
    INDEX idx_product_id (product_id),
    INDEX idx_warehouse_id (warehouse_id),
    FOREIGN KEY (order_id) REFERENCES sales_order(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product_info(product_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouse_info(warehouse_id)
) COMMENT='销售订单明细表';

-- 销售出库单表
CREATE TABLE sales_outbound (
    outbound_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    outbound_no VARCHAR(30) NOT NULL UNIQUE COMMENT '出库单编号',
    order_id BIGINT NOT NULL COMMENT '销售订单ID',
    warehouse_id BIGINT NOT NULL COMMENT '仓库ID',
    batch_no VARCHAR(50) COMMENT '批次号',
    outbound_amount DECIMAL(12,2) DEFAULT 0 COMMENT '出库金额',
    logistics_company VARCHAR(100) COMMENT '物流公司',
    tracking_no VARCHAR(50) COMMENT '物流单号',
    freight DECIMAL(10,2) DEFAULT 0 COMMENT '运费',
    weight DECIMAL(10,2) COMMENT '重量',
    out_time DATETIME COMMENT '出库时间',
    operator VARCHAR(64) DEFAULT '' COMMENT '操作人',
    status INT DEFAULT 1 COMMENT '出库状态',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME COMMENT '更新时间',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    INDEX idx_outbound_no (outbound_no),
    INDEX idx_order_id (order_id),
    INDEX idx_warehouse_id (warehouse_id),
    INDEX idx_tracking_no (tracking_no),
    INDEX idx_out_time (out_time),
    FOREIGN KEY (order_id) REFERENCES sales_order(order_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouse_info(warehouse_id)
) COMMENT='销售出库单表';

-- 销售出库单明细表
CREATE TABLE sales_outbound_detail (
    detail_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    outbound_id BIGINT NOT NULL COMMENT '出库单ID',
    order_detail_id BIGINT NOT NULL COMMENT '销售订单明细ID',
    product_id BIGINT NOT NULL COMMENT '产品ID',
    warehouse_id BIGINT NOT NULL COMMENT '仓库ID',
    batch_no VARCHAR(50) COMMENT '批次号',
    quantity DECIMAL(10,2) NOT NULL COMMENT '出库数量',
    unit_cost DECIMAL(10,2) NOT NULL COMMENT '单位成本',
    total_cost DECIMAL(12,2) NOT NULL COMMENT '总成本',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    create_time DATETIME COMMENT '创建时间',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    update_time DATETIME COMMENT '更新时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    INDEX idx_outbound_id (outbound_id),
    INDEX idx_order_detail_id (order_detail_id),
    INDEX idx_product_id (product_id),
    INDEX idx_warehouse_id (warehouse_id),
    INDEX idx_batch_no (batch_no),
    FOREIGN KEY (outbound_id) REFERENCES sales_outbound(outbound_id) ON DELETE CASCADE,
    FOREIGN KEY (order_detail_id) REFERENCES sales_order_detail(detail_id),
    FOREIGN KEY (product_id) REFERENCES product_info(product_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouse_info(warehouse_id)
) COMMENT='销售出库单明细表';

-- 销售退货单表
CREATE TABLE sales_return (
    return_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    return_no VARCHAR(30) NOT NULL UNIQUE COMMENT '退货单编号',
    order_id BIGINT NOT NULL COMMENT '销售订单ID',
    customer_id BIGINT NOT NULL COMMENT '客户ID',
    return_amount DECIMAL(12,2) DEFAULT 0 COMMENT '退货金额',
    return_reason TEXT COMMENT '退货原因',
    return_type INT COMMENT '退货类型，参考字典表sys_dict_data.dict_value, dict_type=erp_return_type',
    status INT DEFAULT 1 COMMENT '退货状态，参考字典表sys_dict_data.dict_value, dict_type=erp_return_status',
    warehouse_id BIGINT COMMENT '入库仓库ID',
    applicant VARCHAR(64) DEFAULT '' COMMENT '申请人',
    apply_time DATETIME COMMENT '申请时间',
    approver VARCHAR(64) DEFAULT '' COMMENT '审批人',
    approve_time DATETIME COMMENT '审批时间',
    approve_remark TEXT COMMENT '审批意见',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME COMMENT '更新时间',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    INDEX idx_return_no (return_no),
    INDEX idx_order_id (order_id),
    INDEX idx_customer_id (customer_id),
    INDEX idx_status (status),
    FOREIGN KEY (order_id) REFERENCES sales_order(order_id),
    FOREIGN KEY (customer_id) REFERENCES customer_info(customer_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouse_info(warehouse_id)
) COMMENT='销售退货单表';

-- 销售退货单明细表
CREATE TABLE sales_return_detail (
    detail_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    return_id BIGINT NOT NULL COMMENT '退货单ID',
    order_detail_id BIGINT NOT NULL COMMENT '销售订单明细ID',
    product_id BIGINT NOT NULL COMMENT '产品ID',
    quantity DECIMAL(10,2) NOT NULL COMMENT '退货数量',
    unit_price DECIMAL(10,2) NOT NULL COMMENT '单价',
    total_price DECIMAL(12,2) NOT NULL COMMENT '总价',
    warehouse_id BIGINT COMMENT '入库仓库ID',
    batch_no VARCHAR(50) COMMENT '入库批次号',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    create_time DATETIME COMMENT '创建时间',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    update_time DATETIME COMMENT '更新时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    INDEX idx_return_id (return_id),
    INDEX idx_order_detail_id (order_detail_id),
    INDEX idx_product_id (product_id),
    INDEX idx_warehouse_id (warehouse_id),
    FOREIGN KEY (return_id) REFERENCES sales_return(return_id) ON DELETE CASCADE,
    FOREIGN KEY (order_detail_id) REFERENCES sales_order_detail(detail_id),
    FOREIGN KEY (product_id) REFERENCES product_info(product_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouse_info(warehouse_id)
) COMMENT='销售退货单明细表';

-- 发票申请表
CREATE TABLE invoice_application (
    application_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    application_no VARCHAR(30) NOT NULL UNIQUE COMMENT '申请单编号',
    order_id BIGINT NOT NULL COMMENT '销售订单ID',
    customer_id BIGINT NOT NULL COMMENT '客户ID',
    invoice_type INT COMMENT '发票类型',
    invoice_title VARCHAR(200) COMMENT '发票抬头',
    tax_no VARCHAR(50) COMMENT '税号',
    invoice_amount DECIMAL(12,2) NOT NULL COMMENT '发票金额',
    tax_amount DECIMAL(12,2) COMMENT '税额',
    invoice_content TEXT COMMENT '发票内容',
    remark TEXT COMMENT '备注',
    status INT DEFAULT 1 COMMENT '申请状态，参考字典表sys_dict_data.dict_value, dict_type=erp_invoice_app_status',
    invoice_no VARCHAR(50) COMMENT '发票号码',
    invoice_date DATE COMMENT '发票日期',
    invoice_path VARCHAR(500) COMMENT '发票附件路径',
    applicant VARCHAR(64) DEFAULT '' COMMENT '申请人',
    apply_time DATETIME COMMENT '申请时间',
    approver VARCHAR(64) DEFAULT '' COMMENT '审批人',
    approve_time DATETIME COMMENT '审批时间',
    approve_remark TEXT COMMENT '审批意见',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME COMMENT '更新时间',
    INDEX idx_application_no (application_no),
    INDEX idx_order_id (order_id),
    INDEX idx_customer_id (customer_id),
    INDEX idx_status (status),
    FOREIGN KEY (order_id) REFERENCES sales_order(order_id),
    FOREIGN KEY (customer_id) REFERENCES customer_info(customer_id)
) COMMENT='发票申请表';

-- ================================
-- 财务管理表
-- ================================

-- 应收账款表
CREATE TABLE accounts_receivable (
    ar_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ar_no VARCHAR(30) NOT NULL UNIQUE COMMENT '应收单编号',
    order_id BIGINT NOT NULL COMMENT '销售订单ID',
    customer_id BIGINT NOT NULL COMMENT '客户ID',
    ar_amount DECIMAL(12,2) NOT NULL COMMENT '应收金额',
    received_amount DECIMAL(12,2) DEFAULT 0 COMMENT '已收金额',
    balance_amount DECIMAL(12,2) GENERATED ALWAYS AS (ar_amount - received_amount) STORED COMMENT '余额',
    due_date DATE COMMENT '到期日期',
    invoice_no VARCHAR(50) COMMENT '关联发票号',
    status INT DEFAULT 1 COMMENT '应收状态，参考字典表sys_dict_data.dict_value, dict_type=erp_ar_status',
    remark TEXT COMMENT '备注',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME COMMENT '更新时间',
    INDEX idx_ar_no (ar_no),
    INDEX idx_order_id (order_id),
    INDEX idx_customer_id (customer_id),
    INDEX idx_status (status),
    INDEX idx_due_date (due_date),
    FOREIGN KEY (order_id) REFERENCES sales_order(order_id),
    FOREIGN KEY (customer_id) REFERENCES customer_info(customer_id)
) COMMENT='应收账款表';

-- 应收账款明细表（收款记录）
CREATE TABLE ar_payment_record (
    payment_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ar_id BIGINT NOT NULL COMMENT '应收ID',
    payment_no VARCHAR(30) NOT NULL UNIQUE COMMENT '收款单编号',
    payment_amount DECIMAL(12,2) NOT NULL COMMENT '收款金额',
    payment_method INT COMMENT '付款方式，参考字典表sys_dict_data.dict_value, dict_type=erp_payment_method',
    payment_account VARCHAR(100) COMMENT '付款账户',
    payment_date DATE COMMENT '付款日期',
    transaction_no VARCHAR(50) COMMENT '交易流水号',
    status INT DEFAULT 2 COMMENT '收款状态，参考字典表sys_dict_data.dict_value, dict_type=erp_payment_record_status',
    remark TEXT COMMENT '备注',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME COMMENT '创建时间',
    update_time DATETIME COMMENT '更新时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    INDEX idx_ar_id (ar_id),
    INDEX idx_payment_no (payment_no),
    INDEX idx_payment_method (payment_method),
    INDEX idx_payment_date (payment_date),
    INDEX idx_status (status),
    FOREIGN KEY (ar_id) REFERENCES accounts_receivable(ar_id)
) COMMENT='应收账款明细表';

-- 应付账款表
CREATE TABLE accounts_payable (
    ap_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ap_no VARCHAR(30) NOT NULL UNIQUE COMMENT '应付单编号',
    order_id BIGINT COMMENT '关联采购订单ID',
    supplier_id BIGINT NOT NULL COMMENT '供应商ID',
    ap_amount DECIMAL(12,2) NOT NULL COMMENT '应付金额',
    paid_amount DECIMAL(12,2) DEFAULT 0 COMMENT '已付金额',
    balance_amount DECIMAL(12,2) GENERATED ALWAYS AS (ap_amount - paid_amount) STORED COMMENT '余额',
    due_date DATE COMMENT '到期日期',
    invoice_no VARCHAR(50) COMMENT '关联发票号',
    status INT DEFAULT 1 COMMENT '应付状态，参考字典表sys_dict_data.dict_value, dict_type=erp_ap_status',
    remark TEXT COMMENT '备注',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME COMMENT '更新时间',
    INDEX idx_ap_no (ap_no),
    INDEX idx_order_id (order_id),
    INDEX idx_supplier_id (supplier_id),
    INDEX idx_status (status),
    INDEX idx_due_date (due_date),
    FOREIGN KEY (order_id) REFERENCES purchase_order(order_id),
    FOREIGN KEY (supplier_id) REFERENCES supplier_info(supplier_id)
) COMMENT='应付账款表';

-- 应付账款明细表（付款记录）
CREATE TABLE ap_payment_record (
    payment_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ap_id BIGINT NOT NULL COMMENT '应付ID',
    payment_no VARCHAR(30) NOT NULL UNIQUE COMMENT '付款单编号',
    payment_amount DECIMAL(12,2) NOT NULL COMMENT '付款金额',
    payment_method INT COMMENT '供应商付款方式，参考字典表sys_dict_data.dict_value, dict_type=erp_supplier_payment_method',
    payment_account VARCHAR(100) COMMENT '付款账户',
    payment_date DATE COMMENT '付款日期',
    transaction_no VARCHAR(50) COMMENT '交易流水号',
    status INT DEFAULT 2 COMMENT '供应商付款状态，参考字典表sys_dict_data.dict_value, dict_type=erp_supplier_payment_status',
    remark TEXT COMMENT '备注',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME COMMENT '创建时间',
    update_time DATETIME COMMENT '更新时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    INDEX idx_ap_id (ap_id),
    INDEX idx_payment_no (payment_no),
    INDEX idx_payment_method (payment_method),
    INDEX idx_payment_date (payment_date),
    INDEX idx_status (status),
    FOREIGN KEY (ap_id) REFERENCES accounts_payable(ap_id)
) COMMENT='应付账款明细表';

-- 财务科目表
CREATE TABLE finance_subject (
    subject_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    subject_code VARCHAR(20) NOT NULL UNIQUE COMMENT '科目编码',
    subject_name VARCHAR(100) NOT NULL COMMENT '科目名称',
    parent_id BIGINT DEFAULT 0 COMMENT '父科目ID',
    subject_level INT DEFAULT 1 COMMENT '科目层级',
    subject_type INT COMMENT '科目类型，参考字典表sys_dict_data.dict_value, dict_type=erp_subject_type',
    balance_direction INT COMMENT '余额方向，参考字典表sys_dict_data.dict_value, dict_type=erp_balance_direction',
    is_leaf CHAR(1) DEFAULT '1' COMMENT '是否叶子节点（0否 1是）',
    status CHAR(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME COMMENT '更新时间',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    INDEX idx_subject_code (subject_code),
    INDEX idx_parent_id (parent_id),
    INDEX idx_subject_type (subject_type),
    INDEX idx_status (status)
) COMMENT='财务科目表';

-- 会计凭证表
CREATE TABLE finance_voucher (
    voucher_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    voucher_no VARCHAR(30) NOT NULL UNIQUE COMMENT '凭证编号',
    voucher_date DATE NOT NULL COMMENT '凭证日期',
    voucher_type INT COMMENT '凭证类型，参考字典表sys_dict_data.dict_value, dict_type=erp_voucher_type',
    status INT DEFAULT 1 COMMENT '凭证状态，参考字典表sys_dict_data.dict_value, dict_type=erp_voucher_status',
    total_debit DECIMAL(15,2) DEFAULT 0 COMMENT '借方总额',
    total_credit DECIMAL(15,2) DEFAULT 0 COMMENT '贷方总额',
    summary TEXT COMMENT '凭证摘要',
    remark TEXT COMMENT '备注',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME COMMENT '更新时间',
    INDEX idx_voucher_no (voucher_no),
    INDEX idx_voucher_date (voucher_date),
    INDEX idx_voucher_type (voucher_type),
    INDEX idx_status (status)
) COMMENT='会计凭证表';

-- 会计凭证明细表
CREATE TABLE finance_voucher_detail (
    detail_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    voucher_id BIGINT NOT NULL COMMENT '凭证ID',
    subject_id BIGINT NOT NULL COMMENT '科目ID',
    summary VARCHAR(500) COMMENT '摘要',
    debit_amount DECIMAL(15,2) DEFAULT 0 COMMENT '借方金额',
    credit_amount DECIMAL(15,2) DEFAULT 0 COMMENT '贷方金额',
    currency VARCHAR(10) DEFAULT 'CNY' COMMENT '币种',
    exchange_rate DECIMAL(10,6) DEFAULT 1 COMMENT '汇率',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    create_time DATETIME COMMENT '创建时间',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    update_time DATETIME COMMENT '更新时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    INDEX idx_voucher_id (voucher_id),
    INDEX idx_subject_id (subject_id),
    FOREIGN KEY (voucher_id) REFERENCES finance_voucher(voucher_id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES finance_subject(subject_id)
) COMMENT='会计凭证明细表';

-- 成本核算表
CREATE TABLE cost_calculation (
    cost_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    product_id BIGINT NOT NULL COMMENT '产品ID',
    warehouse_id BIGINT NOT NULL COMMENT '仓库ID',
    batch_no VARCHAR(50) COMMENT '批次号',
    unit_cost DECIMAL(10,2) NOT NULL COMMENT '单位成本',
    material_cost DECIMAL(10,2) DEFAULT 0 COMMENT '材料成本',
    labor_cost DECIMAL(10,2) DEFAULT 0 COMMENT '人工成本',
    overhead_cost DECIMAL(10,2) DEFAULT 0 COMMENT '制造费用',
    other_cost DECIMAL(10,2) DEFAULT 0 COMMENT '其他成本',
    cost_date DATE NOT NULL COMMENT '成本核算日期',
    quantity DECIMAL(12,2) NOT NULL COMMENT '核算数量',
    total_cost DECIMAL(12,2) NOT NULL COMMENT '总成本',
    calculation_method VARCHAR(100) COMMENT '计算方法',
    remark TEXT COMMENT '备注',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME COMMENT '创建时间',
    update_time DATETIME COMMENT '更新时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    INDEX idx_product_id (product_id),
    INDEX idx_warehouse_id (warehouse_id),
    INDEX idx_batch_no (batch_no),
    INDEX idx_cost_date (cost_date),
    FOREIGN KEY (product_id) REFERENCES product_info(product_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouse_info(warehouse_id)
) COMMENT='成本核算表';

-- ================================
-- 初始化数据
-- ================================

-- 初始化产品类目
INSERT INTO product_category (category_name, parent_id, sort_order, create_by, create_time, remark) VALUES 
('游戏', 0, 1, 'admin', NOW(), '游戏类产品'),
('3C类', 0, 2, 'admin', NOW(), '3C电子产品'),
('母婴', 0, 3, 'admin', NOW(), '母婴用品'),
('汽配', 0, 4, 'admin', NOW(), '汽车配件'),
('户外运动', 0, 5, 'admin', NOW(), '户外运动用品'),
('玩具', 0, 6, 'admin', NOW(), '玩具产品'),
('家居', 0, 7, 'admin', NOW(), '家居用品');

-- 初始化产品分类
INSERT INTO product_classification (classification_name, subtype_name, sort_order, create_by, create_time, remark) VALUES 
('成品', '外采-入库-销售', 1, 'admin', NOW(), '外采成品'),
('成品', '内部生产-入库-销售', 2, 'admin', NOW(), '内部生产成品'),
('半成品', '可以直接单品销售', 3, 'admin', NOW(), '可单售半成品'),
('半成品', '需要组合销售', 4, 'admin', NOW(), '需组合半成品'),
('物料', '来料生产类型', 5, 'admin', NOW(), '生产物料'),
('物料', '包含相配对的包装辅料', 6, 'admin', NOW(), '包装物料'),
('包装辅料', '彩盒', 7, 'admin', NOW(), '彩盒'),
('包装辅料', '外箱', 8, 'admin', NOW(), '外箱'),
('包装辅料', '胶布', 9, 'admin', NOW(), '胶布'),
('包装辅料', '标签纸', 10, 'admin', NOW(), '标签纸'),
('包装辅料', '辅料', 11, 'admin', NOW(), '其他辅料');

-- 创建ERP数据库用户和权限
-- 创建ERP业务用户（需要在实际环境中执行）
-- GRANT SELECT, INSERT, UPDATE, DELETE ON ry.* TO 'erp_business'@'%' IDENTIFIED BY 'ERP_Business_2025';
-- FLUSH PRIVILEGES;

-- ================================
-- 完成
-- ================================

-- 初始化默认仓库
INSERT INTO warehouse_info (warehouse_code, warehouse_name, warehouse_type, address, contact_person, contact_phone, status, create_by, create_time) VALUES 
('WH001', '主仓库', 1, '默认仓库地址', '系统管理员', '400-123-4567', '0', 'admin', NOW());

SELECT 'ERP业务字典和基础表初始化完成！' AS message;