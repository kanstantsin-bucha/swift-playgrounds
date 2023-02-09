//
//  MessageView.swift
//  DemoUIKit
//
//  Created by Kanstantsin Bucha on 23/11/2022.
//

import UIKit
import Anchorage

public typealias ChatMessageHeightAnimationClosure = (_ layoutChange: @escaping () -> Void) -> Void

public enum ChatMessageLayout {
    case leading
    case trailing
}

class ChatMessageView: UIView {
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 3.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var arrangedSubviews = [UIView]()
    private var currentLayout: ChatMessageLayout?

    private let bubbleView = ChatMessageBubbleView()
    private let iconView = ChatMessageIconView()
    private let reactionsView = ChatMessageReactionsView()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    private func setUpView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalStackView)
        addSubview(reactionsView)
        
        horizontalStackView.widthAnchor /==/ 64 ~ .low
        horizontalStackView.topAnchor /==/ topAnchor + 8
        horizontalStackView.horizontalAnchors /==/ horizontalAnchors
        horizontalStackView.bottomAnchor /==/ reactionsView.topAnchor + 8
        reactionsView.horizontalAnchors /==/ horizontalAnchors
        reactionsView.bottomAnchor /==/ bottomAnchor
        reactionsView.heightAnchor /==/ 21
    }
    
    /// Set ups views hierarchy
    /// - Parameters:
    ///   - model: Model of the message
    ///   - layout: Layout of the message
    func setUp(model: ChatMessageModel, layout: ChatMessageLayout, heightAnimationClosure: @escaping ChatMessageHeightAnimationClosure) {
        if currentLayout != layout {
            rearrangeSubviews(layout: layout)
        }
        iconView.setUp(image: UIImage())
        bubbleView.setUp(model: model, layout: layout, heightAnimationClosure: heightAnimationClosure)
        reactionsView.setUp(reactions: model.reactionItems, layout: layout, heightAnimationClosure: heightAnimationClosure)
    }
    
    private func rearrangeSubviews(layout: ChatMessageLayout) {
        currentLayout = layout
        arrangedSubviews.forEach {
            horizontalStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        let spacerView = UIView().autolayout()
      
        let orderedSubviews: [UIView]
        switch layout {
        case .trailing:
            orderedSubviews = [spacerView, bubbleView, iconView]
        case .leading:
            orderedSubviews = [iconView, bubbleView, spacerView]
        }
        orderedSubviews.forEach { horizontalStackView.addArrangedSubview($0) }

        spacerView.widthAnchor /==/ 1000 ~ .init(750)
        spacerView.widthAnchor />=/ horizontalStackView.widthAnchor * 0.4 ~ .required
        bubbleView.setContentHuggingPriority(.required, for: .horizontal)
        arrangedSubviews = orderedSubviews
    }
}
