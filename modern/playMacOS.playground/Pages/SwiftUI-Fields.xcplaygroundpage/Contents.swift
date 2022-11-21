//: [Previous](@previous)
import Cocoa
import PlaygroundSupport
import Print
import SwiftUI

public struct User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
    var nickNames:  [String] {
        get { [firstName + " dot", lastName + " root"] }
        set { }
    }
}

@available(macOS 12, iOS 14, *)
public struct ContentView: View {
    @State private var user: User
    
    public init(user: User) {
        self.user = user
    }
    
    public var body: some View {
        VStack {
            PrintIt("reload ContentView")
            Text("Your name is \(user.firstName) \(user.lastName).")
                .scaledToFill()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
            Form {
                List(user.nickNames, id: \.self) { nickName in
                    PrintIt("create nickName \(nickName)")
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
        PrintIt("NickNameView \(nickname)")
        Text("\(nickname)")
    }
}

PlaygroundPage.current.setLiveView(ContentView(user: User()))

//: [Next](@next)



//: [Next](@next)
