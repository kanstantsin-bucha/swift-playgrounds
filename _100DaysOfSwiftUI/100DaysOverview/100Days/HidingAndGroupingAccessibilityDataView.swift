//
//  Hiding and grouping accessibilityDataView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 01/03/2023.
//

import SwiftUI

struct HidingAndGroupingAccessibilityDataView: View {
    var body: some View {
        
        //            VStack {
        //                Image(decorative: "Anime")
        //                    .resizable()
        //                    .scaledToFit()
        //                    .accessibilityHidden(true)
        //            }
        
        VStack {
            Text("Your score")
            Text("1000")
        }
        .accessibilityElement(children: .combine)
    }
}

struct HidingAndGroupingAccessibilityDataView_Previews: PreviewProvider {
    static var previews: some View {
        HidingAndGroupingAccessibilityDataView()
    }
}
