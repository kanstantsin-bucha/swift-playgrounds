//
//  NavigationLinkView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 30/01/2023.
//

import SwiftUI

struct NavigationLinkView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                NavigationLink {
                    Text("NavigationLink Sheet")
                } label: {
                    Text("Hello,I'm NavigationLink!")
                    // foregroundColor from default is blue
                        .foregroundColor(.red)
                }
                Spacer()
                List(0..<25) { row in
                    NavigationLink {
                        Text("Row \(row)")
                    } label: {
                        Text("Hello,I'm  NavigationLink! Row \(row) ")
                            .foregroundColor(.green)
                    }
                }
                Spacer()
            }
            .navigationTitle("NavigationLink")
        }
        
    }
}

struct NavigationLinkView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationLinkView()
    }
}
