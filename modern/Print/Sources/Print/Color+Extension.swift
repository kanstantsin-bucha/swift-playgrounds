//
//  File.swift
//  
//
//  Created by Kanstantsin Bucha on 24/09/2022.
//

#if os(iOS) || targetEnvironment(simulator)
import UIKit
// copy Print_Print.bundle into modernPlay-gowtdfwgtfvjqvghlycesbwmuamt/Build/Intermediates.noindex/Playgrounds/Products/Debug-iphonesimulator/PackageFrameworks/Print.framework
public extension UIColor {
    private static var packageBundle: Bundle {
        Bundle.module
    }
    
    static var lime: UIColor {
        UIColor(named: "Lime", in: packageBundle, compatibleWith: nil)!
    }
}
#endif
