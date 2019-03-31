//
//  YPPermissionConfig.swift
//  YPImagePicker
//
//  Created by Andrey Gordeev on 24/03/2019.
//  Copyright © 2019 Yummypets. All rights reserved.
//

import Foundation
import PhotosUI
import AVFoundation

struct YPPermissionConfig {
    typealias ActionBlock = (_ completionHandler: @escaping (Bool) -> Void) -> Void

    let title: String
    let description: String
    let actionButtonTitle: String
    let actionBlock: ActionBlock
}

// MARK: - Predefined configurations
extension YPPermissionConfig {
    static let askForPermissionLibraryConfig = YPPermissionConfig(title: "Please allow access to your photos",
                                                                  description: "This allows our app to share photos from your library and save photos to your camera roll",
                                                                  actionButtonTitle: "Enable Library Access",
                                                                  actionBlock: { completionHandler in
                                                                    PHPhotoLibrary.requestAuthorization { status in
                                                                        DispatchQueue.main.async {
                                                                            completionHandler(status == .authorized)
                                                                        }
                                                                    }
    })

    static let askForPermissionCameraConfig = YPPermissionConfig(title: "Please allow access to your camera",
                                                                 description: "This allows our app to share photos from your camera",
                                                                 actionButtonTitle: "Enable Camera Access",
                                                                 actionBlock: { completionHandler in
                                                                    AVCaptureDevice.requestAccess(for: .video) { status in
                                                                        DispatchQueue.main.async {
                                                                            completionHandler(status)
                                                                        }
                                                                    }
    })

    static let declinedPermissionLibraryConfig = YPPermissionConfig(title: "You have denied Photo Library permission",
                                                                    description:
        """
        Please allow the access to Photo Library. This lets our app to share photos from your library and save photos to your camera roll
        """,
                                                                    actionButtonTitle: "Open Settings",
                                                                    actionBlock: { completionHandler in
                                                                        DispatchQueue.main.async {
                                                                            if let url = URL(string: UIApplication.openSettingsURLString) {
                                                                                if #available(iOS 10.0, *) {
                                                                                    UIApplication.shared.open(url)
                                                                                } else {
                                                                                    UIApplication.shared.openURL(url)
                                                                                }
                                                                            }
                                                                            completionHandler(false)
                                                                        }
    })

    static let declinedPermissionCameraConfig = YPPermissionConfig(title: "You have denied Camera permission",
                                                                   description: "Please allow the access to Camera. This lets our app to share photos from your camera",
                                                                   actionButtonTitle: "Open Settings",
                                                                   actionBlock: { completionHandler in
                                                                    DispatchQueue.main.async {
                                                                        if let url = URL(string: UIApplication.openSettingsURLString) {
                                                                            if #available(iOS 10.0, *) {
                                                                                UIApplication.shared.open(url)
                                                                            } else {
                                                                                UIApplication.shared.openURL(url)
                                                                            }
                                                                        }
                                                                        completionHandler(false)
                                                                    }
    })
}
