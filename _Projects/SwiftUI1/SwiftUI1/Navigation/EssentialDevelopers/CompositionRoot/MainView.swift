import SwiftUI

struct MainView: View {
    @ObservedObject var model: MainViewModel
    @ObservedObject var sheet: SheetViewModel
    @ObservedObject var registration: RegistrationViewModel
    @StateObject var doorsNavigation: DoorsNavigationModel
    var body: some View {
        TabView(selection: $model.selected) {
            ForEach(MainViewModel.Tab.allCases) { tab in
                switch tab {
                case .keys: KeysTab()
                    .tag(tab)
                    .tabItem { Label("Keys", systemImage: "key.horizontal") }
                case .doors: DoorsViewFactory.doorsTabView(navigation: $doorsNavigation)
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(
            model: MainViewModel(),
            sheet: SheetViewModel(),
            registration: RegistrationViewModel(),
            doorsNavigation: DoorsNavigationModel()
        )
    }
}
