package com.erp.api.service;

import java.util.List;
import com.erp.api.domain.InventoryStock;

/**
 * 库存管理Service接口
 * 
 * @author dg
 * @date 2025-11-10
 */
public interface IInventoryStockService 
{
    /**
     * 查询库存管理
     * 
     * @param stockId 库存管理主键
     * @return 库存管理
     */
    public InventoryStock selectInventoryStockByStockId(Long stockId);

    /**
     * 查询库存管理列表
     * 
     * @param inventoryStock 库存管理
     * @return 库存管理集合
     */
    public List<InventoryStock> selectInventoryStockList(InventoryStock inventoryStock);

    /**
     * 新增库存管理
     * 
     * @param inventoryStock 库存管理
     * @return 结果
     */
    public int insertInventoryStock(InventoryStock inventoryStock);

    /**
     * 修改库存管理
     * 
     * @param inventoryStock 库存管理
     * @return 结果
     */
    public int updateInventoryStock(InventoryStock inventoryStock);

    /**
     * 批量删除库存管理
     * 
     * @param stockIds 需要删除的库存管理主键集合
     * @return 结果
     */
    public int deleteInventoryStockByStockIds(Long[] stockIds);

    /**
     * 删除库存管理信息
     * 
     * @param stockId 库存管理主键
     * @return 结果
     */
    public int deleteInventoryStockByStockId(Long stockId);

    /**
     * 根据产品ID查询库存
     * 
     * @param productId 产品ID
     * @return 库存管理
     */
    public InventoryStock selectInventoryStockByProductId(Long productId);

    /**
     * 更新产品库存
     * 
     * @param productId 产品ID
     * @param quantity 库存数量
     * @return 结果
     */
    public int updateProductStock(Long productId, Long quantity);
}