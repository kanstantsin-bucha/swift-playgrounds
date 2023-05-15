//
//  TwoSidesSwiftUIView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 15/05/2023.
//

import SwiftUI

struct TwoSidesSwiftUIView: View {
    var body: some View {
        NavigationView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .navigationTitle("Primary")
            Text("Secondary")
        }
    }
}

struct TwoSidesSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TwoSidesSwiftUIView()
    }
}
