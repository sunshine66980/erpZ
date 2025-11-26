package com.erp.api.service;

import java.util.List;
import com.erp.api.domain.ProductImages;

/**
 * 产品图片Service接口
 * 
 * @author dg
 * @date 2025-11-07
 */
public interface IProductImagesService 
{
    /**
     * 查询产品图片
     * 
     * @param imageId 产品图片主键
     * @return 产品图片
     */
    public ProductImages selectProductImagesByImageId(Long imageId);

    /**
     * 查询产品图片列表
     * 
     * @param productImages 产品图片
     * @return 产品图片集合
     */
    public List<ProductImages> selectProductImagesList(ProductImages productImages);

    /**
     * 新增产品图片
     * 
     * @param productImages 产品图片
     * @return 结果
     */
    public int insertProductImages(ProductImages productImages);

    /**
     * 修改产品图片
     * 
     * @param productImages 产品图片
     * @return 结果
     */
    public int updateProductImages(ProductImages productImages);

    /**
     * 批量删除产品图片
     * 
     * @param imageIds 需要删除的产品图片主键集合
     * @return 结果
     */
    public int deleteProductImagesByImageIds(Long[] imageIds);

    /**
     * 删除产品图片信息
     * 
     * @param imageId 产品图片主键
     * @return 结果
     */
    public int deleteProductImagesByImageId(Long imageId);

    /**
     * 根据产品ID删除产品图片
     * 
     * @param productId 产品ID
     * @return 结果
     */
    public int deleteProductImagesByProductId(Long productId);

    /**
     * 批量新增产品图片
     * 
     * @param productImagesList 产品图片列表
     * @return 结果
     */
    public int batchInsertProductImages(List<ProductImages> productImagesList);
}
