import SwiftUI

struct CardView: View {
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            LinearGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(width: 360, height: 240)
            .cornerRadius(30)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color.white.opacity(0.5), location: 0),
                                .init(color: Color.clear, location: 0.4),
                                .init(color: Color.white.opacity(0.5), location: 0.6)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 2
                    )
            )
            .overlay(
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
                    .padding(30)
            )
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
