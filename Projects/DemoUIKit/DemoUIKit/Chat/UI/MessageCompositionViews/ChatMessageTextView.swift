//
//  ChatMessageTextView.swift
//  DemoUIKit
//
//  Created by Kanstantsin Bucha on 23/11/2022.
//

import UIKit

class ChatMessageTextView: UIView, ChatMessageCompositionViewProtocol {
    
    @IBOutlet weak var label: UILabel!
    
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
        setContentHuggingPriority(.defaultHigh, for: .horizontal)
        setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    func setUp(model: ChatMessageModel, layout: ChatMessageLayout, heightAnimationClosure: @escaping ChatMessageHeightAnimationClosure) {
        // TODO: improve to support RTL
        label.text = model.text
        label.textAlignment = layout == .leading ? .left : .right
    }
}
