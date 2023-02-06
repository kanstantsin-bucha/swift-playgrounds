//
//  Term&ConditionView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 23/01/2023.
//

import SwiftUI

struct Term_ConditionView: View {
    
    @State var agreedToTerms = false
    @State var agreedToPrivacyPolicy = false
    @State var agreedToEmails = false
    
    var body: some View {
        let agreedToAll = Binding<Bool>(
            get: {
                agreedToTerms && agreedToPrivacyPolicy && agreedToEmails
            },
            set: {
                agreedToTerms = $0
                agreedToPrivacyPolicy = $0
                agreedToEmails = $0
            }
        )
        return VStack {
            Toggle("Agree to all", isOn: agreedToAll)
                    Toggle("Agree to terms", isOn: $agreedToTerms)
                    Toggle("Agree to privacy policy", isOn: $agreedToPrivacyPolicy)
                    Toggle("Agree to receive shipping emails", isOn: $agreedToEmails)
                }
    }
}

struct Term_ConditionView_Previews: PreviewProvider {
    static var previews: some View {
        Term_ConditionView()
    }
}
