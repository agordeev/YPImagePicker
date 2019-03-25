//
//  YPPermissionVC.swift
//  YPImagePicker
//
//  Created by Andrey Gordeev on 19/03/2019.
//  Copyright © 2019 Yummypets. All rights reserved.
//

import UIKit

class YPPermissonVC: UIViewController {
    private let v: YPPermissionView
    var actionCompleted: (Bool) -> Void = { _ in }
    var dismissViewController: () -> Void = {}

    init(config: YPPermissionConfig) {
        v = YPPermissionView(config: config)
        super.init(nibName: nil, bundle: nil)
        v.actionCompleted = { result in
            self.actionCompleted(result)
            self.dismissViewController()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() { view = v }
}
