//
//  YPPermissionPresentable.swift
//  YPImagePicker
//
//  Created by Andrey Gordeev on 31/03/2019.
//  Copyright © 2019 Yummypets. All rights reserved.
//

import UIKit

protocol YPPermissionPresentable {
    func presentPermissionView(config: YPPermissionConfig, block: @escaping (Bool) -> Void)
}

extension YPPermissionPresentable where Self: UIViewController {
    func presentPermissionView(config: YPPermissionConfig, block: @escaping (Bool) -> Void) {
        dismissAlreadyPresentedPermissionViewControllerIfNeeded()

        let viewController = YPPermissonVC(config: config)
        viewController.dismissViewController = {
            viewController.willMove(toParent: nil)
            viewController.view.removeFromSuperview()
            viewController.removeFromParent()
        }
        viewController.actionCompleted = block
        addChild(viewController)
        view.sv(viewController.view)
        viewController.didMove(toParent: self)
        viewController.view.fillContainer()
    }

    private func dismissAlreadyPresentedPermissionViewControllerIfNeeded() {
        let viewControllerToDismiss = children.first(where: { $0 is YPPermissonVC }) as? YPPermissonVC
        viewControllerToDismiss?.dismissViewController()
    }
}
