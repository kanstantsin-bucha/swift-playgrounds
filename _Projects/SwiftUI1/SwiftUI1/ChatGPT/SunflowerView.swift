import SwiftUI

struct SunflowerPatternView: View {
    let circleCount: Int = 200
    let circleSize: CGFloat = 30
    let maxRadius: CGFloat = 200
    @State private var multiplier: CGFloat = 0.2

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                ForEach(0..<circleCount) { index in
                    Circle()
                        .fill(getRainbowColor(index: index))
                        .frame(width: getCircleSize(index: index), height: getCircleSize(index: index))
                        .position(getCirclePosition(index: index, geometry: geometry))
                        .opacity(getCircleOpacity(index: index, geometry: geometry))
                }
            }
        }
        .onTapGesture {
            animate(inTime: 5, outTime: 3)
        }
    }
    
    private func animate(inTime: Int, outTime: Int) {
        withAnimation(Animation.spring(duration: Double(inTime))) {
            multiplier += 1.5
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(inTime)) {
            withAnimation(Animation.spring(duration: Double(outTime))) {
                multiplier -= 1.5
            }
        }
    }
    
    private func getRainbowColor(index: Int) -> Color {
        let hue = Double(index) / Double(circleCount)
        return Color(hue: hue, saturation: 1, brightness: 1)
    }
    
    private func getCircleSize(index: Int) -> CGFloat {
        let scaleFactor = CGFloat(index) / CGFloat(circleCount) + 1
        let adjustedSize = circleSize / scaleFactor
        return adjustedSize
    }
    
    private func getCirclePosition(index: Int, geometry: GeometryProxy) -> CGPoint {
        let radius = CGFloat(index) * maxRadius / CGFloat(circleCount)
        - CGFloat(circleCount - index) * multiplier
        let angle = CGFloat(index) * 137.5

        let centerX = geometry.size.width / 2
        let centerY = geometry.size.height / 2

        let x = centerX + (radius * cos(angle))
        let y = centerY + (radius * sin(angle))

        return CGPoint(x: x, y: y)
    }
    
    private func getCircleOpacity(index: Int, geometry: GeometryProxy) -> Double {
        let radius = CGFloat(index) * maxRadius / CGFloat(circleCount)
        let centerRadius = maxRadius / 2
        
        if radius < centerRadius {
            let opacity = Double(1 - (radius / centerRadius))
            return opacity
        } else {
            return 1.0
        }
    }
}

struct SunflowerPatternView_Previews: PreviewProvider {
    static var previews: some View {
        SunflowerPatternView()
    }
}
