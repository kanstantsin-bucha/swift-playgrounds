import SwiftUI

struct CardView: View {
    @State private var cardPosition: CGSize = .zero
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            allViews
        }
    }
    
    var allViews: some View {
        ZStack {
            cardView
                .offset(cardPosition)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            cardPosition = gesture.translation
                        }
                        .onEnded { gesture in
                            withAnimation(.spring()) {
                                cardPosition = .zero
                            }
                        }
                )
            ParticleView(viewSize: .init(width: 440, height: 340))
                .frame(width: 440, height: 340)
                .cornerRadius(30)
                .offset(cardPosition)
                .allowsHitTesting(false)
            ParticleView(viewSize: .init(width: 360, height: 240))
                .frame(width: 360, height: 240)
                .cornerRadius(30)
                .offset(cardPosition)
                .allowsHitTesting(false)
                .blendMode(.colorDodge)
        }
        .rotation3DEffect(
            Angle(degrees: cardPosition != .zero ? 15 : 0),
            axis: (x: -cardPosition.height, y: cardPosition.width, z: 0.0)
        )
    }
    
    var cardBorderGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(stops: [
                .init(color: Color.white.opacity(0.5), location: 0),
                .init(color: Color.clear, location: 0.4),
                .init(color: Color.white.opacity(0.5), location: 0.6)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    var cardBackgroundGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    var cardDetailsView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Debit card")
                .font(.headline)
                .foregroundColor(.white)
            
            Text("**** 0941")
                .font(.body)
                .foregroundColor(.white)
            
            Spacer()
            
            HStack {
                Text("Valid Thru 06/05")
                    .font(.caption)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "applelogo")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
    }
    
    var cardView: some View {
         cardBackgroundGradient
        .frame(width: 360, height: 240)
        .cornerRadius(30)
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(cardBorderGradient, lineWidth: 3)
        )
        .shadow(
            color: Color(hex:"#5D11F7").opacity(0.8),
            radius: 120,
            x: 0,
            y: 0
        )
        .overlay(
            cardDetailsView
                .padding(30)
        )
    }
}

import SwiftUI

struct ParticleView: UIViewRepresentable {
    let viewSize: CGSize
    
    func makeUIView(context: Context) -> UIView {
        let particleCell = CAEmitterCell()
        particleCell.contents = createParticleImage(color: .white)?.cgImage
        particleCell.scale = 0.1
        particleCell.scaleRange = 0.3
        particleCell.birthRate = 200 // Increase the birthRate for more particles
        particleCell.lifetime = 3.5
        particleCell.velocity = 10
        particleCell.velocityRange = 5
        particleCell.emissionLongitude = .pi
        particleCell.emissionLatitude = -.pi / 2
        particleCell.emissionRange = .pi
        particleCell.alphaRange = 0 // Change alpha range for varying transparency
        particleCell.alphaSpeed = -0.4
        
        let particleCell2 = CAEmitterCell()
        particleCell2.contents = createParticleImage(color: .white)?.cgImage
        particleCell2.scale = 0.1
        particleCell2.scaleRange = 0.35
        particleCell2.birthRate = 50 // Increase the birthRate for more particles
        particleCell2.lifetime = 5.5
        particleCell2.velocity = 60
        particleCell2.velocityRange = 30
        particleCell2.emissionLongitude = .pi
        particleCell2.emissionLatitude = -.pi / 2
        particleCell2.emissionRange = .pi
        particleCell2.alphaRange = 0 // Change alpha range for varying transparency
        particleCell2.alphaSpeed = -0.1
        
        let particleLayer = particleLayer()
        particleLayer.emitterCells = [particleCell, particleCell2]
        let particleView = UIView()
        particleView.layer.addSublayer(particleLayer)
        return particleView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // No updates needed
    }
    
    private func particleLayer() -> CAEmitterLayer {
        let particleLayer = CAEmitterLayer()
        particleLayer.emitterPosition = CGPoint(
            x: viewSize.width / 2,
            y: viewSize.height / 2
        )
        particleLayer.emitterShape = .cuboid
        particleLayer.emitterSize = CGSize(width: viewSize.width, height: viewSize.height)
        particleLayer.renderMode = .oldestLast
        return particleLayer
    }
    
    private func createParticleImage(color: UIColor) -> UIImage? {
        let particleSize: CGFloat = 6.0
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: particleSize, height: particleSize))
        
        let image = renderer.image { context in
            color.withAlphaComponent(0.8).setFill()
            let rect = CGRect(x: 0, y: 0, width: particleSize, height: particleSize)
            context.cgContext.fillEllipse(in: rect)
        }
        
        return image
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var rgbValue: UInt64 = 0
        
        guard Scanner(string: hex).scanHexInt64(&rgbValue) else {
            self = .white
            return
        }
        
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
