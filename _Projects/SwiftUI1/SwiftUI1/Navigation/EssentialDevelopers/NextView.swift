import SwiftUI

public class NextViewModel<T>: ObservableObject {
    @Published fileprivate var isPresented = false
    var presentedObject: T?
    
    public func present() {
        isPresented = true
    }
    
    public func dismiss() {
        isPresented = false
        presentedObject = nil
    }
}

public struct NextView<T, Content: View>: View {
    @ObservedObject private var model: NextViewModel<T>
    private let content: () -> Content
    
    public init(model: NextViewModel<T>, content: @escaping () -> Content) {
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
