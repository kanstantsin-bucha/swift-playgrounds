import SwiftUI

struct NavigationDestination: Hashable {
    static func == (lhs: NavigationDestination, rhs: NavigationDestination) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    let id = UUID()
    let viewFactory: () -> AnyView
}

typealias MyValue = () -> NavigationDestination
let linkFactory: MyValue = {
    NavigationDestination(viewFactory: { AnyView(Text("++3"))})
}

@available(iOS 16, *)
struct ValueNavigationInNavigationStack: View {
    private var nds: [NavigationDestination] = [
        NavigationDestination(viewFactory: { AnyView(Text("Screen 1")) } ),
        NavigationDestination(viewFactory: { AnyView(
            HStack {
                Text("Screen 2")
                let nd = linkFactory()
                NavigationLink(value: nd) {
                    Text(nd.id.uuidString)
                }
            }
        )
            
        })
    ]
    var body: some View {
        NavigationStack {
            List(nds, id: \.self) { nd in
                NavigationLink(value: nd) {
                    Text(nd.id.uuidString)
                }
            }
            .navigationDestination(for: NavigationDestination.self) { nd in
                nd.viewFactory()
            }
            .listStyle(.plain)
            .navigationTitle("Value Links")
        }
    }
}
