//
//  SearchableView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 15/05/2023.
//

import SwiftUI

struct SearchableView: View {
    @State private var searchText = ""
    let allNames = ["Dima","Ola","Sasha","Oleg","Dana","Sveta",]
    var body: some View {
        NavigationView {
            List(filteredName, id: \.self) { name in
                Text(name)
            }
            .searchable(text: $searchText, prompt: "Look for something")
            .navigationTitle("Searching")
        }
    }
    var filteredName: [String] {
        if searchText.isEmpty {
            return allNames
        } else {
            return allNames.filter { $0.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

struct SearchableView_Previews: PreviewProvider {
    static var previews: some View {
        SearchableView()
    }
}
