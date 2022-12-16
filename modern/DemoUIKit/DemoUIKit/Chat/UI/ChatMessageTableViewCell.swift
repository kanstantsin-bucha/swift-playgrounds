//
//  ChatMessageTableViewCell.swift
//  DemoUIKit
//
//  Created by Kanstantsin Bucha on 23/11/2022.
//

import UIKit

class ChatMessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var messageView: ChatMessageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    func setUp(model: ChatMessageModel, layout: ChatMessageLayout, heightAnimationClosure: @escaping ChatMessageHeightAnimationClosure) {
        messageView.setUp(model: model, layout: layout, heightAnimationClosure: heightAnimationClosure)
        contentView.layoutIfNeeded()
    }
    
    private func setUpView() {
        contentView.backgroundColor = .clear
    }
}
