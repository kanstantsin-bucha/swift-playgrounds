//
//  DragView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 25/01/2023.
//

import SwiftUI

struct DragView: View {
    let letters = Array("Animation SwiftUI")
    
    @State private var isEnable = false
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { num in Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(isEnable ? .blue : .red)
                    .offset(dragAmount)
                    .animation(.default.delay(Double(num) / 20), value: dragAmount)
                
            }
        }
        .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation }
                .onEnded{ _ in
                    dragAmount = .zero
                    isEnable.toggle()
                }
        )
    }
}

struct DragView_Previews: PreviewProvider {
    static var previews: some View {
        DragView()
    }
}
