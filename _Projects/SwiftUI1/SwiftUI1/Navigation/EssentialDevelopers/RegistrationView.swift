import SwiftUI

struct RegistrationView: View {
    @ObservedObject var registration: RegistrationViewModel
    
    var body: some View {
        VStack {
            Text("To make registration tap the button")
            Button("Register") {
                registration.isRegistered.toggle()
            }
        }
    }
}
