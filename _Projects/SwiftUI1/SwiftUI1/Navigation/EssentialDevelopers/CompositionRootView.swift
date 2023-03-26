import SwiftUI
import Combine

class MainViewModel: ObservableObject {
    @Published var selected: Tab = .keys
    enum Tab: Int, CaseIterable, Identifiable, Hashable {
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

class RegistrationViewModel: ObservableObject {
    @Published var isRegistered = false
}

class MainFlow {
    var cancellable: AnyCancellable?
    
    init(
        main: MainViewModel,
        register: RegistrationViewModel,
        sheet: SheetViewModel
    ) {
        cancellable = register.$isRegistered
            .removeDuplicates()
            .sink { isRegistered in
                if isRegistered {
                    sheet.isPresented = false
                    main.selected = .keys
                }
            }
    }
}

private var mainFlow: MainFlow?

func composeMainNavigationView() -> CompositionRootView {
    let mainModel = MainViewModel()
    let sheetModel = SheetViewModel()
    let registrationModel = RegistrationViewModel()
    mainFlow = MainFlow(main: mainModel, register: registrationModel, sheet: sheetModel)
    return CompositionRootView(model: mainModel, sheet: sheetModel, registration: registrationModel)
}


struct CompositionRootView: View {
    @ObservedObject var model: MainViewModel
    @ObservedObject var sheet: SheetViewModel
    @ObservedObject var registration: RegistrationViewModel
    var body: some View {
        TabView(selection: $model.selected) {
            ForEach(MainViewModel.Tab.allCases) { tab in
                switch tab {
                case .keys: KeysTab()
                    .tag(tab)
                    .tabItem { Label("Keys", systemImage: "key.horizontal") }
                case .doors: DoorsTab()
                    .tag(tab)
                    .tabItem { Label("Doors", systemImage: "door.left.hand.open") }
                case .sites: SitesTab()
                    .tag(tab)
                    .tabItem { Label("Sites", systemImage: "link") }
                case .user: UserTab(registrationAction: registrationAction)
                    .tag(tab)
                    .tabItem { Label("User", systemImage: "person") }
                }
            }
        }
        .sheet(isPresented: $sheet.isPresented) {
            // pass bindings and closures in views instead of models when possible
            RegistrationView(registrationAction: { [weak registration] in
                registration?.isRegistered.toggle()
            })
        }
    }
    
    private var registrationAction: (() -> Void)? {
        registration.isRegistered ? nil : { [weak sheet] in
            sheet?.isPresented = true
        }
    }
}
