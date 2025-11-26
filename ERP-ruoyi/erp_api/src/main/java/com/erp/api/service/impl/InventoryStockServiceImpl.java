package com.erp.api.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.erp.api.mapper.InventoryStockMapper;
import com.erp.api.domain.InventoryStock;
import com.erp.api.service.IInventoryStockService;

/**
 * 库存管理Service业务层处理
 * 
 * @author dg
 * @date 2025-11-10
 */
@Service
public class InventoryStockServiceImpl implements IInventoryStockService 
{
    @Autowired
    private InventoryStockMapper inventoryStockMapper;

    /**
     * 查询库存管理
     * 
     * @param stockId 库存管理主键
     * @return 库存管理
     */
    @Override
    public InventoryStock selectInventoryStockByStockId(Long stockId)
    {
        return inventoryStockMapper.selectInventoryStockByStockId(stockId);
    }

    /**
     * 查询库存管理列表
     * 
     * @param inventoryStock 库存管理
     * @return 库存管理
     */
    @Override
    public List<InventoryStock> selectInventoryStockList(InventoryStock inventoryStock)
    {
        return inventoryStockMapper.selectInventoryStockList(inventoryStock);
    }

    /**
     * 新增库存管理
     * 
     * @param inventoryStock 库存管理
     * @return 结果
     */
    @Override
    public int insertInventoryStock(InventoryStock inventoryStock)
    {
        inventoryStock.setCreateTime(DateUtils.getNowDate());
        return inventoryStockMapper.insertInventoryStock(inventoryStock);
    }

    /**
     * 修改库存管理
     * 
     * @param inventoryStock 库存管理
     * @return 结果
     */
    @Override
    public int updateInventoryStock(InventoryStock inventoryStock)
    {
        inventoryStock.setUpdateTime(DateUtils.getNowDate());
        return inventoryStockMapper.updateInventoryStock(inventoryStock);
    }

    /**
     * 批量删除库存管理
     * 
     * @param stockIds 需要删除的库存管理主键
     * @return 结果
     */
    @Override
    public int deleteInventoryStockByStockIds(Long[] stockIds)
    {
        return inventoryStockMapper.deleteInventoryStockByStockIds(stockIds);
    }

    /**
     * 删除库存管理信息
     * 
     * @param stockId 库存管理主键
     * @return 结果
     */
    @Override
    public int deleteInventoryStockByStockId(Long stockId)
    {
        return inventoryStockMapper.deleteInventoryStockByStockId(stockId);
    }

    /**
     * 根据产品ID查询库存
     * 
     * @param productId 产品ID
     * @return 库存管理
     */
    @Override
    public InventoryStock selectInventoryStockByProductId(Long productId)
    {
        return inventoryStockMapper.selectInventoryStockByProductId(productId);
    }

    /**
     * 更新产品库存
     * 
     * @param productId 产品ID
     * @param quantity 库存数量
     * @return 结果
     */
    @Override
    public int updateProductStock(Long productId, Long quantity)
    {
        return inventoryStockMapper.updateProductStock(productId, quantity);
    }
}