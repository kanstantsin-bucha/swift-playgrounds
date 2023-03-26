import SwiftUI

struct RegistrationView: View {
    let registrationAction: () -> Void
    
    var body: some View {
        VStack {
            Text("To make registration tap the button")
            Button("Register") {
                registrationAction()
            }
        }
    }
}
