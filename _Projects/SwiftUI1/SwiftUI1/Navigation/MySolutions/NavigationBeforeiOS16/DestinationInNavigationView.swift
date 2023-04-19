import SwiftUI

// Mimics the composition root
struct DestinationInNavigationView: View {
    private static let linkFactory: DestinationFactory = {
        NavigationDestination(id: "Screen 3", viewFactory: { AnyView(Text("++3"))})
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
                    Print("\(2)")
                    Text("Screen 2")
                    let dest3 = Self.linkFactory()
                    NavigationLink(destination: dest3.viewFactory) {
                        Text(dest3.id)
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
            NavigationView {
                List(destinations, id: \.self) { nd in
                    NavigationLink(destination: nd.viewFactory) {
                        Text(nd.id)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Value Links")
            }
        }
    }
}


