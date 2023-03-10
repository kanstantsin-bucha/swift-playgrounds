//
//   SwipeActionsView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 10/03/2023.
//

import SwiftUI

struct SwipeActionsView: View {
    var body: some View {
        List {
            Text("Swipe Action!")
                .swipeActions {
                    Button(role: .destructive) {
                        print("Delete Row")
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button {
                        print("Pin")
                    } label: {
                        Label("Pin", systemImage: "pin")
                    }
                    .tint(.orange)
                    
                    Button {
                        print("Message")
                    } label: {
                        Label("Message", systemImage: "message")
                    }
                    .tint(.green)
                }
        }
    }
}

struct SwipeActionsView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeActionsView()
    }
}
