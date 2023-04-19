//
//  SwiftPackageView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 10/03/2023.
//

import SwiftUI

//This example without Package
//Show only conversion [Int] to String
struct SwiftPackageView: View {
    let numbers = Array(1...10)
    var body: some View {
        Text(results)
    }
    
    var results: String {
        return numbers.map(String.init).joined(separator: ",")
    }
}

struct SwiftPackageView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftPackageView()
    }
}
