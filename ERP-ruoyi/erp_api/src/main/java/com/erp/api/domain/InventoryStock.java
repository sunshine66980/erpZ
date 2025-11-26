package com.erp.api.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 库存管理对象 inventory_stock
 * 
 * @author dg
 * @date 2025-11-10
 */
public class InventoryStock extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 库存ID */
    private Long stockId;

    /** 产品ID */
    @Excel(name = "产品ID")
    private Long productId;

    /** 仓库ID */
    @Excel(name = "仓库ID")
    private Long warehouseId;

    /** 批次号 */
    @Excel(name = "批次号")
    private String batchNo;

    /** 库存数量 */
    @Excel(name = "库存数量")
    private BigDecimal quantity;

    /** 可用数量 */
    @Excel(name = "可用数量")
    private BigDecimal availableQuantity;

    /** 锁定数量 */
    @Excel(name = "锁定数量")
    private BigDecimal lockedQuantity;

    /** 单位成本 */
    @Excel(name = "单位成本")
    private BigDecimal unitCost;

    /** 质量状态 */
    @Excel(name = "质量状态", readConverterExp = "1=合格,2=待检,3=不合格")
    private Long qualityStatus;

    /** 生产日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "生产日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date productionDate;

    /** 过期日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "过期日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date expiryDate;

    /** 入库日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "入库日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date inDate;

    /** 供应商ID */
    @Excel(name = "供应商ID")
    private Long supplierId;

    /** 最后交易时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "最后交易时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date lastTransactionTime;

    public void setStockId(Long stockId) 
    {
        this.stockId = stockId;
    }

    public Long getStockId() 
    {
        return stockId;
    }
    public void setProductId(Long productId) 
    {
        this.productId = productId;
    }

    public Long getProductId() 
    {
        return productId;
    }
    public void setWarehouseId(Long warehouseId) 
    {
        this.warehouseId = warehouseId;
    }

    public Long getWarehouseId() 
    {
        return warehouseId;
    }
    public void setBatchNo(String batchNo) 
    {
        this.batchNo = batchNo;
    }

    public String getBatchNo() 
    {
        return batchNo;
    }
    public void setQuantity(BigDecimal quantity) 
    {
        this.quantity = quantity;
    }

    public BigDecimal getQuantity() 
    {
        return quantity;
    }
    public void setAvailableQuantity(BigDecimal availableQuantity) 
    {
        this.availableQuantity = availableQuantity;
    }

    public BigDecimal getAvailableQuantity() 
    {
        return availableQuantity;
    }
    public void setLockedQuantity(BigDecimal lockedQuantity) 
    {
        this.lockedQuantity = lockedQuantity;
    }

    public BigDecimal getLockedQuantity() 
    {
        return lockedQuantity;
    }
    public void setUnitCost(BigDecimal unitCost) 
    {
        this.unitCost = unitCost;
    }

    public BigDecimal getUnitCost() 
    {
        return unitCost;
    }
    public void setQualityStatus(Long qualityStatus) 
    {
        this.qualityStatus = qualityStatus;
    }

    public Long getQualityStatus() 
    {
        return qualityStatus;
    }
    public void setProductionDate(Date productionDate) 
    {
        this.productionDate = productionDate;
    }

    public Date getProductionDate() 
    {
        return productionDate;
    }
    public void setExpiryDate(Date expiryDate) 
    {
        this.expiryDate = expiryDate;
    }

    public Date getExpiryDate() 
    {
        return expiryDate;
    }
    public void setInDate(Date inDate) 
    {
        this.inDate = inDate;
    }

    public Date getInDate() 
    {
        return inDate;
    }
    public void setSupplierId(Long supplierId) 
    {
        this.supplierId = supplierId;
    }

    public Long getSupplierId() 
    {
        return supplierId;
    }
    public void setLastTransactionTime(Date lastTransactionTime) 
    {
        this.lastTransactionTime = lastTransactionTime;
    }

    public Date getLastTransactionTime() 
    {
        return lastTransactionTime;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("stockId", getStockId())
            .append("productId", getProductId())
            .append("warehouseId", getWarehouseId())
            .append("batchNo", getBatchNo())
            .append("quantity", getQuantity())
            .append("availableQuantity", getAvailableQuantity())
            .append("lockedQuantity", getLockedQuantity())
            .append("unitCost", getUnitCost())
            .append("qualityStatus", getQualityStatus())
            .append("productionDate", getProductionDate())
            .append("expiryDate", getExpiryDate())
            .append("inDate", getInDate())
            .append("supplierId", getSupplierId())
            .append("lastTransactionTime", getLastTransactionTime())
            .append("createTime", getCreateTime())
            .append("createBy", getCreateBy())
            .toString();
    }
}