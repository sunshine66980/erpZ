package com.erp.api.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@Service
public class ModelGenerationServiceImpl implements ModelGenerationService {

    /**
     * 生成3D模型
     * @param imageFile 上传的图片文件
     * @return 生成的3D模型路径
     * @throws IOException
     * @throws InterruptedException
     */
    @Override
    public String generate3DModel(MultipartFile imageFile) throws IOException, InterruptedException {
        // 1. 保存上传的图片到临时目录
        String tempDir = System.getProperty("java.io.tmpdir");
        String imageName = UUID.randomUUID().toString() + ".jpg";
        Path imagePath = Paths.get(tempDir, imageName);
        
        try (InputStream inputStream = imageFile.getInputStream()) {
            Files.copy(inputStream, imagePath, StandardCopyOption.REPLACE_EXISTING);
        }

        // 2. 调用Python脚本生成3D模型
        String modelName = UUID.randomUUID().toString() + ".glb";
        Path modelPath = Paths.get(tempDir, modelName);
        
        // 获取Python脚本的绝对路径
        String scriptPath = getClass().getClassLoader().getResource("generate_3d_model.py").getPath();
        
        // 构建Python命令
        String command = String.format("python3 %s %s %s", scriptPath, imagePath, modelPath);
        
        // 执行命令
        Process process = Runtime.getRuntime().exec(command);
        int exitCode = process.waitFor();
        
        if (exitCode != 0) {
            throw new RuntimeException("3D模型生成失败，退出码：" + exitCode);
        }

        // 3. 将生成的模型复制到上传目录
        String uploadDir = System.getProperty("user.dir") + "/upload/models";
        File uploadFolder = new File(uploadDir);
        if (!uploadFolder.exists()) {
            uploadFolder.mkdirs();
        }
        
        Path targetPath = Paths.get(uploadDir, modelName);
        Files.copy(modelPath, targetPath, StandardCopyOption.REPLACE_EXISTING);

        // 4. 清理临时文件
        Files.deleteIfExists(imagePath);
        Files.deleteIfExists(modelPath);

        // 5. 返回模型路径
        return "/upload/models/" + modelName;
    }
}