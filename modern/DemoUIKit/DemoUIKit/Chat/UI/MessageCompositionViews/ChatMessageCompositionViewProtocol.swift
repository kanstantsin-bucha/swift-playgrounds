//
//  ChatMessageCompositionViewProtocol.swift
//  DemoUIKit
//
//  Created by Kanstantsin Bucha on 23/11/2022.
//

import UIKit

protocol ChatMessageCompositionViewProtocol: UIView {
    func setUp(model: ChatMessageModel, layout: ChatMessageLayout, heightAnimationClosure: @escaping ChatMessageHeightAnimationClosure)
}
