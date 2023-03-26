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
            Print("Start registration \(registrationAction)")
            registrationAction.map { action in
                Button("Start registration") { action() }
            }
        }
    }
}

struct DoorsTab: View {
    var body: some View {
        Text("DoorsTab")
    }
}

struct SitesTab: View {
    var body: some View {
        Text("SitesTab")
    }
}
