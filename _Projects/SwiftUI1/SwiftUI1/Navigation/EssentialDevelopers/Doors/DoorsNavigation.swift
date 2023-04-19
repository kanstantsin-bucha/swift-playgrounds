import SwiftUI

class DoorsNavigationModel: ObservableObject {
    @Published var cabinetNextModel = NextViewModel()
    @Published var kitchenNextModel = NextViewModel()
}

enum DoorsViewFactory {
    static func doorsTabView(navigation: DoorsNavigationModel) -> some View {
        let nextView = NextView(
            model: navigation.cabinetNextModel,
            content: { DoorsViewFactory.cabinetView(navigation: navigation) }
        )
        return NavigationView {
            VStack {
                DoorsTab(action: { [weak navigation] in
                    navigation?.cabinetNextModel.present()
                })
                nextView
            }
        }
    }
    
    static func cabinetView(navigation: DoorsNavigationModel) -> some View {
        let nextView = NextView(
            model: navigation.kitchenNextModel,
            content: { DoorsViewFactory.kitchenView(navigation: navigation) })
        return VStack {
            CabinetDoorsView(action: { [weak navigation] in
                navigation?.kitchenNextModel.present()
            })
            nextView
        }
    }
    
    static func kitchenView(navigation: DoorsNavigationModel) -> some View {
        return KitchenDoorsView(action: { [weak navigation] in
            navigation?.kitchenNextModel.dismiss()
            navigation?.cabinetNextModel.dismiss()
        })
    }
}
