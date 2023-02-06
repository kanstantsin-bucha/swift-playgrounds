//
//   BindingView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 20/01/2023.
//

import SwiftUI

struct _BindingView: View {
    @State private var selection = 0

        var body: some View {
            let binding = Binding(
                get: { selection },
                set: { selection = $0 }
            )

            return VStack {
                Picker("Select a number", selection: binding) {
                    ForEach(0..<3) {
                        Text("Item \($0)")
                    }
                }
                .pickerStyle(.segmented)
            }
        }
}

struct _BindingView_Previews: PreviewProvider {
    static var previews: some View {
        _BindingView()
    }
}
