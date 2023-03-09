//
//  EnvironmentObjectView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 09/03/2023.
//

import SwiftUI

@MainActor class User2: ObservableObject {
    @Published var name = "Alex Bucha"
}

struct EditView1: View {
    @EnvironmentObject var user: User2
    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DetailView1: View {
    @EnvironmentObject var user: User2
    var body: some View {
        Text(user.name)
    }
}

struct EnvironmentObjectView: View {
    @StateObject var user = User2()
    var body: some View {
        VStack {
            EditView1()
            DetailView1()
        }
        .environmentObject(user)
    }
}

struct EnvironmentObjectView_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentObjectView()
    }
}
