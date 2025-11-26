package com.erp.api.domain;

import java.math.BigDecimal;
import java.util.List;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 产品管理对象 product_info
 * 
 * @author dg
 * @date 2025-11-06
 */
public class ProductInfo extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** $column.columnComment */
    private Long productId;

    /** 产品SKU */
    @Excel(name = "产品SKU")
    private String productCode;

    /** 产品名称 */
    @Excel(name = "产品名称")
    private String productName;

    /** 产品类型，参考字典表sys_dict_data.dict_value, dict_type=erp_product_type */
    @Excel(name = "产品类型，参考字典表sys_dict_data.dict_value, dict_type=erp_product_type")
    private Long productType;

    /** 产品类型名称 */
    private String productTypeName;

    /** 产品类目ID */
    @Excel(name = "产品类目ID")
    private Long categoryId;

    /** 产品分类ID */
    @Excel(name = "产品分类ID")
    private Long classificationId;

    /** 产品类目名称 */
    private String categoryName;

    /** 产品分类名称 */
    private String classificationName;

    /** 产品型号 */
    @Excel(name = "产品型号")
    private String model;

    /** 单位，参考字典表sys_dict_data.dict_value, dict_type=erp_product_unit */
    @Excel(name = "单位，参考字典表sys_dict_data.dict_value, dict_type=erp_product_unit")
    private Long unit;

    /** 采购价格 */
    @Excel(name = "采购价格")
    private BigDecimal purchasePrice;

    /** 采购交期（天） */
    @Excel(name = "采购交期", readConverterExp = "天=")
    private Long leadTime;

    /** 重量(g/kg) */
    @Excel(name = "重量(g/kg)")
    private BigDecimal weight;

    /** 体积(cm³) */
    @Excel(name = "体积(cm³)")
    private BigDecimal volume;

    /** 长度(cm) */
    @Excel(name = "长度(cm)")
    private BigDecimal length;

    /** 宽度(cm) */
    @Excel(name = "宽度(cm)")
    private BigDecimal width;

    /** 高度(cm) */
    @Excel(name = "高度(cm)")
    private BigDecimal height;

    /** 标准箱数量 */
    @Excel(name = "标准箱数量")
    private Long standardBoxQty;

    /** 30天销量 */
    @Excel(name = "30天销量")
    private Long sales30days;

    /** 当前库存 */
    @Excel(name = "当前库存")
    private Long stock;

    /** 产品说明 */
    @Excel(name = "产品说明")
    private String description;

    /** 采购备注 */
    @Excel(name = "采购备注")
    private String purchaseRemark;

    /** 1688采购链接 */
    @Excel(name = "1688采购链接")
    private String platform1688Url;

    /** 质检类型，参考字典表sys_dict_data.dict_value, dict_type=erp_quality_type */
    @Excel(name = "质检类型，参考字典表sys_dict_data.dict_value, dict_type=erp_quality_type")
    private Long qualityType;

    /** 销售渠道：多个渠道ID用逗号分隔，参考字典表sys_dict_data.dict_value, dict_type=erp_sales_channel */
    @Excel(name = "销售渠道：多个渠道ID用逗号分隔，参考字典表sys_dict_data.dict_value, dict_type=erp_sales_channel")
    private String salesChannels;

    /** 是否启用（0禁用 1启用） */
    @Excel(name = "是否启用", readConverterExp = "0=禁用,1=启用")
    private String isActive;

    /** 主图信息 */
    private ProductImages primaryImage;

    /** 产品图片列表 */
    private List<ProductImages> productImagesList;

    /** 产品分类信息 */
    private List<ProductClassification> productClassificationList;

    public void setProductId(Long productId) 
    {
        this.productId = productId;
    }

    public Long getProductId() 
    {
        return productId;
    }

    public void setProductCode(String productCode) 
    {
        this.productCode = productCode;
    }

    public String getProductCode() 
    {
        return productCode;
    }

    public void setProductName(String productName) 
    {
        this.productName = productName;
    }

    public String getProductName() 
    {
        return productName;
    }

    public void setProductType(Long productType) 
    {
        this.productType = productType;
    }

    public Long getProductType() 
    {
        return productType;
    }

    public void setProductTypeName(String productTypeName) 
    {
        this.productTypeName = productTypeName;
    }

    public String getProductTypeName() 
    {
        return productTypeName;
    }

    public void setCategoryId(Long categoryId) 
    {
        this.categoryId = categoryId;
    }

    public Long getCategoryId() 
    {
        return categoryId;
    }

    public void setClassificationId(Long classificationId) 
    {
        this.classificationId = classificationId;
    }

    public Long getClassificationId() 
    {
        return classificationId;
    }

    public void setCategoryName(String categoryName) 
    {
        this.categoryName = categoryName;
    }

    public String getCategoryName() 
    {
        return categoryName;
    }

    public void setClassificationName(String classificationName) 
    {
        this.classificationName = classificationName;
    }

    public String getClassificationName() 
    {
        return classificationName;
    }

    public void setModel(String model) 
    {
        this.model = model;
    }

    public String getModel() 
    {
        return model;
    }

    public void setUnit(Long unit) 
    {
        this.unit = unit;
    }

    public Long getUnit() 
    {
        return unit;
    }

    public void setPurchasePrice(BigDecimal purchasePrice) 
    {
        this.purchasePrice = purchasePrice;
    }

    public BigDecimal getPurchasePrice() 
    {
        return purchasePrice;
    }

    public void setLeadTime(Long leadTime) 
    {
        this.leadTime = leadTime;
    }

    public Long getLeadTime() 
    {
        return leadTime;
    }

    public void setWeight(BigDecimal weight) 
    {
        this.weight = weight;
    }

    public BigDecimal getWeight() 
    {
        return weight;
    }

    public void setVolume(BigDecimal volume) 
    {
        this.volume = volume;
    }

    public BigDecimal getVolume() 
    {
        return volume;
    }

    public void setLength(BigDecimal length) 
    {
        this.length = length;
    }

    public BigDecimal getLength() 
    {
        return length;
    }

    public void setWidth(BigDecimal width) 
    {
        this.width = width;
    }

    public BigDecimal getWidth() 
    {
        return width;
    }

    public void setHeight(BigDecimal height) 
    {
        this.height = height;
    }

    public BigDecimal getHeight() 
    {
        return height;
    }

    public void setStandardBoxQty(Long standardBoxQty) 
    {
        this.standardBoxQty = standardBoxQty;
    }

    public Long getStandardBoxQty() 
    {
        return standardBoxQty;
    }

    public void setSales30days(Long sales30days) 
    {
        this.sales30days = sales30days;
    }

    public Long getSales30days() 
    {
        return sales30days;
    }

    public void setStock(Long stock) 
    {
        this.stock = stock;
    }

    public Long getStock() 
    {
        return stock;
    }

    public void setDescription(String description) 
    {
        this.description = description;
    }

    public String getDescription() 
    {
        return description;
    }

    public void setPurchaseRemark(String purchaseRemark) 
    {
        this.purchaseRemark = purchaseRemark;
    }

    public String getPurchaseRemark() 
    {
        return purchaseRemark;
    }

    public void setPlatform1688Url(String platform1688Url) 
    {
        this.platform1688Url = platform1688Url;
    }

    public String getPlatform1688Url() 
    {
        return platform1688Url;
    }

    public void setQualityType(Long qualityType) 
    {
        this.qualityType = qualityType;
    }

    public Long getQualityType() 
    {
        return qualityType;
    }

    public void setSalesChannels(String salesChannels) 
    {
        this.salesChannels = salesChannels;
    }

    public String getSalesChannels() 
    {
        return salesChannels;
    }

    public void setIsActive(String isActive) 
    {
        this.isActive = isActive;
    }

    public String getIsActive() 
    {
        return isActive;
    }

    public void setPrimaryImage(ProductImages primaryImage) 
    {
        this.primaryImage = primaryImage;
    }

    public ProductImages getPrimaryImage() 
    {
        return primaryImage;
    }

    public void setProductImagesList(List<ProductImages> productImagesList) 
    {
        this.productImagesList = productImagesList;
    }

    public List<ProductImages> getProductImagesList() 
    {
        return productImagesList;
    }

    public List<ProductClassification> getProductClassificationList()
    {
        return productClassificationList;
    }

    public void setProductClassificationList(List<ProductClassification> productClassificationList)
    {
        this.productClassificationList = productClassificationList;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("productId", getProductId())
            .append("productCode", getProductCode())
            .append("productName", getProductName())
            .append("productType", getProductType())
            .append("categoryId", getCategoryId())
            .append("classificationId", getClassificationId())
            .append("model", getModel())
            .append("unit", getUnit())
            .append("purchasePrice", getPurchasePrice())
            .append("leadTime", getLeadTime())
            .append("weight", getWeight())
            .append("volume", getVolume())
            .append("length", getLength())
            .append("width", getWidth())
            .append("height", getHeight())
            .append("standardBoxQty", getStandardBoxQty())
            .append("sales30days", getSales30days())
            .append("stock", getStock())
            .append("description", getDescription())
            .append("purchaseRemark", getPurchaseRemark())
            .append("platform1688Url", getPlatform1688Url())
            .append("qualityType", getQualityType())
            .append("salesChannels", getSalesChannels())
            .append("isActive", getIsActive())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .append("productImagesList", getProductImagesList())
            .append("productClassificationList", getProductClassificationList())
            .toString();
    }
}
