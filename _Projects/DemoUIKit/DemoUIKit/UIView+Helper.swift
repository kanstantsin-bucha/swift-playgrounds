//
//  UIView+Helper.swift
//  DemoUIKit
//
//  Created by Andrei Kasykhin on 2022-11-22.
//

import UIKit

extension UIView {
    
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
        
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let size = CGSize(width: radius, height: radius)
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: size)
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    func applyCorners(isRecieved: Bool) {
        let tag = 55555
        guard let subView = subviews.first(where: {$0.tag == tag}) else {
            let subView = UIView(frame: bounds)
            subView.tag = tag
            subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            insertSubview(subView, at: 0)
            applyChatCorners(for: subView, isRecieved: isRecieved)
            return
        }
        applyChatCorners(for: subView, isRecieved: isRecieved)
    }
    
    private func applyChatCorners(for subView: UIView, isRecieved: Bool) {
        subView.backgroundColor = isRecieved ? Colors.Secondary.secondaryContainer : Colors.Primary.primaryContainer
        subView.layer.cornerRadius = 12
        subView.clipsToBounds = true
        if isRecieved {
            subView.layer.maskedCorners = [ .layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner ]
        } else {
            subView.layer.maskedCorners = [ .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner ]
        }
    }
}
