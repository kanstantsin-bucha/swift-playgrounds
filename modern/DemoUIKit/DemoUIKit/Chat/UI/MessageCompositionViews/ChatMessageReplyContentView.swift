//
//  ChatMessageReplyContentView.swift
//  DemoUIKit
//
//  Created by Kanstantsin Bucha on 23/11/2022.
//

import UIKit
import Anchorage

class ChatMessageReplyContentView: UIView, ChatMessageCompositionViewProtocol {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var expandChevronIcon: UIImageView!
    @IBOutlet var leadingEqual: NSLayoutConstraint!
    @IBOutlet var leadingGreater: NSLayoutConstraint!
    @IBOutlet var trailingEqual: NSLayoutConstraint!
    @IBOutlet var trailingGreater: NSLayoutConstraint!
    @IBOutlet var labelHeightConstraint: NSLayoutConstraint!
    private weak var expandedWidthConstraint: NSLayoutConstraint?
    
    private var isViewExpanded: Bool {
        !labelHeightConstraint!.isActive
    }
    
    private lazy var tapGestureRecogniser: UITapGestureRecognizer = {
        let recogniser = UITapGestureRecognizer(target: self, action: #selector(didTap))
        return recogniser
    }()
    
    private var heightAnimationClosure: ChatMessageHeightAnimationClosure = { _ in }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    private func setUpView() {
        addGestureRecognizer(tapGestureRecogniser)
    }
    
    @objc func didTap() {
        // Expand label
        heightAnimationClosure({ [weak self] in
            guard let self = self else { return }
            self.updateState(isExpanded: !self.isViewExpanded)
        })
    }
    
    func setUp(model: ChatMessageModel, layout: ChatMessageLayout, heightAnimationClosure: @escaping ChatMessageHeightAnimationClosure) {
        self.heightAnimationClosure = heightAnimationClosure
        // TODO: improve to support RTL
        updateConstraints(layout: layout)
        self.updateState(isExpanded: false)
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
    
    private func updateState(isExpanded: Bool) {
        if isExpanded {
            expandedWidthConstraint = label.widthAnchor /==/ label.bounds.width
            labelHeightConstraint.isActive = false
        } else {
            expandedWidthConstraint?.isActive = false
            labelHeightConstraint.isActive = true
        }
        let image = UIImage(named: isExpanded ? "chat_message_reply_close" : "chat_message_reply_open")
        self.expandChevronIcon.image = image
    }
}
