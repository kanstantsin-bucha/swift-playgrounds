//: [Previous](@previous)

import UIKit
import XCTest


#if os(iOS) || targetEnvironment(simulator)
import UIKit
// copy Print_Print.bundle into modernPlay-gowtdfwgtfvjqvghlycesbwmuamt/Build/Intermediates.noindex/Playgrounds/Products/Debug-iphonesimulator/PackageFrameworks/Print.framework
public extension UIColor {
//    private static var packageBundle: Bundle {
//        Bundle.module
//    }
    
    static var lime: UIColor {
//        UIColor(named: "Lime", in: packageBundle, compatibleWith: nil)!
        UIColor(hue: 0.4, saturation: 1, brightness: 1, alpha: 1)
    }
}
#endif

let color1 = UIColor.lime
let color2 = UIColor.lime

print(color1 == color2)
XCTAssertEqual(color1, color2)

//: [Next](@next)
