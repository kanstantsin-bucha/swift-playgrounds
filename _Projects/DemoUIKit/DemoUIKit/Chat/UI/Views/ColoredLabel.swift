//
//  ColoredLabel.swift
//  DemoUIKit
//
//  Created by Andrei Kasykhin on 2022-11-24.
//

import UIKit
import Anchorage

//class BorderedLabel: UILabel {
//    private let backgroundView = UIView()
//    
//    init() {
//        super.init(frame: .zero)
//        setupUI()
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: .zero)
//        setupUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupUI()
//    }
//    
//    func setupUI() {
//        addSubview(backgroundView)
////        sendSubviewToBack(backgroundView)
//        bringSubviewToFront(backgroundView)
//        let edgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
//        backgroundView.edgeAnchors /==/ edgeAnchors + edgeInsets
//        backgroundColor = .green
//        clipsToBounds = false
//    }
//}


class ColoredLabel: UIView {
    
    private var label: UILabel!
    private var edgeConstraints: ConstraintGroup?
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        label = setup(UILabel(),
                      addToView: self,
                      setupBlock: {
            $0.font = UIFont.systemFont(ofSize: 13)
            $0.textColor = .white
        })
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.init(950), for: .horizontal)
        edgeConstraints = label.edgeAnchors /==/ edgeAnchors
        layer.cornerRadius = 0
    }
}

extension ColoredLabel {
    func setup(text: String,
               textColor: UIColor,
               font: UIFont) {
        label.text = text
        label.font = font
        label.textColor = textColor
        layoutIfNeeded()
    }
    
    func setup(text: String?,
               textColor: UIColor?,
               backgroundColor: UIColor? = nil,
               borderColor: UIColor? = nil,
               borderWidth: CGFloat? = nil,
               cornerRadius: CGFloat? = nil,
               backgroundInsets: UIEdgeInsets? = nil) {
        label.text = text
        label.textColor = textColor
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        if let borderWidth = borderWidth {
            self.borderWidth = borderWidth
        }
        if let cornerRadius = cornerRadius {
            self.cornerRadius = cornerRadius
        }
        if let insets = backgroundInsets {
            edgeConstraints.map { NSLayoutConstraint.deactivate($0.all) }
            edgeConstraints = label.edgeAnchors /==/ edgeAnchors + insets
        }
    }
}
