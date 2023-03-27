import SwiftUI

struct DoorsTab: View {
    private let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Text("DoorsTab")
            .padding()
        Button("Present Cabinet") { action() }
            .padding()
    }
}

struct CabinetDoorsView: View {
    private let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Text("Hello, Cabinet!")
        Button("Present kitchen") { action() }
    }
}

struct KitchenDoorsView: View {
    private let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Text("Hello, Kitchen!")
        Button("Close all") { action() }
    }
}

struct DoorsViews_Previews: PreviewProvider {
    static var previews: some View {
        CabinetDoorsView(action: {})
        KitchenDoorsView(action: {})
    }
}
