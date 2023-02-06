//
//  TrapezoidView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 02/02/2023.
//

import SwiftUI

struct Trapezoid: Shape {
    var insetAmount = 0.0
    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0.0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        
        return path
    }
}

struct TrapezoidView: View {
    @State private var insetAmount = 50.0
    var body: some View {
        Trapezoid(insetAmount: insetAmount)
            .fill(ImagePaint(image: Image("Image")))
            .frame(width: 300,height: 200)
            .onTapGesture {
                withAnimation {
                    insetAmount = Double(.random(in: 0...90))
                }
            }
    }
}

struct TrapezoidView_Previews: PreviewProvider {
    static var previews: some View {
        TrapezoidView()
    }
}
