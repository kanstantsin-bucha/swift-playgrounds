//
//  ChatMessageNameView.swift
//  DemoUIKit
//
//  Created by Kanstantsin Bucha on 23/11/2022.
//

import UIKit
import Anchorage

class ChatMessageNameView: UIView {
    @IBOutlet weak var fromName: ColoredLabel!
    @IBOutlet weak var toName: ColoredLabel!
    @IBOutlet var leadingEqual: NSLayoutConstraint!
    @IBOutlet var leadingGreater: NSLayoutConstraint!
    @IBOutlet var trailingEqual: NSLayoutConstraint!
    @IBOutlet var trailingGreater: NSLayoutConstraint!
    
    private let height: CGFloat = 20
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    private func setUpView() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor /==/ height
        setContentHuggingPriority(.required, for: .horizontal)
        setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    func setUp(fromModel: LabelUIModel, toModel: LabelUIModel, layout: ChatMessageLayout, heightAnimationClosure: @escaping ChatMessageHeightAnimationClosure) {
        updateConstraints(layout: layout)
        fromModel.applyTo(coloredLabel: fromName)
        toModel.applyTo(coloredLabel: toName)
    }
        
    private func updateConstraints(layout: ChatMessageLayout) {
        switch layout {
        case .leading:
            leadingEqual.isActive = true
            leadingGreater.isActive = false
            trailingEqual.isActive = false
            trailingGreater.isActive = true
            
        case .trailing:
            leadingEqual.isActive = false
            leadingGreater.isActive = true
            trailingEqual.isActive = true
            trailingGreater.isActive = false
        }
    }
}
