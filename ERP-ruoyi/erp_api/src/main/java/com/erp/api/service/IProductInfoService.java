package com.erp.api.service;

import java.util.List;
import com.erp.api.domain.ProductInfo;

/**
 * 产品管理Service接口
 * 
 * @author dg
 * @date 2025-11-06
 */
public interface IProductInfoService 
{
    /**
     * 查询产品管理
     * 
     * @param productId 产品管理主键
     * @return 产品管理
     */
    public ProductInfo selectProductInfoByProductId(Long productId);

    /**
     * 查询产品管理列表
     * 
     * @param productInfo 产品管理
     * @return 产品管理集合
     */
    public List<ProductInfo> selectProductInfoList(ProductInfo productInfo);

    /**
     * 新增产品管理
     * 
     * @param productInfo 产品管理
     * @return 结果
     */
    public int insertProductInfo(ProductInfo productInfo);

    /**
     * 修改产品管理
     * 
     * @param productInfo 产品管理
     * @return 结果
     */
    public int updateProductInfo(ProductInfo productInfo);

    /**
     * 批量删除产品管理
     * 
     * @param productIds 需要删除的产品管理主键集合
     * @return 结果
     */
    public int deleteProductInfoByProductIds(Long[] productIds);

    /**
     * 删除产品管理信息
     * 
     * @param productId 产品管理主键
     * @return 结果
     */
    public int deleteProductInfoByProductId(Long productId);

    /**
     * 获取下一个SKU序号
     * 
     * @param productType 产品类型
     * @param categoryId 产品类目
     * @param classificationId 产品分类
     * @return 下一个序号
     */
    public int getNextSkuSequence(Integer productType, Integer categoryId, Integer classificationId);

    /**
     * 检查SKU是否重复
     * 
     * @param productCode SKU编码
     * @param excludeProductId 排除的产品ID（用于编辑时排除自己）
     * @return 是否重复
     */
    public boolean checkSkuDuplicate(String productCode, Long excludeProductId);
}
