import sys
import cv2
import numpy as np
import bpy
import os


def main(image_path, output_path):
    # 1. 读取图片并进行预处理
    image = cv2.imread(image_path)
    if image is None:
        print(f"无法读取图片: {image_path}")
        sys.exit(1)
    
    # 转换为灰度图
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    
    # 2. 图像预处理
    # 高斯模糊
    blurred = cv2.GaussianBlur(gray, (5, 5), 0)
    
    # 阈值处理
    _, thresh = cv2.threshold(blurred, 127, 255, cv2.THRESH_BINARY_INV + cv2.THRESH_OTSU)
    
    # 形态学操作
    kernel = np.ones((5, 5), np.uint8)
    thresh = cv2.morphologyEx(thresh, cv2.MORPH_CLOSE, kernel)
    thresh = cv2.morphologyEx(thresh, cv2.MORPH_OPEN, kernel)
    
    # 3. 提取图像轮廓
    contours, _ = cv2.findContours(thresh, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    
    if not contours:
        print("未找到轮廓")
        sys.exit(1)
    
    # 4. 找到最大的轮廓
    max_contour = max(contours, key=cv2.contourArea)
    
    # 5. 简化轮廓
    epsilon = 0.01 * cv2.arcLength(max_contour, True)
    approx_contour = cv2.approxPolyDP(max_contour, epsilon, True)
    
    # 6. 将轮廓转换为Blender可识别的格式
    vertices = []
    for point in approx_contour:
        x, y = point[0]
        # 调整坐标，使模型居中
        x = x - image.shape[1] / 2
        y = image.shape[0] / 2 - y
        # 缩放坐标，使模型大小合适
        x = x * 0.01
        y = y * 0.01
        vertices.append((x, y, 0))
    
    # 7. 使用Blender创建3D模型
    create_3d_model(vertices, output_path)


def create_3d_model(vertices, output_path):
    # 清除Blender场景中的所有物体
    bpy.ops.object.select_all(action='SELECT')
    bpy.ops.object.delete()
    
    # 创建一个新的网格
    mesh = bpy.data.meshes.new(name="3DModel")
    
    # 创建顶点和面
    edges = []
    faces = []
    
    # 创建轮廓的面
    if len(vertices) > 2:
        faces.append(list(range(len(vertices))))
    
    # 从顶点、边和面创建网格
    mesh.from_pydata(vertices, edges, faces)
    mesh.update()
    
    # 创建一个新的物体并将其链接到场景
    obj = bpy.data.objects.new("3DModel", mesh)
    bpy.context.scene.collection.objects.link(obj)
    
    # 选中并激活物体
    bpy.context.view_layer.objects.active = obj
    obj.select_set(True)
    
    # 应用实体化修改器来创建厚度
    solidify_modifier = obj.modifiers.new(name="Solidify", type='SOLIDIFY')
    solidify_modifier.thickness = 0.1
    solidify_modifier.offset = 0
    
    # 应用平滑修改器
    smooth_modifier = obj.modifiers.new(name="Smooth", type='SMOOTH')
    smooth_modifier.iterations = 3
    smooth_modifier.factor = 1.0
    
    # 添加材质
    material = bpy.data.materials.new(name="ModelMaterial")
    material.use_nodes = True
    
    # 获取材质节点树
    nodes = material.node_tree.nodes
    links = material.node_tree.links
    
    # 清除默认节点
    for node in nodes:
        nodes.remove(node)
    
    # 创建Principled BSDF节点
    principled_bsdf = nodes.new(type='ShaderNodeBsdfPrincipled')
    principled_bsdf.location = (0, 0)
    principled_bsdf.inputs['Base Color'].default_value = (0.8, 0.8, 0.8, 1.0)
    principled_bsdf.inputs['Roughness'].default_value = 0.3
    principled_bsdf.inputs['Metallic'].default_value = 0.7
    
    # 创建输出节点
    output_node = nodes.new(type='ShaderNodeOutputMaterial')
    output_node.location = (400, 0)
    
    # 连接节点
    links.new(principled_bsdf.outputs['BSDF'], output_node.inputs['Surface'])
    
    # 将材质应用到物体
    obj.data.materials.append(material)
    
    # 设置场景
    bpy.context.scene.render.engine = 'BLENDER_EEVEE'
    bpy.context.scene.render.image_settings.file_format = 'PNG'
    
    # 添加灯光
    light_data = bpy.data.lights.new(name="MainLight", type='POINT')
    light_data.energy = 1000
    light_object = bpy.data.objects.new(name="MainLight", object_data=light_data)
    bpy.context.scene.collection.objects.link(light_object)
    light_object.location = (5, 5, 5)
    
    # 添加相机
    camera_data = bpy.data.cameras.new(name="MainCamera")
    camera_object = bpy.data.objects.new(name="MainCamera", object_data=camera_data)
    bpy.context.scene.collection.objects.link(camera_object)
    camera_object.location = (0, -10, 5)
    camera_object.rotation_euler = (1.1, 0, 0)
    
    # 设置相机为活动相机
    bpy.context.scene.camera = camera_object
    
    # 导出3D模型
    try:
        bpy.ops.export_scene.gltf(
            filepath=output_path,
            export_format='GLB',
            export_selected=True,
            export_materials='EXPORT',
            export_apply=True
        )
        print(f"3D模型导出成功: {output_path}")
    except Exception as e:
        print(f"3D模型导出失败: {e}")
        sys.exit(1)


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python generate_3d_model.py <input_image_path> <output_model_path>")
        sys.exit(1)
    
    input_image = sys.argv[1]
    output_model = sys.argv[2]
    
    # 检查输入图片是否存在
    if not os.path.exists(input_image):
        print(f"输入图片不存在: {input_image}")
        sys.exit(1)
    
    # 确保输出目录存在
    output_dir = os.path.dirname(output_model)
    if output_dir and not os.path.exists(output_dir):
        os.makedirs(output_dir)
    
    main(input_image, output_model)