package com.erp.api.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 产品图片对象 product_images
 * 
 * @author dg
 * @date 2025-11-07
 */
public class ProductImages extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** $column.columnComment */
    private Long imageId;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private Long productId;

    /** 图片路径 */
    @Excel(name = "图片路径")
    private String imagePath;

    /** 图片类型，参考字典表sys_dict_data.dict_value, dict_type=erp_image_type */
    @Excel(name = "图片类型，参考字典表sys_dict_data.dict_value, dict_type=erp_image_type")
    private Long imageType;

    /** 排序顺序 */
    @Excel(name = "排序顺序")
    private Long sortOrder;

    /** 是否主图（0否 1是） */
    @Excel(name = "是否主图", readConverterExp = "0=否,1=是")
    private String isPrimary;

    public void setImageId(Long imageId) 
    {
        this.imageId = imageId;
    }

    public Long getImageId() 
    {
        return imageId;
    }

    public void setProductId(Long productId) 
    {
        this.productId = productId;
    }

    public Long getProductId() 
    {
        return productId;
    }

    public void setImagePath(String imagePath) 
    {
        this.imagePath = imagePath;
    }

    public String getImagePath() 
    {
        return imagePath;
    }

    public void setImageType(Long imageType) 
    {
        this.imageType = imageType;
    }

    public Long getImageType() 
    {
        return imageType;
    }

    public void setSortOrder(Long sortOrder) 
    {
        this.sortOrder = sortOrder;
    }

    public Long getSortOrder() 
    {
        return sortOrder;
    }

    public void setIsPrimary(String isPrimary) 
    {
        this.isPrimary = isPrimary;
    }

    public String getIsPrimary() 
    {
        return isPrimary;
    }

    /** 3D模型路径 */
    @Excel(name = "3D模型路径")
    private String modelPath;

    public void setModelPath(String modelPath) 
    {
        this.modelPath = modelPath;
    }

    public String getModelPath() 
    {
        return modelPath;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("imageId", getImageId())
            .append("productId", getProductId())
            .append("imagePath", getImagePath())
            .append("modelPath", getModelPath())
            .append("imageType", getImageType())
            .append("sortOrder", getSortOrder())
            .append("isPrimary", getIsPrimary())
            .append("createTime", getCreateTime())
            .toString();
    }
}
