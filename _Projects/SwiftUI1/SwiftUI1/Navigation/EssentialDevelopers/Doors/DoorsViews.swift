import SwiftUI

struct DoorsTab: View {
    private let action: () -> Void
    private let actionTitle: String
    
    init(actionTitle: String, action: @escaping () -> Void) {
        self.actionTitle = actionTitle
        self.action = action
    }
    
    var body: some View {
        Text("DoorsTab")
            .padding()
        Button(actionTitle) { action() }
            .padding()
    }
}

enum KitchenType: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case white
    case black
    case red
}

struct CabinetDoorsView: View {
    private let action: (KitchenType) -> Void
    
    init(action: @escaping (KitchenType) -> Void) {
        self.action = action
    }
    
    var body: some View {
        Text("Hello, in the cabinet!")
        ForEach(KitchenType.allCases) { type in
            Button("Present \(type.rawValue) kitchen") { action(type) }
                .padding()
        }
    }
}

struct KitchenDoorsView: View {
    private let action: () -> Void
    private let type: KitchenType
    
    init(type: KitchenType, action: @escaping () -> Void) {
        self.type = type
        self.action = action
    }
    
    var body: some View {
        Text("Hello in the \(type.rawValue) kitchen!")
        Button("Close all") { action() }
            .padding()
    }
}

struct DoorsViews_Previews: PreviewProvider {
    static var previews: some View {
        CabinetDoorsView(action: { _ in })
        KitchenDoorsView(type: .white, action: {})
    }
}
