//
//  ChatMessageReactionItemView.swift
//  DemoUIKit
//
//  Created by Kanstantsin Bucha on 25/11/2022.
//


import UIKit
import Anchorage

class ChatMessageReactionsItemView: UIView {
    private let icon = UIImageView()
    private let countLabel = UILabel()
    
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
        addSubview(icon)
        addSubview(countLabel)
        
        backgroundColor = .white
        layer.cornerRadius = 4
        
        countLabel.textColor = .black
        countLabel.font = .systemFont(ofSize: 12)
        
        countLabel.leadingAnchor /==/ leadingAnchor + 4
        countLabel.verticalAnchors /==/ verticalAnchors + 4
        countLabel.trailingAnchor /==/ icon.leadingAnchor - 4
        icon.verticalAnchors /==/ verticalAnchors + 4
        icon.heightAnchor /==/ icon.widthAnchor
        icon.trailingAnchor /==/ trailingAnchor - 4
    }
    
    func setUp(reaction: ChatMessageReactionItem) {
        countLabel.text = String(reaction.count)
        icon.image = UIImage(named: reaction.reaction.imageName)
    }
}

