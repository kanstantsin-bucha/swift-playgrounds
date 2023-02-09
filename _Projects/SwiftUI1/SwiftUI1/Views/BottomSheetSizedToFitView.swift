//
//  BottomSheetSizedToFitView.swift
//  SwiftUI1
//
//  Created by Kanstantsin Bucha on 05/02/2023.
//

import SwiftUI

struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat?
    
    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        guard let nextValue = nextValue() else { return }
        value = nextValue
    }
}

private struct ReadHeightModifier: ViewModifier {
    private var sizeView: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: HeightPreferenceKey.self, value: geometry.size.height)
        }
    }
    
    func body(content: Content) -> some View {
        content.background(sizeView)
    }
}

extension View {
    func readHeight() -> some View {
        self
            .modifier(ReadHeightModifier())
    }
}

struct BottomSheetSizedToFitView: View {
    @State var presentSheet: Bool = false
    @State var detentHeight: CGFloat = 0
    
    var body: some View {
        Button("Tap me") {
            self.presentSheet.toggle()
        }
        .sheet(isPresented: self.$presentSheet) {
            if #available(iOS 16.0, *) {
                BottomView()
                    .readHeight()
                    .onPreferenceChange(HeightPreferenceKey.self) { height in
                        height.map {
                            self.detentHeight = $0
                            print($0)
                        }
                    }
                    .presentationDetents([.height(self.detentHeight)])
                    .presentationDragIndicator(.visible)
            } else {
                Button("iOS 16 only") {}
            }
        }
    }
}

struct BottomView: View {
    var body: some View {
        VStack {
            Text("Hello")
            Text("World")
        }
        .padding(.top)
    }
}

struct BottomSheetSizedToFitView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSizedView()
        //            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
    }
}
