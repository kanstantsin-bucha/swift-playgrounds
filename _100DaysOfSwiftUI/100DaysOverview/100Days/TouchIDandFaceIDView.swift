//
//  TouchIDandFaceIDView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 22/02/2023.
//
import LocalAuthentication
import SwiftUI

struct TouchIDandFaceIDView: View {
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "We need unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                if success {
                    // authenticated successfully
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometric in device
        }
    }
}

struct TouchIDandFaceIDView_Previews: PreviewProvider {
    static var previews: some View {
        TouchIDandFaceIDView()
    }
}
