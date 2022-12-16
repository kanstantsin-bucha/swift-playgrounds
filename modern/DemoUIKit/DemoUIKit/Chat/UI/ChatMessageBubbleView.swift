//
//  ChatMessageBubbleView.swift
//  DemoUIKit
//
//  Created by Kanstantsin Bucha on 23/11/2022.
//

import UIKit
import Anchorage

class ChatMessageBubbleView: UIView {
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 3.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor  = .clear
        return stackView
    }()
    
    private let nameView = Bundle.main.loadNibNamed("ChatMessageNameView", owner: nil)?.first as! ChatMessageNameView
    private let replayView = Bundle.main.loadNibNamed("ChatMessageReplyContentView", owner: nil)?.first as! ChatMessageCompositionViewProtocol
    private let fileView = ChatMessageFileView()
    private let textView = Bundle.main.loadNibNamed("ChatMessageTextView", owner: nil)?.first as! ChatMessageCompositionViewProtocol
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    private func setUpView() {
        backgroundColor = .clear
        layer.cornerRadius = 16
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(verticalStackView)
        
        let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        verticalStackView.edgeAnchors /==/ edgeAnchors + insets
        verticalStackView.heightAnchor /==/ 32 ~ .low
        
        [nameView, replayView, fileView, textView].forEach { verticalStackView.addArrangedSubview($0) }
    }
    
    func setUp(model: ChatMessageModel, layout: ChatMessageLayout, heightAnimationClosure: @escaping ChatMessageHeightAnimationClosure) {
        updateViews(model: model)
        backgroundColor = UIColor(named: layout == .leading ? "secondary-container" : "primary-container")
        nameView.setUp(fromModel: model.fromModel, toModel: model.toModel, layout: layout, heightAnimationClosure: heightAnimationClosure)
        replayView.setUp(model: model, layout: layout, heightAnimationClosure: heightAnimationClosure)
        replayView.isHidden = true
        textView.setUp(model: model, layout: layout, heightAnimationClosure: heightAnimationClosure)
        fileView.setUp(item: model.fileItem) { print("Download") }
        // TODO: setup all views here
    }
    
    private func updateViews(model: ChatMessageModel) {
        verticalStackView.arrangedSubviews.forEach {
            verticalStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        var subviews = [UIView]()
        if model.type == "Named" {
            subviews.append(nameView)
        }
        if model.replyText != nil {
            subviews.append(replayView)
        }
        if model.file {
            subviews.append(fileView)
        }
        if !model.text.isEmpty {
            subviews.append(textView)
        }
        
//        let labelView = UILabel().autolayout()
//        labelView.text = model.text
//        labelView.textColor = .blue
////        labelView.textAlignment = layout == .leading ? .left : .right
//        labelView.backgroundColor = .green
//        labelView.font = .systemFont(ofSize: 20)
//        labelView.setContentHuggingPriority(.required, for: .horizontal)
//        labelView.setContentCompressionResistancePriority(.required, for: .horizontal)
//
//        subviews.append(labelView)
        
        subviews.forEach { verticalStackView.addArrangedSubview($0) }
    }
}
