//
//  InsettableShapeView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 01/02/2023.
//

import SwiftUI

struct Arc2: InsettableShape {
    let startAngle: Angle
    let endAngle: Angle
    let isClockwise: Bool
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: isClockwise)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct InsettableShapeView: View {
    var body: some View {
        VStack {
            Arc2(startAngle: Angle(degrees: 5.0), endAngle: Angle(degrees: -5.0), isClockwise: true)
                .strokeBorder(.red,lineWidth: 50)
            
            Arc2(startAngle: Angle(degrees: -90.0), endAngle: Angle(degrees: 90.0), isClockwise: true)
                .strokeBorder(.green,lineWidth: 50)
        }
    }
}

struct InsettableShapeView_Previews: PreviewProvider {
    static var previews: some View {
        InsettableShapeView()
    }
}
