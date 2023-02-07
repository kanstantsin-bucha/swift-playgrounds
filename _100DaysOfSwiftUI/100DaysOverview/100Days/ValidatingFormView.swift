//
//  ValidatingFormView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 07/02/2023.
//

import SwiftUI

struct ValidatingFormView: View {
    @State private var userName = ""
    @State private var userEmail = ""
    var disabledForm: Bool {
        userName.count < 5 || userEmail.count < 5
    }
    var body: some View {
        Form {
            Section {
                TextField("userName", text: $userName)
                TextField("userEmail", text: $userEmail)
            }
            Section {
                Button("Create account") {
                    print("Create account")
                }
            }
            .disabled(disabledForm)
        }
    }
}

struct ValidatingFormView_Previews: PreviewProvider {
    static var previews: some View {
        ValidatingFormView()
    }
}
