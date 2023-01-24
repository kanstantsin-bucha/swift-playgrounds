//
//  Colors.swift
//  DemoUIKit
//
//  Created by Andrei Kasykhin on 2022-11-22.
//

import UIKit

struct Colors {
    struct Background {
        static let background1 = UIColor.color(withName: "background-1")
        static let background2 = UIColor.color(withName: "background-2")
        static let background3 = UIColor.color(withName: "background-3")
        
        static let backgroundChatMessage = UIColor.color(withName: "background-chat-message")
        static let backgroundChat = UIColor.color(withName: "background-chat")
        
        static let backgroundBorder = UIColor.color(withName: "background-border")
        static let backgroundCanvas = UIColor.color(withName: "background-canvas")
        
        static let backgroundGradientEnd = UIColor.color(withName: "background-gradient-end")
        static let backgroundGradientStart = UIColor.color(withName: "background-gradient-start")
        
        static let backgroundInteractiveDisabled = UIColor.color(withName: "background-interactive-disabled")
        static let backgroundInteractivePress = UIColor.color(withName: "background-interactive-press")
        
        static let backgroundInteractive = UIColor.color(withName: "background-interactive")
        static let backgroundWhiteboard = UIColor.color(withName: "background-whiteboard")
    }
    struct ColorCoding {
        static let colorCodingAmber = UIColor.color(withName: "color-coding-amber")
        static let colorCodingBlue = UIColor.color(withName: "color-coding-blue")
        static let colorCodingCyan = UIColor.color(withName: "color-coding-cyan")
        static let colorCodingEmerald = UIColor.color(withName: "color-coding-emerald")
        static let colorCodingFuchsia = UIColor.color(withName: "color-coding-fuchsia")
        static let colorCodingGreen = UIColor.color(withName: "color-coding-green")
        static let colorCodingIndigo = UIColor.color(withName: "color-coding-indigo")
        static let colorCodingLime = UIColor.color(withName: "color-coding-lime")
        static let colorCodingOrange = UIColor.color(withName: "color-coding-orange")
        static let colorCodingPink = UIColor.color(withName: "color-coding-pink")
        static let colorCodingPurple = UIColor.color(withName: "color-coding-purple")
        static let colorCodingRed = UIColor.color(withName: "color-coding-red")
        static let colorCodingRose = UIColor.color(withName: "color-coding-rose")
        static let colorCodingSky = UIColor.color(withName: "color-coding-sky")
        static let colorCodingTeal = UIColor.color(withName: "color-coding-teal")
        static let colorCodingViolet = UIColor.color(withName: "color-coding-violet")
    }
    struct Constant {
        static let constantBlack = UIColor.color(withName: "constant-black")
        static let constantWhite = UIColor.color(withName: "constant-white")
    }
    struct Error {
        static let errorContainerPress = UIColor.color(withName: "error-container-press")
        static let errorContainer = UIColor.color(withName: "error-container")
        static let errorPress = UIColor.color(withName: "error-press")
        static let error = UIColor.color(withName: "error")
    }
    struct Foreground {
        static let foreground1 = UIColor.color(withName: "foreground-1")
        static let foreground2 = UIColor.color(withName: "foreground-2")
        static let foreground3 = UIColor.color(withName: "foreground-3")
        static let foregroundDisabled = UIColor.color(withName: "foreground-disabled")
        static let foregroundOnColor = UIColor.color(withName: "foreground-on-color")
    }
    struct Primary {
        static let primaryContainerPress = UIColor.color(withName: "primary-container-press")
        static let primaryContainer = UIColor.color(withName: "primary-container")
        static let primaryPress = UIColor.color(withName: "primary-press")
        static let primary = UIColor.color(withName: "primary")
    }
    struct Secondary {
        static let secondaryContainerPress = UIColor.color(withName: "secondary-container-press")
        static let secondaryContainer = UIColor.color(withName: "secondary-container")
        static let secondaryPress = UIColor.color(withName: "secondary-press")
        static let secondary = UIColor.color(withName: "secondary")
    }
    struct Success {
        static let successContainerPress = UIColor.color(withName: "success-container-press")
        static let successContainer = UIColor.color(withName: "success-container")
        static let successPress = UIColor.color(withName: "success-press")
        static let success = UIColor.color(withName: "success")
    }
    struct Warning {
        static let warningContainerPress = UIColor.color(withName: "warning-container-press")
        static let warningContainer = UIColor.color(withName: "warning-container")
        static let warningPress = UIColor.color(withName: "warning-press")
        static let warning = UIColor.color(withName: "warning")
    }
}


extension UIColor {
    
    static func color(withName name: String) -> UIColor {
        guard let color = UIColor(named: name) else {
            assertionFailure("Color doesn't exist in main bundle")
            return .red
        }
        return color
    }
}
