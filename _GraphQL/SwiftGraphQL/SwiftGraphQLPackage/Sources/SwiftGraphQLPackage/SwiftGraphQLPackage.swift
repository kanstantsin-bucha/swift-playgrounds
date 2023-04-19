import SwiftGraphQLClient
import Foundation

public struct SwiftGraphQLPackage {
    let client = SwiftGraphQLClient.Client(request:
        URLRequest(url: URL(string: "http://127.0.0.1:3001/graphql")!)
    )
    public private(set) var text = "Hello, World!"

    public init() {
    }
    
    public func fetch() {
        client.request
    }
}
