//
//  GroupTransparentLayoutView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 15/05/2023.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        Group {
            Text("Text 1")
            Text("Text 2")
            Text("Text 3")
        }
    }
}

struct GroupTransparentLayoutView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var isLayoutVertically = false
    var body: some View {
        VStack {
            Spacer()
            Group {
                if isLayoutVertically {
                    VStack { UserView() }
                } else {
                    HStack { UserView() }
                }
            }
            .onTapGesture {
                isLayoutVertically.toggle()
            }
            Spacer()
            if sizeClass == .compact {
                VStack(content: UserView.init)
            } else {
                HStack(content: UserView.init)
            }
            Spacer()
        }
    }
}

struct GroupTransparentLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        GroupTransparentLayoutView()
    }
}
