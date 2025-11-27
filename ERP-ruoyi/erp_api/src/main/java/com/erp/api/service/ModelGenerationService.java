package com.erp.api.service;

import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public interface ModelGenerationService {

    /**
     * 生成3D模型
     * @param imageFile 上传的图片文件
     * @return 生成的3D模型路径
     * @throws IOException
     * @throws InterruptedException
     */
    String generate3DModel(MultipartFile imageFile) throws IOException, InterruptedException;
}