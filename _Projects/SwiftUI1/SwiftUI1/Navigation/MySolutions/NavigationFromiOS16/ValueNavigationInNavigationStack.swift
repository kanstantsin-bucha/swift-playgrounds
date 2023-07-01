import SwiftUI

protocol CommonNavigation {
    associatedtype Navigation: View
    associatedtype Content: View
    func navigate()
    func navigationView(content: () -> Content) -> Navigation
}

@available(iOS, obsoleted: 16)
struct Navigation15<Content: View>: View, CommonNavigation {
    typealias Navigation = NavigationView<Content>
    
    func navigationView(content: () -> Content) -> Navigation {
        NavigationView(content: content)
    }
    
    func navigate() {
        
    }
    
    var body: some View {
        Text("")
    }
}

struct OtherRoot: View {
    var body: some View {
        if #available(iOS 16, *) {
            Other(navigator: Navigation16<AnyView>())
        } else {
            Other(navigator: Navigation15<AnyView>())
        }
    }
}

struct Other<Navigation: CommonNavigation>: View {
    private let navigator: Navigation
    
    public init(navigator: Navigation) {
        self.navigator = navigator
    }
    
    var body: some View {
        let content: () -> Navigation.Content = {
            AnyView (
                VStack {
                    Text("It works!")
                    Image(systemName: "user")
                }
            ) as! Navigation.Content
        }
        navigator.navigationView(content: content)
    }
}

struct OtherPreview: PreviewProvider {
    static var previews: some View {
        Other(navigator: Navigation15<AnyView>())
    }
}


@available(iOS 16, *)
final class NavigationHolder16: ObservableObject {
    @Published var navigationPath = NavigationPath()
}



@available(iOS 16, *)
final class Navigation16<Content: View>: CommonNavigation, ObservableObject {
    typealias Navigation = NavigationStack<NavigationPath, Content>
    
    @ObservedObject var holder = NavigationHolder16()
    
    func navigationView(content: () -> Content) -> Navigation {
        NavigationStack(path: $holder.navigationPath, root: content)
    }
    
    func navigate() {
       
    }
}

@available(iOS 16, *)
struct ValueNavigationInNavigationStack16: View {
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
