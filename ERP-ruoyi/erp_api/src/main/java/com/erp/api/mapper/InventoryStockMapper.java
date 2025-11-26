package com.erp.api.mapper;

import java.util.List;
import com.erp.api.domain.InventoryStock;

/**
 * 库存管理Mapper接口
 * 
 * @author dg
 * @date 2025-11-10
 */
public interface InventoryStockMapper 
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
     * 删除库存管理
     * 
     * @param stockId 库存管理主键
     * @return 结果
     */
    public int deleteInventoryStockByStockId(Long stockId);

    /**
     * 批量删除库存管理
     * 
     * @param stockIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteInventoryStockByStockIds(Long[] stockIds);

    /**
     * 根据产品ID查询库存
     * 
     * @param productId 产品ID
     * @return 库存管理
     */
    public InventoryStock selectInventoryStockByProductId(Long productId);

    /**
     * 根据产品ID和仓库ID查询库存
     * 
     * @param productId 产品ID
     * @param warehouseId 仓库ID
     * @return 库存管理
     */
    public InventoryStock selectInventoryStockByProductIdAndWarehouseId(Long productId, Long warehouseId);

    /**
     * 更新产品库存
     * 
     * @param productId 产品ID
     * @param quantity 库存数量
     * @return 结果
     */
    public int updateProductStock(Long productId, Long quantity);
}