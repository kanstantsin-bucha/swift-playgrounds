//: [Previous](@previous)

import Foundation

let config = URLSessionConfiguration.default
// in accordance with 5% rule that cache will store all cache enabled responses that smaller than 5MB (5% for 100MB)
config.urlCache = URLCache(
    memoryCapacity: 100 * 1024 * 1024,
    diskCapacity: 100 * 1024 * 1024
)
let session = URLSession(configuration: config)

let request = URLRequest(
    url: URL(string: "https://developer.apple.com/documentation/foundation/urlcache")!,
    cachePolicy: .returnCacheDataElseLoad,
    timeoutInterval: 10
)

let tuple = (a: 1, b: 4)
let (a,b) = tuple

import PlaygroundSupport
_ = Task {
    guard let tuple = try? await session.data(for: request) else { return }
    let (data, response) = tuple
    print(String(data: data, encoding: .utf8))
    print((response as? HTTPURLResponse)?.statusCode)
    PlaygroundPage.current.finishExecution()
}

print("Go")
PlaygroundPage.current.needsIndefiniteExecution = true

//: [Next](@next)

/*
 URLCache reference https://developer.apple.com/documentation/foundation/urlcache
 Response caching criteria https://developer.apple.com/documentation/foundation/nsurlsessiondatadelegate/1411612-urlsession
 NSURLRequest.CachePolicy reference https://developer.apple.com/documentation/foundation/nsurlrequest/cachepolicy
 HTTP Caching Behavior with the default .useProtocolCachePolicy https://developer.apple.com/documentation/foundation/nsurlrequest/cachepolicy/useprotocolcachepolicy
 URL Loading System reference https://developer.apple.com/documentation/foundation/url_loading_system
 Ephemeral URLSessionConfiguration reference https://developer.apple.com/documentation/foundation/urlsessionconfiguration/1410529-ephemeral
 */
