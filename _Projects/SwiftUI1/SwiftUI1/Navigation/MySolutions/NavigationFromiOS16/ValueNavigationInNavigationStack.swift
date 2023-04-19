import SwiftUI



@available(iOS 16, *)
struct ValueNavigationInNavigationStack: View {
    private static let linkFactory: DestinationFactory = {
        NavigationDestination(
            id: "Screen 3",
            viewFactory: { AnyView(Text("++3"))}
        )
    }
    private let dest1 = NavigationDestination(
        id: "Screen 1",
        viewFactory: { AnyView(Text("Screen 1")) }
    )
    private let dest2 = NavigationDestination(
        id: "Screen 2",
        viewFactory: {
            AnyView(
                HStack {
                    Text("Screen 2")
                    NavigationLink(value: Self.linkFactory()) {
                        Text("Screen 3")
                    }
                }
            )
        })
    
    var body: some View {
        RootView(destinations: [dest1, dest2])
    }
    
    // Root View of the app
    struct RootView: View {
        let destinations: [NavigationDestination]
        
        var body: some View {
            let _ = Self._printChanges()
            NavigationStack {
                List(destinations, id: \.self) { nd in
                    NavigationLink(value: nd) {
                        Text(nd.id)
                    }
                }
                .navigationDestination(for: NavigationDestination.self) { nd in
                    Print("\(nd.id)")
                    nd.viewFactory()
                }
                .listStyle(.plain)
                .navigationTitle("Value Links")
            }
        }
    }
}
