import SwiftUI

class DoorsNavigationModel: ObservableObject {
    @Published var cabinetNextModel = NextViewModel<Void>()
    @Published var kitchenNextModel = NextViewModel<KitchenType>()
}

enum DoorsViewFactory {
    static func doorsTabView(
        isUnlocked: Bool,
        navigation: DoorsNavigationModel,
        mainModel: MainViewModel
    ) -> some View {
        let nextView = NextView(
            model: navigation.cabinetNextModel,
            content: { DoorsViewFactory.cabinetView(navigation: navigation) }
        )
        let title = isUnlocked ? "Present Cabinet" : "Proceed with registration"
        let action: () -> Void = isUnlocked ? { [weak navigation] in
            navigation?.cabinetNextModel.present()
        } : { [weak mainModel] in
            mainModel?.selected = .user
        }
        return NavigationView {
            VStack {
                DoorsTab(actionTitle: title, action: action)
                nextView
            }
        }
    }
    
    static func cabinetView(navigation: DoorsNavigationModel) -> some View {
        let nextView = NextView(
            model: navigation.kitchenNextModel,
            content: {
                DoorsViewFactory.kitchenView(
                    type: navigation.kitchenNextModel.presentedObject ?? .white,
                    navigation: navigation
                )
            }
        )
        return VStack {
            CabinetDoorsView(action: { [weak navigation] type in
                navigation?.kitchenNextModel.presentedObject = type
                navigation?.kitchenNextModel.present()
            })
            nextView
        }
        .navigationTitle("Cabinet")
    }
    
    static func kitchenView(type: KitchenType, navigation: DoorsNavigationModel) -> some View {
        return KitchenDoorsView(type: type, action: { [weak navigation] in
            navigation?.kitchenNextModel.dismiss()
            navigation?.cabinetNextModel.dismiss()
        })
    }
}
