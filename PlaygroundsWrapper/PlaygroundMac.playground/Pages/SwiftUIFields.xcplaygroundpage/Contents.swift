//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport
import Foundation

struct User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
    var nickNames:  [String] {
        get { [firstName + " dot", lastName + " root"] }
        set { }
    }
}

struct ContentView: View {
    @State private var user: User
    
    var body: some View {
        VStack {
            Print("reload ContentView")
            Text("Your name is \(user.firstName) \(user.lastName).")
                .scaledToFill()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
            Form {
                List(user.nickNames, id: \.self) { nickName in
                    Print("create nickName \(nickName)")
                    NickNameView(nickname: nickName)
                        .listRowBackground(Color.blue)
                        
                }
                .frame(minHeight: CGFloat(user.nickNames.count * 30))
            }
            .background(Color.blue)
        }
        .fixedSize()
        .frame(width: 300, height: 400)
    }
}

struct NickNameView: View {
    var nickname: String
    
    var body: some View {
        Print("NickNameView \(nickname)")
        Text("\(nickname)")
    }
}

PlaygroundPage.current.setLiveView(ContentView(user: User()))

//: [Next](@next)
