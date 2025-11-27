package com.erp.api.controller;

import java.util.List;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.erp.api.domain.ProductImages;
import com.erp.api.service.IProductImagesService;
import com.erp.api.service.ModelGenerationService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 产品图片Controller
 * 
 * @author dg
 * @date 2025-11-07
 */
@RestController
@RequestMapping("/product/images")
public class ProductImagesController extends BaseController
{
    @Autowired
    private IProductImagesService productImagesService;

    /**
     * 查询产品图片列表
     */
    @PreAuthorize("@ss.hasPermi('product:images:list')")
    @GetMapping("/list")
    public TableDataInfo list(ProductImages productImages)
    {
        startPage();
        List<ProductImages> list = productImagesService.selectProductImagesList(productImages);
        return getDataTable(list);
    }

    /**
     * 导出产品图片列表
     */
    @PreAuthorize("@ss.hasPermi('product:images:export')")
    @Log(title = "产品图片", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ProductImages productImages)
    {
        List<ProductImages> list = productImagesService.selectProductImagesList(productImages);
        ExcelUtil<ProductImages> util = new ExcelUtil<ProductImages>(ProductImages.class);
        util.exportExcel(response, list, "产品图片数据");
    }

    /**
     * 获取产品图片详细信息
     */
    @PreAuthorize("@ss.hasPermi('product:images:query')")
    @GetMapping(value = "/{imageId}")
    public AjaxResult getInfo(@PathVariable("imageId") Long imageId)
    {
        return success(productImagesService.selectProductImagesByImageId(imageId));
    }

    /**
     * 新增产品图片
     */
    @PreAuthorize("@ss.hasPermi('product:images:add')")
    @Log(title = "产品图片", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ProductImages productImages)
    {
        return toAjax(productImagesService.insertProductImages(productImages));
    }

    /**
     * 修改产品图片
     */
    @PreAuthorize("@ss.hasPermi('product:images:edit')")
    @Log(title = "产品图片", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ProductImages productImages)
    {
        return toAjax(productImagesService.updateProductImages(productImages));
    }

    /**
     * 删除产品图片
     */
    @PreAuthorize("@ss.hasPermi('product:images:remove')")
    @Log(title = "产品图片", businessType = BusinessType.DELETE)
	@DeleteMapping("/{imageIds}")
    public AjaxResult remove(@PathVariable Long[] imageIds)
    {
        return toAjax(productImagesService.deleteProductImagesByImageIds(imageIds));
    }

    @Autowired
    private ModelGenerationService modelGenerationService;

    /**
     * 生成3D模型
     */
    @PostMapping("/generate3DModel")
    public AjaxResult generate3DModel(@RequestParam("file") MultipartFile file)
    {
        try {
            // 1. 调用3D模型生成服务
            String modelPath = modelGenerationService.generate3DModel(file);

            // 2. 返回生成的3D模型路径
            return success(modelPath);
        } catch (Exception e) {
            logger.error("生成3D模型失败", e);
            return error("生成3D模型失败：" + e.getMessage());
        }
    }
}
