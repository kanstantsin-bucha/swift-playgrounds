//
//  DrawingShapeView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 01/02/2023.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}

struct Arc: Shape {
    let startAngle: Angle
    let endAngle: Angle
    let isClockwise: Bool
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: 150, startAngle: startAngle, endAngle: endAngle, clockwise: isClockwise)
        
        return path
    }
}

struct DrawingShapeView: View {
    var body: some View {
        VStack {
            Triangle()
                .stroke(.green, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .frame(width: 300, height: 300)
            
            Spacer()
            Arc(startAngle: Angle(degrees: 30.0), endAngle: Angle(degrees: 60.0), isClockwise: true)
                .stroke(.red,lineWidth: 10)
                .frame(width: 300, height: 300)
        }
    }
}

struct DrawingShapeView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingShapeView()
    }
}
