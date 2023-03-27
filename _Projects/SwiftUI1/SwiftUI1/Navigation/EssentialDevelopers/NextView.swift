import SwiftUI

public struct NextView<Content: View>: View {
    // Let's check if binding works here ?
    private let isPresented: Binding<Bool>
    private let content: () -> Content
    
    public init(isPresented: Binding<Bool>, content: @escaping () -> Content) {
        self.isPresented = isPresented
        self.content = content
    }
    
    public var body: some View {
        let _ = Self._printChanges()
        Print("redraw \(isPresented.wrappedValue)")
        NavigationLink(
            isActive: isPresented,
            destination: content,
            label: EmptyView.init
        )
    }
}
