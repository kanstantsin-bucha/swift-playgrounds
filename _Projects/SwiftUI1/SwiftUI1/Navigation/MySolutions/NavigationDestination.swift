import SwiftUI

typealias DestinationFactory = () -> NavigationDestination

struct NavigationDestination: Hashable {
    static func == (lhs: NavigationDestination, rhs: NavigationDestination) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    let id: String
    let viewFactory: () -> AnyView
    
    public init(id: String, viewFactory: @escaping () -> AnyView) {
        self.id = id
        self.viewFactory = viewFactory
    }
}
