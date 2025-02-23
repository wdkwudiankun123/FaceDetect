# FaceDetect
人脸识别demo

使用 100% 开源技术，制作一个手机 app 拍照，将图片上传到云端计算机视觉库，检测图片内部的人脸数量。将数量信息发送回移动应用程序。本demo在iOS上构建，使用了UIImagePickerController。

整个流程是：App拍照 -> 转成Base64或者直接上传文件到服务器 -> 服务器用OpenCV检测人脸 -> 返回数量 -> App显示。
