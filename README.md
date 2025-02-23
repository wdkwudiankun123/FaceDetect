# FaceDetect
人脸识别demo

制作一个手机 app 拍照，将图片上传到云端计算机视觉库，检测图片内部的人脸数量。将数量信息发送回移动应用程序。本demo在iOS上构建，使用了UIImagePickerController。

整个流程是：App拍照 -> 转成Base64或者直接上传文件到服务器 -> 服务器用OpenCV或其他开源框架检测人脸 -> 返回数量 -> App显示。

为了避免搭建服务器，以及方便快捷展示demo效果，本次直接采用Vision框架（iOS系统中用于计算机视觉任务的框架）。

| Image 1 | Image 2 |
| ---- | ---- |
| <img src="../main/screenshot/1.pic.jpg" height="600px"/> | <img src="../main/screenshot/2.pic.jpg" height="600px"/>|


| Image 3 | Image 4 |
| ---- | ---- |
| <img src="../main/screenshot/3.pic.jpg" height="600px"/> | <img src="../main/screenshot/4.pic.jpg" height="600px"/>|
