//
//  ViewController.swift
//  FaceDetect
//
//  Created by KUN on 2025/2/23.
//

import UIKit
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let button: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("拍摄照片", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        button.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
    }
    
    private func setupUI() {
        let stack = UIStackView(arrangedSubviews: [imageView, button, resultLabel])
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])
    }
    
    @objc private func takePhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        present(picker, animated: true)
    }
    
    // MARK: - Image Picker Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else {
            resultLabel.text = "获取图片失败"
            return
        }
        
        imageView.image = image
        recognizeFace(image)
    }
    
    private func recognizeFace(_ image: UIImage) {
        // 读取图片
        guard let ciImage = CIImage(image: image) else { return }
        
        // 创建人脸检测请求
        let faceDetectionRequest = VNDetectFaceRectanglesRequest(completionHandler: { [weak self] (request, error) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if let error = error {
                    self.resultLabel.text = "人脸检测出错: \(error.localizedDescription)"
                    return
                }
                if let results = request.results as? [VNFaceObservation] {
                    let faceCount = results.count
                    // 可以在这里更新 UI 显示人脸数量
                    self.resultLabel.text = "检测到 \(faceCount) 张人脸"
                } else {
                    self.resultLabel.text = "未检测到人脸"
                }
            }
        })
        
        // 创建请求句柄
        let requestHandler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        
        // 执行请求
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try requestHandler.perform([faceDetectionRequest])
            } catch {
                print("执行请求出错: \(error)")
            }
        }
    }
}
