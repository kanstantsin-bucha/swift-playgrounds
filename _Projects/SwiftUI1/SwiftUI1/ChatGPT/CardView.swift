import SwiftUI

struct CardView: View {
    @State private var cardPosition: CGSize = .zero
    @State var isDragging: Bool = false // { cardPosition != .zero }
    
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
                            isDragging = true
                            cardPosition = gesture.translation
                        }
                        .onEnded { gesture in
                            withAnimation(.spring()) {
                                cardPosition = .zero
                                isDragging = false
                            }
                        }
                )
            ParticleView(
                viewSize: .init(width: 440, height: 340),
                isDragging: isDragging
            )
                .frame(width: 440, height: 340)
                .cornerRadius(30)
                .offset(cardPosition)
                .allowsHitTesting(false)
            ParticleView(
                viewSize: .init(width: 360, height: 240),
                isDragging: isDragging
            )
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
    
    var cardGradientsOverlay: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .stroke(
                    .linearGradient(
                        colors: [.white.opacity(0.6), .clear, .white.opacity(0.3)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            RoundedRectangle(cornerRadius: 30)
                .stroke(
                    .linearGradient(
                        colors: [.white.opacity(0.4), .clear, .white.opacity(0.3)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 20
                )
                .blur(radius: 30)
            RoundedRectangle(cornerRadius: 30)
                .stroke(
                    .linearGradient(
                        colors: [Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)).opacity(1), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)).opacity(0.6), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)).opacity(1)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 20
                )
                .blur(radius: 50)
                .opacity(isDragging ? 1 : 0)
            RoundedRectangle(cornerRadius: 30)
                .fill(
                    .linearGradient(
                        colors: [Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .blendMode(.overlay)
        }
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
        .overlay(cardGradientsOverlay)
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
    final class Storage: ObservableObject {
        var layer: CAEmitterLayer?
    }
    
    let viewSize: CGSize
    let isDragging: Bool
    @StateObject var storage = Storage()
    
    init(viewSize: CGSize, isDragging: Bool) {
        self.viewSize = viewSize
        self.isDragging = isDragging
    }
    
    func makeUIView(context: Context) -> UIView {
        print("make view")
        let particleCell = CAEmitterCell()
        particleCell.contents = createParticleImage(color: .white)?.cgImage
        particleCell.scale = 0.1
        particleCell.scaleRange = 0.3
        particleCell.birthRate = 200
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
        particleCell2.birthRate = 50
        particleCell2.lifetime = 5.5
        particleCell2.velocity = 60
        particleCell2.velocityRange = 30
        particleCell2.emissionLongitude = .pi
        particleCell2.emissionLatitude = -.pi / 2
        particleCell2.emissionRange = .pi
        particleCell2.alphaRange = 0 // Change alpha range for varying transparency
        particleCell2.alphaSpeed = -0.1
        
        let particleLayer = particleLayer()
        storage.layer = particleLayer
        particleLayer.emitterCells = [particleCell, particleCell2]
        let particleView = UIView()
        particleView.layer.addSublayer(particleLayer)
        return particleView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        print("isDragging: \(isDragging)")
        
        storage.layer?.velocity = isDragging ? 3 : 1
        storage.layer?.birthRate = isDragging ? 5 : 1
        print("layer: \(String(describing: storage.layer?.velocity))")
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
