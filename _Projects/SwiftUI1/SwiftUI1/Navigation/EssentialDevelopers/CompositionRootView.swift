import SwiftUI
import Combine

class MainViewModel: ObservableObject {
    @Published var selected: Tab = .keys
    enum Tab: Int, CaseIterable, Identifiable {
        case keys
        case doors
        case user
        case sites
        
        var id: Int {
            self.rawValue
        }
    }
}

class SheetViewModel: ObservableObject {
    @Published var isPresented = false
}

class RegisterViewModel: ObservableObject {
    @Published var isRegistered = false
}

class MainFlow {
    var cancellable: AnyCancellable?
    
    init(
        main: MainViewModel,
        register: RegisterViewModel,
        sheet: SheetViewModel
    ) {
        cancellable = register.$isRegistered
            .removeDuplicates()
            .sink { isRegistered in
                if isRegistered {
                    sheet.isPresented = false
                    main.selected = .user
                }
            }
    }
}

private var mainFlow: MainFlow?

func composeMainNavigationView() -> CompositionRootView {
    let mainModel = MainViewModel()
    let sheetModel = SheetViewModel()
    let registrationModel = RegisterViewModel()
    mainFlow = MainFlow(main: mainModel, register: registrationModel, sheet: sheetModel)
    return CompositionRootView(model: mainModel, sheet: sheetModel)
}


struct CompositionRootView: View {
    @ObservedObject var model: MainViewModel
    @ObservedObject var sheet: SheetViewModel
    var body: some View {
        TabView(selection: $model.selected) {
            ForEach(MainViewModel.Tab.allCases) { tab in
                switch tab {
                case .keys: KeysTab()
                    .tag(tab)
                    .tabItem { Label("KeysTab", image: "key") }
                case .doors: DoorsTab()
                    .tag(tab)
                    .tabItem { Label("DoorsTab", image: "door") }
                case .sites: SitesTab()
                    .tag(tab)
                    .tabItem { Label("SitesTab", image: "site") }
                case .user: UserTab()
                    .tag(tab)
                    .tabItem { Label("UserTab", image: "user") }
                }
            }
        }
        .sheet(isPresented: $sheet.isPresented) {
            
        }
    }
}
