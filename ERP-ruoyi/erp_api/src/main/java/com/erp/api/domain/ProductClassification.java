package com.erp.api.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 产品分类对象 product_classification
 * 
 * @author dg
 * @date 2025-11-06
 */
public class ProductClassification extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** $column.columnComment */
    private Long classificationId;

    /** 分类名称：成品/半成品/物料/包装辅料 */
    @Excel(name = "分类名称：成品/半成品/物料/包装辅料")
    private String classificationName;

    /** 子类型：外采-入库-销售/内部生产-入库-销售等 */
    @Excel(name = "子类型：外采-入库-销售/内部生产-入库-销售等")
    private String subtypeName;

    /** 分类描述 */
    @Excel(name = "分类描述")
    private String description;

    /** 排序顺序 */
    @Excel(name = "排序顺序")
    private Long sortOrder;

    /** 状态（0正常 1停用） */
    @Excel(name = "状态", readConverterExp = "0=正常,1=停用")
    private String status;

    public void setClassificationId(Long classificationId) 
    {
        this.classificationId = classificationId;
    }

    public Long getClassificationId() 
    {
        return classificationId;
    }
    public void setClassificationName(String classificationName) 
    {
        this.classificationName = classificationName;
    }

    public String getClassificationName() 
    {
        return classificationName;
    }
    public void setSubtypeName(String subtypeName) 
    {
        this.subtypeName = subtypeName;
    }

    public String getSubtypeName() 
    {
        return subtypeName;
    }
    public void setDescription(String description) 
    {
        this.description = description;
    }

    public String getDescription() 
    {
        return description;
    }
    public void setSortOrder(Long sortOrder) 
    {
        this.sortOrder = sortOrder;
    }

    public Long getSortOrder() 
    {
        return sortOrder;
    }
    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("classificationId", getClassificationId())
            .append("classificationName", getClassificationName())
            .append("subtypeName", getSubtypeName())
            .append("description", getDescription())
            .append("sortOrder", getSortOrder())
            .append("status", getStatus())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
