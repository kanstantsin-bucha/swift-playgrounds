//
//   HierarchicalCodableDataView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 30/01/2023.
//

import SwiftUI

struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

struct HierarchicalCodableDataView: View {
    var body: some View {
        Button("Decode JSON") {
            let input = """
            {
                "name": "Json",
                "address": {
                "street": "555, JsonStreet",
                    "city": "Dresden"
                }
            }
            """
            let data = Data(input.utf8)
            do {
                 let user = try JSONDecoder().decode(User.self, from: data)
                print(user.address.city)
            } catch {
                print(error)
            }
            
        }
    }
}

struct _HierarchicalCodableDataView_Previews: PreviewProvider {
    static var previews: some View {
        HierarchicalCodableDataView()
    }
}
