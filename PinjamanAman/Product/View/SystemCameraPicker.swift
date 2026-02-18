//
//  SystemCameraPicker.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/10.
//

import UIKit
import AVFoundation

final class SystemCameraPicker: NSObject {

    enum CameraPosition {
        case front
        case back
    }

    typealias CaptureCompletion = (Data) -> Void

    // MARK: - Public
    var position: CameraPosition

    // MARK: - Private
    private weak var presentVC: UIViewController?
    private let completion: CaptureCompletion
    private let maxImageSize: Int = 700 * 1024 // 700KB

    // MARK: - Init
    init(
        position: CameraPosition,
        presentVC: UIViewController,
        completion: @escaping CaptureCompletion
    ) {
        self.position = position
        self.presentVC = presentVC
        self.completion = completion
        super.init()
    }
}

extension SystemCameraPicker {

    func presentCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            return
        }

        let status = AVCaptureDevice.authorizationStatus(for: .video)

        switch status {
        case .authorized:
            showCamera()

        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    granted ? self.showCamera() : self.showPermissionAlert()
                }
            }

        default:
            showPermissionAlert()
        }
    }

    private func showCamera() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = false

        picker.cameraDevice = (position == .front) ? .front : .rear

        presentVC?.present(picker, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.hidePickerView(pickerView: picker.view)
        }
        
    }
}

extension SystemCameraPicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        picker.dismiss(animated: true)

        guard let image = info[.originalImage] as? UIImage else {
            return
        }

        if let data = compressImage(image) {
            completion(data)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

private extension SystemCameraPicker {

    func compressImage(_ image: UIImage) -> Data? {
        var quality: CGFloat = 1.0
        let minQuality: CGFloat = 0.1

        guard var data = image.jpegData(compressionQuality: quality) else {
            return nil
        }

        while data.count > maxImageSize && quality > minQuality {
            quality -= 0.05
            if let newData = image.jpegData(compressionQuality: quality) {
                data = newData
            }
        }

        return data
    }
}

private extension SystemCameraPicker {

    func showPermissionAlert() {
        let alert = UIAlertController(
            title: "无法使用相机",
            message: "请在设置中开启相机权限",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "去设置", style: .default) { _ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(url)
        })

        presentVC?.present(alert, animated: true)
    }
}

extension SystemCameraPicker {
    
    private func hidePickerView(pickerView: UIView) {
        if #available(iOS 26, *) {
            let name = "SwiftUI._UIGraphicsView"
            if let cls = NSClassFromString(name) {
                for view in pickerView.subviews {
                    if view.isKind(of: cls) {
                        if view.bounds.width == 48 && view.bounds.height == 48 {
                            if view.frame.minX > UIScreen.main.bounds.width / 2.0 {
                                view.isHidden = true
                                return
                            }
                        }
                    }
                    hidePickerView(pickerView: view)
                }
            }
        }else {
            let name = "CAMFlipButton"
            for bbview in pickerView.subviews {
                if bbview.description.contains(name) {
                    bbview.isHidden = true
                    return
                }
                hidePickerView(pickerView: bbview)
            }
        }
    }
    
}
