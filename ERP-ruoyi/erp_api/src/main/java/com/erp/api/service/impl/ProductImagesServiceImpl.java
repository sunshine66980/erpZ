package com.erp.api.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.erp.api.mapper.ProductImagesMapper;
import com.erp.api.domain.ProductImages;
import com.erp.api.service.IProductImagesService;

/**
 * 产品图片Service业务层处理
 * 
 * @author dg
 * @date 2025-11-07
 */
@Service
public class ProductImagesServiceImpl implements IProductImagesService 
{
    @Autowired
    private ProductImagesMapper productImagesMapper;

    /**
     * 查询产品图片
     * 
     * @param imageId 产品图片主键
     * @return 产品图片
     */
    @Override
    public ProductImages selectProductImagesByImageId(Long imageId)
    {
        return productImagesMapper.selectProductImagesByImageId(imageId);
    }

    /**
     * 查询产品图片列表
     * 
     * @param productImages 产品图片
     * @return 产品图片
     */
    @Override
    public List<ProductImages> selectProductImagesList(ProductImages productImages)
    {
        return productImagesMapper.selectProductImagesList(productImages);
    }

    /**
     * 新增产品图片
     * 
     * @param productImages 产品图片
     * @return 结果
     */
    @Override
    public int insertProductImages(ProductImages productImages)
    {
        productImages.setCreateTime(DateUtils.getNowDate());
        return productImagesMapper.insertProductImages(productImages);
    }

    /**
     * 修改产品图片
     * 
     * @param productImages 产品图片
     * @return 结果
     */
    @Override
    public int updateProductImages(ProductImages productImages)
    {
        return productImagesMapper.updateProductImages(productImages);
    }

    /**
     * 批量删除产品图片
     * 
     * @param imageIds 需要删除的产品图片主键
     * @return 结果
     */
    @Override
    public int deleteProductImagesByImageIds(Long[] imageIds)
    {
        return productImagesMapper.deleteProductImagesByImageIds(imageIds);
    }

    /**
     * 删除产品图片信息
     * 
     * @param imageId 产品图片主键
     * @return 结果
     */
    @Override
    public int deleteProductImagesByImageId(Long imageId)
    {
        return productImagesMapper.deleteProductImagesByImageId(imageId);
    }

    /**
     * 根据产品ID删除产品图片
     * 
     * @param productId 产品ID
     * @return 结果
     */
    @Override
    public int deleteProductImagesByProductId(Long productId)
    {
        return productImagesMapper.deleteProductImagesByProductId(productId);
    }

    /**
     * 批量新增产品图片
     * 
     * @param productImagesList 产品图片列表
     * @return 结果
     */
    @Override
    public int batchInsertProductImages(List<ProductImages> productImagesList)
    {
        if (productImagesList == null || productImagesList.isEmpty()) {
            return 0;
        }
        
        for (ProductImages image : productImagesList) {
            image.setCreateTime(DateUtils.getNowDate());
        }
        
        return productImagesMapper.batchInsertProductImages(productImagesList);
    }
}
