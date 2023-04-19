import SwiftUI

public class NextViewModel: ObservableObject {
    @Published fileprivate var isPresented = false
    
    public func present() {
        isPresented = true
    }
    
    public func dismiss() {
        isPresented = false
    }
}

public struct NextView<Content: View>: View {
    @ObservedObject private var model: NextViewModel
    private let content: () -> Content
    
    public init(model: NextViewModel, content: @escaping () -> Content) {
        self.model = model
        self.content = content
    }
    
    public var body: some View {
        let _ = Self._printChanges()
        Print("Redraw next \(model.isPresented)")
        NavigationLink(
            isActive: $model.isPresented,
            destination: content,
            label: EmptyView.init
        )
    }
}
