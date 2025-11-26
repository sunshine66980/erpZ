package com.erp.api.service.impl;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.stream.Collectors;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import com.ruoyi.common.utils.StringUtils;
import org.springframework.transaction.annotation.Transactional;
import com.erp.api.domain.ProductClassification;
import com.erp.api.domain.ProductImages;
import com.erp.api.domain.InventoryStock;
import com.erp.api.mapper.ProductInfoMapper;
import com.erp.api.domain.ProductInfo;
import com.erp.api.service.IProductInfoService;
import com.erp.api.service.IProductImagesService;
import com.erp.api.service.IInventoryStockService;

/**
 * 产品管理Service业务层处理
 * 
 * @author dg
 * @date 2025-11-06
 */
@Service
public class ProductInfoServiceImpl implements IProductInfoService 
{
    @Autowired
    private ProductInfoMapper productInfoMapper;
    
    @Autowired
    private IProductImagesService productImagesService;
    
    @Autowired
    private IInventoryStockService inventoryStockService;

    /**
     * 查询产品管理
     * 
     * @param productId 产品管理主键
     * @return 产品管理
     */
    @Override
    public ProductInfo selectProductInfoByProductId(Long productId)
    {
        ProductInfo productInfo = productInfoMapper.selectProductInfoWithImages(productId);
        if (productInfo == null) {
            return null;
        }
        
        // 如果上面的方法没有图片数据，使用单独的图片查询
        if (productInfo.getProductImagesList() == null || productInfo.getProductImagesList().isEmpty()) {
            ProductImages queryParam = new ProductImages();
            queryParam.setProductId(productId);
            List<ProductImages> images = productImagesService.selectProductImagesList(queryParam);
            productInfo.setProductImagesList(images);
        }
        
        return productInfo;
    }

    /**
     * 查询产品管理列表
     * 
     * @param productInfo 产品管理
     * @return 产品管理
     */
    @Override
    public List<ProductInfo> selectProductInfoList(ProductInfo productInfo)
    {
        List<ProductInfo> productList = productInfoMapper.selectProductInfoListWithPrimaryImage(productInfo);
        
        // 为每个产品加载主图信息和类目/分类名称
        for (ProductInfo product : productList) {
            if (product.getProductId() != null) {
                ProductImages queryParam = new ProductImages();
                queryParam.setProductId(product.getProductId());
                queryParam.setIsPrimary("1");
                List<ProductImages> primaryImages = productImagesService.selectProductImagesList(queryParam);
                
                if (primaryImages != null && !primaryImages.isEmpty()) {
                    product.setPrimaryImage(primaryImages.get(0));
                }
            }
            
            // 设置类目名称
            product.setCategoryName(getCategoryNameById(product.getCategoryId()));
            
            // 设置分类名称
            product.setClassificationName(getClassificationShortNameById(product.getClassificationId()));
            
            // 设置产品类型名称
            if (product.getProductType() != null) {
                product.setProductTypeName(getProductTypeNameById(product.getProductType()));
            }
        }
        
        return productList;
    }

    /**
     * 新增产品管理
     * 
     * @param productInfo 产品管理
     * @return 结果
     */
    @Transactional
    @Override
    public int insertProductInfo(ProductInfo productInfo)
    {
        productInfo.setCreateTime(DateUtils.getNowDate());
        int rows = productInfoMapper.insertProductInfo(productInfo);
        insertProductClassification(productInfo);
        return rows;
    }

    /**
     * 修改产品管理
     * 
     * @param productInfo 产品管理
     * @return 结果
     */
    @Transactional
    @Override
    public int updateProductInfo(ProductInfo productInfo)
    {
        productInfo.setUpdateTime(DateUtils.getNowDate());
        
        // 处理产品图片更新 - 只有当productImagesList明确不为null时才处理
        if (productInfo.getProductImagesList() != null) {
            System.out.println("处理图片更新，productImagesList大小: " + productInfo.getProductImagesList().size());
            
            // 先删除原有图片
            productImagesService.deleteProductImagesByProductId(productInfo.getProductId());
            
            // 批量插入新图片
            if (!productInfo.getProductImagesList().isEmpty()) {
                System.out.println("插入新图片，数量: " + productInfo.getProductImagesList().size());
                
                // 过滤掉没有图片路径的记录
                List<ProductImages> validImages = productInfo.getProductImagesList().stream()
                    .filter(image -> image.getImagePath() != null && !image.getImagePath().trim().isEmpty())
                    .collect(Collectors.toList());
                
                if (!validImages.isEmpty()) {
                    // 设置产品ID
                    for (ProductImages image : validImages) {
                        image.setProductId(productInfo.getProductId());
                    }
                    productImagesService.batchInsertProductImages(validImages);
                }
            } else {
                System.out.println("productImagesList为空数组，清空所有图片");
            }
            // 如果是空数组，表示用户主动清空了所有图片，此时不插入新图片
        } else {
            System.out.println("productImagesList为null，保持原有图片不变");
        }
        // 如果productImagesList为null，表示没有图片相关的更新，保持原有图片不变
        
        // 处理库存更新
        if (productInfo.getStock() != null) {
            System.out.println("更新产品库存，新库存: " + productInfo.getStock());
            inventoryStockService.updateProductStock(productInfo.getProductId(), productInfo.getStock());
        }
        
        return productInfoMapper.updateProductInfo(productInfo);
    }

