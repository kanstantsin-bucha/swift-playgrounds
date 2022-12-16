//
//  LabelUIModel.swift
//  DemoUIKit
//
//  Created by Kanstantsin Bucha on 24/11/2022.
//

import UIKit

struct LabelUIModel {
    let text: String?
    let backgroundColor: UIColor?
    let textColor: UIColor?
    let edgeInsets: UIEdgeInsets
    let cornerRadius: CGFloat
}

extension LabelUIModel {
    func applyTo(coloredLabel: ColoredLabel) {
        coloredLabel.setup(
            text: text,
            textColor: textColor,
            backgroundColor: backgroundColor,
            cornerRadius: cornerRadius,
            backgroundInsets: edgeInsets
        )
    }
}
