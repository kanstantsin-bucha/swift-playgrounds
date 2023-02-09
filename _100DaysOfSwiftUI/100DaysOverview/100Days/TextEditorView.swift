//
//  TextEditorView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 09/02/2023.
//

import SwiftUI

struct TextEditorView: View {
    @AppStorage("notes") private var notes = ""
    var body: some View {
        NavigationView {
            TextEditor(text: $notes)
                .navigationTitle("Notes")
                .padding()
        }
    }
}

struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView()
    }
}
