import Foundation

class MainViewModel: ObservableObject {
    @Published var selected: Tab = .keys
    enum Tab: Int, CaseIterable, Identifiable, Hashable {
        case keys
        case doors
        case user
        case sites
        
        var id: Int {
            self.rawValue
        }
    }
}

class SheetViewModel: ObservableObject {
    @Published var isPresented = false
}

class RegistrationViewModel: ObservableObject {
    @Published var isRegistered = false
}
