//
//  OptionalAlertAndSheetView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 15/05/2023.
//

import SwiftUI

struct OptionalUser: Identifiable {
    var id = "Taylor Swift"
}

struct OptionalAlertAndSheetView: View {
    @State private var selectedUser: OptionalUser? = nil
    @State private var isShowUser = false
    var body: some View {
        VStack {
            Spacer()
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .onTapGesture {
                    selectedUser = OptionalUser()
                }
                .sheet(item: $selectedUser) { user in
                    Text(user.id)
                }
            Spacer()
            Text("Alert User")
                .onTapGesture {
                    selectedUser = OptionalUser()
                    isShowUser = true
                }
                .alert("Show User", isPresented: $isShowUser, presenting: selectedUser) { user in
                    Button(user.id) {}
                }
            Spacer()
        }
    }
}

struct OptionalAlertAndSheetView_Previews: PreviewProvider {
    static var previews: some View {
        OptionalAlertAndSheetView()
    }
}
