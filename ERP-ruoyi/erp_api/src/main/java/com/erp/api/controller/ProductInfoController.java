package com.erp.api.controller;

import java.util.List;
import java.util.HashMap;
import java.util.Map;
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
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.erp.api.domain.ProductInfo;
import com.erp.api.service.IProductInfoService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 产品管理Controller
 * 
 * @author dg
 * @date 2025-11-06
 */
@RestController
@RequestMapping("/product/product")
public class ProductInfoController extends BaseController
{
    @Autowired
    private IProductInfoService productInfoService;

    /**
     * 查询产品管理列表
     */
    @PreAuthorize("@ss.hasPermi('product:product:list')")
    @GetMapping("/list")
    public TableDataInfo list(ProductInfo productInfo)
    {
        startPage();
        List<ProductInfo> list = productInfoService.selectProductInfoList(productInfo);
        return getDataTable(list);
    }

    /**
     * 导出产品管理列表
     */
    @PreAuthorize("@ss.hasPermi('product:product:export')")
    @Log(title = "产品管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ProductInfo productInfo)
    {
        List<ProductInfo> list = productInfoService.selectProductInfoList(productInfo);
        ExcelUtil<ProductInfo> util = new ExcelUtil<ProductInfo>(ProductInfo.class);
        util.exportExcel(response, list, "产品管理数据");
    }

    /**
     * 生成产品SKU
     */
    @PreAuthorize("@ss.hasPermi('product:product:add')")
    @Log(title = "产品管理", businessType = BusinessType.INSERT)
    @PostMapping("/generateSku")
    public AjaxResult generateSku(@RequestBody Map<String, Object> params)
    {
        try {
            Integer productType = (Integer) params.get("productType");
            Integer categoryId = (Integer) params.get("categoryId");
            Integer classificationId = (Integer) params.get("classificationId");
            
            if (productType == null || categoryId == null || classificationId == null) {
                return error("产品类型、类目和分类不能为空");
            }
            
            // 获取下一个序号
            int sequence = productInfoService.getNextSkuSequence(productType, categoryId, classificationId);
            
            // 生成SKU
            String sku = generateSkuCode(productType, categoryId, classificationId, sequence);
            
            return success(sku);
        } catch (Exception e) {
            return error("生成SKU失败：" + e.getMessage());
        }
    }

    /**
     * 检查SKU是否重复
     */
    @PreAuthorize("@ss.hasPermi('product:product:list')")
    @GetMapping("/checkSkuDuplicate")
    public AjaxResult checkSkuDuplicate(@RequestParam("productCode") String productCode, 
                                       @RequestParam(value = "productId", required = false) Long productId)
    {
        try {
            boolean isDuplicate = productInfoService.checkSkuDuplicate(productCode, productId);
            return success(isDuplicate);
        } catch (Exception e) {
            return error("检查SKU重复失败：" + e.getMessage());
        }
    }

    /**
     * 获取下一个SKU序号
     */
    @PreAuthorize("@ss.hasPermi('product:product:list')")
    @GetMapping("/getNextSequence")
    public AjaxResult getNextSequence(@RequestParam("productType") Integer productType,
                                     @RequestParam("categoryId") Integer categoryId,
                                     @RequestParam("classificationId") Integer classificationId)
    {
        try {
            int sequence = productInfoService.getNextSkuSequence(productType, categoryId, classificationId);
            return success(sequence);
        } catch (Exception e) {
            return error("获取序号失败：" + e.getMessage());
        }
    }

    /**
     * 获取产品管理详细信息
     */
    @PreAuthorize("@ss.hasPermi('product:product:query')")
    @GetMapping(value = "/{productId}")
    public AjaxResult getInfo(@PathVariable("productId") Long productId)
    {
        return success(productInfoService.selectProductInfoByProductId(productId));
    }

    /**
     * 新增产品管理
     */
    @PreAuthorize("@ss.hasPermi('product:product:add')")
    @Log(title = "产品管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ProductInfo productInfo)
    {
        return toAjax(productInfoService.insertProductInfo(productInfo));
    }

    /**
     * 修改产品管理
     */
    @PreAuthorize("@ss.hasPermi('product:product:edit')")
    @Log(title = "产品管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ProductInfo productInfo)
    {
        return toAjax(productInfoService.updateProductInfo(productInfo));
    }

    /**
     * 删除产品管理
     */
    @PreAuthorize("@ss.hasPermi('product:product:remove')")
    @Log(title = "产品管理", businessType = BusinessType.DELETE)
	@DeleteMapping("/{productIds}")
    public AjaxResult remove(@PathVariable Long[] productIds)
    {
        return toAjax(productInfoService.deleteProductInfoByProductIds(productIds));
    }

    /**
     * 生成SKU编码
     */
    private String generateSkuCode(Integer productType, Integer categoryId, Integer classificationId, Integer sequence)
    {
        // 产品类型映射
        Map<Integer, String> typeMap = new HashMap<>();
        typeMap.put(1, "N");  // 普通
        typeMap.put(2, "C");  // 组合
        typeMap.put(3, "P");  // 生产
        
        // 产品类目映射
        Map<Integer, String> categoryMap = new HashMap<>();
        categoryMap.put(1, "GA");  // 游戏
        categoryMap.put(2, "3C");  // 3C类
        categoryMap.put(3, "BB");  // 母婴
        categoryMap.put(4, "AP");  // 汽配
        categoryMap.put(5, "OS");  // 户外运动
        categoryMap.put(6, "TO");  // 玩具
        categoryMap.put(7, "HO");  // 家居
        
        // 产品分类映射
        Map<Integer, String> classificationMap = new HashMap<>();
        classificationMap.put(1, "FP");   // 成品(外采)
        classificationMap.put(2, "IP");   // 成品(内部生产)
        classificationMap.put(3, "HS");   // 半成品(可单售)
        classificationMap.put(4, "HC");   // 半成品(需组合)
        classificationMap.put(5, "MM");   // 物料(来料生产)
        classificationMap.put(6, "MP");   // 物料(包装物料)
        classificationMap.put(7, "PB");   // 包装辅料(彩盒)
        classificationMap.put(8, "CB");   // 包装辅料(外箱)
        classificationMap.put(9, "TA");   // 包装辅料(胶布)
        classificationMap.put(10, "TL");  // 包装辅料(标签纸)
        classificationMap.put(11, "OA");  // 包装辅料(其他辅料)
        
        String typeCode = typeMap.get(productType);
        String categoryCode = categoryMap.get(categoryId);
        String classificationCode = classificationMap.get(classificationId);
        
        if (typeCode == null || categoryCode == null || classificationCode == null) {
            throw new RuntimeException("无效的产品类型、类目或分类");
        }
        
        String sequenceStr = String.format("%04d", sequence);
        return typeCode + "-" + categoryCode + "-" + classificationCode + "-" + sequenceStr;
    }
}
