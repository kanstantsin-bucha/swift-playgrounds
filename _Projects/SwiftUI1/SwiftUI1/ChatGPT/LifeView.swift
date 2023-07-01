import SwiftUI



struct LifeView: View {
    final class State: ObservableObject {
        @Published var isAnimating = false
        var radiusSeed: CGFloat = 20
        private var increment: CGFloat = -1
        private var timer: Timer?
        
        func toggleAnimation() {
            isAnimating.toggle()
            timer?.invalidate()
            if isAnimating {
                timer = Timer.scheduledTimer(
                    withTimeInterval: 1,
                    repeats: true,
                    block: { [weak self] _ in
                        guard let self else { return }
                        if Int(radiusSeed).isMultiple(of: 5) {
                            objectWillChange.send()
                        }
                        if Int(radiusSeed).isMultiple(of: 10), Int.random(in: 0..<11) > 7 {
                            isAnimating = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int.random(in: 0..<4))) { [weak self] in
                                self?.isAnimating = true
                            }
                            
                        }
                        if self.radiusSeed < 10 {
                            self.increment = +1
                        }
                        if self.radiusSeed > 20 {
                            self.increment = -1
                        }
                        self.radiusSeed += increment
                    })
            }
        }
    }
    
    @StateObject var state = State()

    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                ForEach(0..<75) { index in
                    let diameter = CGFloat(5 + Int.random(in: 0..<43))
                    let animationOffset = animationOffset(at: index)
                    let opacity: Double = Double(1) - Double(animationOffset.width + animationOffset.height) / 800 - Double(diameter) / 75
                    Circle()
                        .fill(circleColor(at: index).opacity(opacity))
                        .frame(width: diameter, height: diameter)
                        .offset(animationOffset)
                        .rotationEffect(state.isAnimating ? .degrees(360) : .degrees(125))
                        .animation(
                            Animation.easeInOut(duration: 3)
                                .repeatForever()
                                .delay(Double(index) / 10)
                        )
                }
            }
        }
        .onAppear {
            state.toggleAnimation()
        }
    }

    private func circleColor(at index: Int) -> Color {
        let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]
        return colors[index % colors.count]
    }

    private func animationOffset(at index: Int) -> CGSize {
        let randomSeed = CGFloat(Int.random(in: 5..<17))
        let radius: CGFloat = state.isAnimating ? CGFloat(randomSeed * state.radiusSeed) : 0
        let angle = 2 * CGFloat.pi / 7 * CGFloat(index)
        let x = (radius + randomSeed) * cos(angle)
        let y = (radius - randomSeed) * sin(angle)
        return CGSize(width: x, height: y)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LifeView()
    }
}
