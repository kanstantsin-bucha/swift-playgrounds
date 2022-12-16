//
//  UIView+Autolayout.swift
//  DemoUIKit
//
//  Created by Kanstantsin Bucha on 23/11/2022.
//

import UIKit

extension UIView {
    func autolayout() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}

typealias SetupViewBlock<T> = (_ view: T) -> Void

protocol LayoutView {
    @discardableResult
    func setup<T>(_ view: T) -> T where T: UIView
    
    @discardableResult
    func setup<T>(_ view: T, setupBlock: SetupViewBlock<T>?) -> T where T: UIView

    @discardableResult
    func setup<T>(_ view: T, setupBlock: SetupViewBlock<T>?) -> T where T: UIResponder

    @discardableResult
    func setup<T>(_ view: T, addToView parentView: UIView) -> T where T: UIView

    @discardableResult
    func setup<T>(_ view: T, addToView parentView: UIView, setupBlock: @escaping SetupViewBlock<T>) -> T where T: UIResponder

    @discardableResult
    func setup<T>(_ view: T, addToStackView stackView: UIStackView) -> T where T: UIView

    @discardableResult
    func setup<T>(_ view: T, addToStackView stackView: UIStackView, setupBlock: @escaping SetupViewBlock<T>) -> T where T: UIResponder

    @discardableResult
    func setup<T>(_ view: T, addToView parentView: UIView?, addToStackView stackView: UIStackView?, setupBlock: SetupViewBlock<T>?) -> T where T: UIResponder
}

extension UIView: LayoutView {
    @discardableResult
    func setup<T>(_ view: T) -> T where T: UIView {
        setup(view, addToView: nil, setupBlock: nil)
    }

    @discardableResult
    func setup<T>(_ view: T, setupBlock: SetupViewBlock<T>? = nil) -> T where T: UIView {
        setup(view, addToView: nil, setupBlock: nil)
    }

    @discardableResult
    func setup<T>(_ view: T, setupBlock: SetupViewBlock<T>? = nil) -> T where T: UIResponder {
        setup(view, addToView: nil, addToStackView: nil, setupBlock: nil)
    }

    @discardableResult
    func setup<T>(_ view: T, addToView parentView: UIView) -> T where T: UIView {
        setup(view, addToView: parentView, addToStackView: nil, setupBlock: nil)
    }

    @discardableResult
    func setup<T>(_ view: T, addToView parentView: UIView, setupBlock: @escaping SetupViewBlock<T>) -> T where T: UIResponder {
        setup(view, addToView: parentView, addToStackView: nil, setupBlock: setupBlock)
    }

    @discardableResult
    func setup<T>(_ view: T, addToStackView stackView: UIStackView) -> T where T: UIView {
        setup(view, addToView: nil, addToStackView: stackView, setupBlock: nil)
    }

    @discardableResult
    func setup<T>(_ view: T, addToStackView stackView: UIStackView, setupBlock: @escaping SetupViewBlock<T>) -> T where T: UIResponder {
        setup(view, addToView: nil, addToStackView: stackView, setupBlock: setupBlock)
    }

    @discardableResult
    func setup<T>(_ view: T, addToView parentView: UIView? = nil, addToStackView stackView: UIStackView? = nil, setupBlock: SetupViewBlock<T>? = nil) -> T where T: UIResponder {
        if let view = view as? UIView {
            view.translatesAutoresizingMaskIntoConstraints = false
            if let parentView = parentView {
                parentView.addSubview(view)
            } else {
                stackView?.addArrangedSubview(view)
            }
            
        }
        if let setupBlock = setupBlock {
            setupBlock(view)
        }
        return view
    }
}

extension UIViewController: LayoutView {
    @discardableResult
    func setup<T>(_ view: T) -> T where T: UIView {
        setup(view, addToView: nil, setupBlock: nil)
    }

    @discardableResult
    func setup<T>(_ view: T, setupBlock: SetupViewBlock<T>? = nil) -> T where T: UIView {
        setup(view, addToView: nil, setupBlock: nil)
    }

    @discardableResult
    func setup<T>(_ view: T, setupBlock: SetupViewBlock<T>? = nil) -> T where T: UIResponder {
        setup(view, addToView: nil, addToStackView: nil, setupBlock: nil)
    }

    @discardableResult
    func setup<T>(_ view: T, addToView parentView: UIView) -> T where T: UIView {
        setup(view, addToView: parentView, addToStackView: nil, setupBlock: nil)
    }

    @discardableResult
    func setup<T>(_ view: T, addToView parentView: UIView, setupBlock: @escaping SetupViewBlock<T>) -> T where T: UIResponder {
        setup(view, addToView: parentView, addToStackView: nil, setupBlock: setupBlock)
    }

    @discardableResult
    func setup<T>(_ view: T, addToStackView stackView: UIStackView) -> T where T: UIView {
        setup(view, addToView: nil, addToStackView: stackView, setupBlock: nil)
    }

    @discardableResult
    func setup<T>(_ view: T, addToStackView stackView: UIStackView, setupBlock: @escaping SetupViewBlock<T>) -> T where T: UIResponder {
        setup(view, addToView: nil, addToStackView: stackView, setupBlock: setupBlock)
    }

    @discardableResult
    func setup<T>(_ view: T, addToView parentView: UIView? = nil, addToStackView stackView: UIStackView? = nil, setupBlock: SetupViewBlock<T>? = nil) -> T where T: UIResponder {
        if let view = view as? UIView {
            view.translatesAutoresizingMaskIntoConstraints = false
            if let parentView = parentView {
                parentView.addSubview(view)
            } else {
                stackView?.addArrangedSubview(view)
            }
            
        }
        if let setupBlock = setupBlock {
            setupBlock(view)
        }
        return view
    }
}

extension UIView {
    @discardableResult
    func toSquare(size: CGFloat, priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        let width = widthAnchor.constraint(equalToConstant: size)
        width.priority = priority
        let height = heightAnchor.constraint(equalToConstant: size)
        height.priority = priority
        width.isActive = true
        height.isActive = true
        return [width, height]
    }
}

extension UIFont {
    func weight(_ weight: UIFont.Weight) -> UIFont {
        var traits = fontDescriptor.fontAttributes[.traits] as? [UIFontDescriptor.TraitKey: Any] ?? [:]
        traits[.weight] = weight
        return UIFont(descriptor: fontDescriptor.addingAttributes([.traits: traits]), size: pointSize)
    }
}

extension UIColor {
    
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            } else if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: 1.0)
                    return
                }
            }
        }
        return nil
    }
}
