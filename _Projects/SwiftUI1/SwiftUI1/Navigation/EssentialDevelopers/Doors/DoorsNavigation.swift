import SwiftUI

class DoorsNavigationModel: ObservableObject {
    @Published var isCabinetPresented = false
    @Published var isKitchenPresented = false
}

enum DoorsViewFactory {
    static func doorsTabView(navigation: ObservedObject<DoorsNavigationModel>.Wrapper) -> some View {
        let nextView = NextView(
            isPresented: navigation.isCabinetPresented,
            content: { DoorsViewFactory.cabinetView(navigation: navigation) }
        )
        return NavigationView {
            VStack {
                DoorsTab(action: {
                    navigation.isCabinetPresented.wrappedValue = true
                })
                nextView
            }
        }
    }
    
    static func cabinetView(navigation: ObservedObject<DoorsNavigationModel>.Wrapper) -> some View {
        let nextView = NextView(
            isPresented: navigation.isKitchenPresented,
            content: { DoorsViewFactory.kitchenView(navigation: navigation) })
        return VStack {
            CabinetDoorsView(action: {
                navigation.isKitchenPresented.wrappedValue = true
            })
            nextView
        }
    }
    
    static func kitchenView(navigation: ObservedObject<DoorsNavigationModel>.Wrapper) -> some View {
        return KitchenDoorsView(action: {
            navigation.isKitchenPresented.wrappedValue = false
            navigation.isCabinetPresented.wrappedValue = false
        })
    }
}
