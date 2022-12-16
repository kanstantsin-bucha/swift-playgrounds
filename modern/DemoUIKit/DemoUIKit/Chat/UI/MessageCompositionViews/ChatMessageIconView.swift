//
//  ChatMessageIconView.swift
//  DemoUIKit
//
//  Created by Kanstantsin Bucha on 23/11/2022.
//

import UIKit
import Anchorage

public class ChatMessageIconView: UIView {
    private let imageView = UIImageView()
    private let imageSize = CGSize(width: 32, height: 32)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    private func setUpView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        imageView.backgroundColor = .red
        
        imageView.sizeAnchors /==/ imageSize
        imageView.horizontalAnchors /==/ horizontalAnchors
        imageView.topAnchor /==/ topAnchor ~ .low
        imageView.bottomAnchor /==/ bottomAnchor
    }
    
    public func setUp(image: UIImage) {
        imageView.image = image
    }
}
