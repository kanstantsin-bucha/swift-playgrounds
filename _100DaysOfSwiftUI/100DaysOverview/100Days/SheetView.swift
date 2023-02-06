//
//  SheetView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 27/01/2023.
//

import SwiftUI

struct SecondSheetView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button ("Dismiss, SecondSheetView!") {
            dismiss()
        }
    }
}

struct SheetView: View {
    @State private var isShowSheet = false
    var body: some View {
        Button("Show, SecondSheetView!") {
            isShowSheet.toggle()
        }
        .sheet(isPresented: $isShowSheet) {
            SecondSheetView()
        }
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView()
    }
}
