package com.erp.api.mapper;

import java.util.List;
import com.erp.api.domain.ProductInfo;
import com.erp.api.domain.ProductClassification;

/**
 * 产品管理Mapper接口
 * 
 * @author dg
 * @date 2025-11-06
 */
public interface ProductInfoMapper 
{
    /**
     * 查询产品管理
     * 
     * @param productId 产品管理主键
     * @return 产品管理
     */
    public ProductInfo selectProductInfoByProductId(Long productId);

    /**
     * 查询产品管理（包含图片信息）
     * 
     * @param productId 产品管理主键
     * @return 产品管理
     */
    public ProductInfo selectProductInfoWithImages(Long productId);

    /**
     * 查询产品管理列表
     * 
     * @param productInfo 产品管理
     * @return 产品管理集合
     */
    public List<ProductInfo> selectProductInfoList(ProductInfo productInfo);

    /**
     * 查询产品管理列表（包含主图信息）
     * 
     * @param productInfo 产品管理
     * @return 产品管理集合
     */
    public List<ProductInfo> selectProductInfoListWithPrimaryImage(ProductInfo productInfo);

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
     * 删除产品管理
     * 
     * @param productId 产品管理主键
     * @return 结果
     */
    public int deleteProductInfoByProductId(Long productId);

    /**
     * 批量删除产品管理
     * 
     * @param productIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteProductInfoByProductIds(Long[] productIds);

    /**
     * 批量删除产品分类
     * 
     * @param productIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteProductClassificationByClassificationIds(Long[] productIds);
    
    /**
     * 批量新增产品分类
     * 
     * @param productClassificationList 产品分类列表
     * @return 结果
     */
    public int batchProductClassification(List<ProductClassification> productClassificationList);
    

    /**
     * 通过产品管理主键删除产品分类信息
     * 
     * @param productId 产品管理ID
     * @return 结果
     */
    public int deleteProductClassificationByClassificationId(Long productId);

    /**
     * 获取指定产品类型、类目、分类的最大SKU序号
     * 
     * @param productType 产品类型
     * @param categoryId 产品类目
     * @param classificationId 产品分类
     * @return 最大序号
     */
    public Integer getMaxSkuSequence(Integer productType, Integer categoryId, Integer classificationId);

    /**
     * 根据SKU编码统计产品数量（排除指定产品ID）
     * 
     * @param productCode SKU编码
     * @param excludeProductId 排除的产品ID
     * @return 产品数量
     */
    public Integer countByProductCode(String productCode, Long excludeProductId);
}
