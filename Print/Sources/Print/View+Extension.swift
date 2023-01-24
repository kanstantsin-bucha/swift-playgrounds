//
//  View+Extension.swift
//  PlaygroundsWrapper
//
//  Created by Kanstantsin Bucha on 02/04/2022.
//

import Foundation
import SwiftUI

public extension View {
    func PrintIt(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}
