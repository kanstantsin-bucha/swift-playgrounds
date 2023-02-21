//
//  ConformanceToComparableView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 21/02/2023.
//

import SwiftUI

struct SecondUser: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func < (lhs: SecondUser, rhs: SecondUser) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct ConformanceToComparableView: View {
    let users: [SecondUser] = [
        .init(firstName: "Arnold", lastName: "Rimmer"),
        .init(firstName: "Kristine", lastName: "Kochanski"),
        .init(firstName: "David", lastName: "Lister")
    ].sorted()
    
    var body: some View {
        List(users) { user in
            Text("\(user.firstName) \(user.lastName)")
        }
    }
}

struct ConformanceToComparableView_Previews: PreviewProvider {
    static var previews: some View {
        ConformanceToComparableView()
    }
}
