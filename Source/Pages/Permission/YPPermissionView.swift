//
//  YPPermissionView.swift
//  YPImagePicker
//
//  Created by Andrey Gordeev on 19/03/2019.
//  Copyright © 2019 Yummypets. All rights reserved.
//

import Stevia

class YPPermissionView: UIView {

    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let actionButton = UIButton()
    private var actionBlock: YPPermissionConfig.ActionBlock = { _ in }
    var actionCompleted: (Bool) -> Void = { _ in }

    convenience init(config: YPPermissionConfig) {
        self.init(frame: .zero)

        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 3
        titleLabel.text = "title"
        descriptionLabel.textColor = #colorLiteral(red: 0.3294117647, green: 0.337254902, blue: 0.3450980392, alpha: 1)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 3
        descriptionLabel.text = "description"

        actionButton.setTitle("Action", for: .normal)
        actionButton.setTitleColor(.black, for: .normal)
        actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)

        sv(
            titleLabel,
            descriptionLabel,
            actionButton
        )
        layout(
            200,
            |-titleLabel-| ~ 80,
            8,
            |-descriptionLabel-| ~ 80,
            8,
            |actionButton| ~ 80,
            ""
        )

        backgroundColor = .white

        configure(config: config)
    }

    private func configure(config: YPPermissionConfig) {
        titleLabel.text = config.title
        descriptionLabel.text = config.description
        actionButton.setTitle(config.actionButtonTitle, for: .normal)
        actionBlock = config.actionBlock
    }

    @objc private func actionButtonPressed() {
        actionBlock(actionCompleted)
    }
}
