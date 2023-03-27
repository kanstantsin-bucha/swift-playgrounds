import SwiftUI

struct KeysTab: View {
    var body: some View {
        Text("KeysTab")
    }
}

struct UserTab: View {
    let registrationAction: (() -> Void)?
    
    var body: some View {
        VStack {
            Text("UserTab")
            Print("Start registration \(String(describing: registrationAction))")
            registrationAction.map { action in
                Button("Start registration") { action() }
            }
        }
    }
}

struct SitesTab: View {
    var body: some View {
        Text("SitesTab")
    }
}
