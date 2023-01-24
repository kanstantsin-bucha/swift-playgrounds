//
//  ChatMessageReactionsView.swift
//  DemoUIKit
//
//  Created by Kanstantsin Bucha on 25/11/2022.
//

import UIKit
import Anchorage

class ChatMessageReactionsView: UIView {
    private let inset: CGFloat = 36
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 3.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var leadingConstraint: NSLayoutConstraint = {
        horizontalStackView.leadingAnchor /==/ leadingAnchor + inset
    }()
    
    private lazy var trailingConstraint: NSLayoutConstraint = {
        horizontalStackView.trailingAnchor /==/ trailingAnchor - inset
    }()
    
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
        addSubview(horizontalStackView)
        
        horizontalStackView.verticalAnchors /==/ verticalAnchors
        horizontalStackView.widthAnchor /==/ 8 ~ .low
    }
    
    func setUp(reactions: [ChatMessageReactionItem], layout: ChatMessageLayout, heightAnimationClosure: @escaping ChatMessageHeightAnimationClosure) {
        switch layout {
        case .leading:
            trailingConstraint.isActive = false
            leadingConstraint.isActive = true
            
        case .trailing:
            trailingConstraint.isActive = true
            leadingConstraint.isActive = false
        }
        horizontalStackView.arrangedSubviews.forEach {
            horizontalStackView.removeArrangedSubview($0)
            // FIX: fix of the bug when previous arranged subviews stay in the stack view
            $0.removeFromSuperview()
        }
        reactions.forEach {
            let view = ChatMessageReactionsItemView()
            horizontalStackView.addArrangedSubview(view)
            view.setUp(reaction: $0)
        }
    }
}
