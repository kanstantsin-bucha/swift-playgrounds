import SwiftUI

public class NextViewModel: ObservableObject {
    @Published var isActive = false
    
    public func activate() {
        isActive = true
    }
}

public struct NextView<Content: View>: View {
    // Let's check if binding works here ?
    @ObservedObject private var model: NextViewModel
    let content: () -> Content
    
    public init(model: NextViewModel, content: @escaping () -> Content) {
        self.model = model
        self.content = content
    }
    
    public var body: some View {
        NavigationLink(
            isActive: $model.isActive,
            destination: content,
            label: EmptyView.init
        )
    }
}
