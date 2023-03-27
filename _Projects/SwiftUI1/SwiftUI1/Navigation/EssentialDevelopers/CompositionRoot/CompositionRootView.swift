import SwiftUI
import Combine

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

func composeMainNavigationView() -> some View {
    let mainModel = MainViewModel()
    let sheetModel = SheetViewModel()
    let registrationModel = RegistrationViewModel()
    let doorsNavigationModel = DoorsNavigationModel()
    mainFlow = MainFlow(main: mainModel, register: registrationModel, sheet: sheetModel)
    return MainView(
        model: mainModel,
        sheet: sheetModel,
        registration: registrationModel,
        doorsNavigation: doorsNavigationModel
    )
}