    /**
     * 批量删除产品管理
     * 
     * @param productIds 需要删除的产品管理主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteProductInfoByProductIds(Long[] productIds)
    {
        // 删除产品图片
        for (Long productId : productIds) {
            productImagesService.deleteProductImagesByProductId(productId);
        }
        
        return productInfoMapper.deleteProductInfoByProductIds(productIds);
    }

    /**
     * 删除产品管理信息
     * 
     * @param productId 产品管理主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteProductInfoByProductId(Long productId)
    {
        // 删除产品图片
        productImagesService.deleteProductImagesByProductId(productId);
        
        return productInfoMapper.deleteProductInfoByProductId(productId);
    }

    /**
     * 新增产品分类信息
     * 
     * @param productInfo 产品管理对象
     */
    public void insertProductClassification(ProductInfo productInfo)
    {
        List<ProductClassification> productClassificationList = productInfo.getProductClassificationList();
        Long productId = productInfo.getProductId();
        if (StringUtils.isNotNull(productClassificationList))
        {
            List<ProductClassification> list = new ArrayList<ProductClassification>();
            for (ProductClassification productClassification : productClassificationList)
            {
                productClassification.setClassificationId(productId);
                list.add(productClassification);
            }
            if (list.size() > 0)
            {
                productInfoMapper.batchProductClassification(list);
            }
        }
    }

    /**
     * 获取下一个SKU序号
     * 
     * @param productType 产品类型
     * @param categoryId 产品类目
     * @param classificationId 产品分类
     * @return 下一个序号
     */
    @Override
    public int getNextSkuSequence(Integer productType, Integer categoryId, Integer classificationId)
    {
        // 查询当前最大的序号
        Integer maxSequence = productInfoMapper.getMaxSkuSequence(productType, categoryId, classificationId);
        if (maxSequence == null || maxSequence <= 0) {
            return 1; // 如果没有找到记录，从1开始
        }
        return maxSequence + 1;
    }

    /**
     * 检查SKU是否重复
     * 
     * @param productCode SKU编码
     * @param excludeProductId 排除的产品ID（用于编辑时排除自己）
     * @return 是否重复
     */
    @Override
    public boolean checkSkuDuplicate(String productCode, Long excludeProductId)
    {
        Integer count = productInfoMapper.countByProductCode(productCode, excludeProductId);
        return count != null && count > 0;
    }

    /**
     * 根据类目ID获取类目名称
     */
    private String getCategoryNameById(Long categoryId) {
        if (categoryId == null) return null;
        
        Map<Long, String> categoryMap = new HashMap<>();
        categoryMap.put(1L, "游戏");
        categoryMap.put(2L, "3C类");
        categoryMap.put(3L, "母婴");
        categoryMap.put(4L, "汽配");
        categoryMap.put(5L, "户外运动");
        categoryMap.put(6L, "玩具");
        categoryMap.put(7L, "家居");
        
        return categoryMap.get(categoryId);
    }

    /**
     * 根据分类ID获取分类详细名称
     */
    private String getClassificationNameById(Long classificationId) {
        if (classificationId == null) return null;
        
        Map<Long, String> classificationMap = new HashMap<>();
        classificationMap.put(1L, "成品(外采)");
        classificationMap.put(2L, "成品(内部生产)");
        classificationMap.put(3L, "半成品(可单售)");
        classificationMap.put(4L, "半成品(需组合)");
        classificationMap.put(5L, "物料(来料生产)");
        classificationMap.put(6L, "物料(包装物料)");
        classificationMap.put(7L, "包装辅料(彩盒)");
        classificationMap.put(8L, "包装辅料(外箱)");
        classificationMap.put(9L, "包装辅料(胶布)");
        classificationMap.put(10L, "包装辅料(标签纸)");
        classificationMap.put(11L, "包装辅料(其他辅料)");
        
        return classificationMap.get(classificationId);
    }

    /**
     * 根据分类ID获取分类简称（用于列表显示）
     */
    private String getClassificationShortNameById(Long classificationId) {
        if (classificationId == null) return null;
        
        Map<Long, String> classificationMap = new HashMap<>();
        classificationMap.put(1L, "成品");
        classificationMap.put(2L, "成品");
        classificationMap.put(3L, "半成品");
        classificationMap.put(4L, "半成品");
        classificationMap.put(5L, "物料");
        classificationMap.put(6L, "物料");
        classificationMap.put(7L, "包装辅料");
        classificationMap.put(8L, "包装辅料");
        classificationMap.put(9L, "包装辅料");
        classificationMap.put(10L, "包装辅料");
        classificationMap.put(11L, "包装辅料");
        
        return classificationMap.get(classificationId);
    }

    /**
     * 根据产品类型ID获取产品类型名称
     */
    private String getProductTypeNameById(Long productTypeId) {
        if (productTypeId == null) return null;
        
        Map<Long, String> productTypeMap = new HashMap<>();
        productTypeMap.put(1L, "普品");
        productTypeMap.put(2L, "组合");
        productTypeMap.put(3L, "生产");
        
        return productTypeMap.get(productTypeId);
    }
}
