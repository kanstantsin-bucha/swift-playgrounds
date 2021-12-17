//: [Previous](@previous)

import Foundation

enum FetchError: Error {
    case denied
}

protocol FetchStrategy {
    var isRetryAvailable: Bool { get }
    var isFetchAvailable: Bool { get }
    func getRetryInterval() -> TimeInterval

    func noteFailure()
    func noteSuccess()
}

class BackgroundStrategy: FetchStrategy {
    let isRetryAvailable = false
    private(set) var isFetchAvailable: Bool = true

    func getRetryInterval() -> TimeInterval {
        return .distantFuture
    }

    func noteFailure() {
        isFetchAvailable = false
    }

    func noteSuccess() {
        isFetchAvailable = true
    }
}

struct TruU {
    static var isForeground = true
}

class ForegroundStrategy: FetchStrategy {
    let isRetryAvailable = true
    var isFetchAvailable { TruU.isForeground }
    private var retryCount: UInt = 0

    func getRetryInterval() -> TimeInterval {
        return retryCount * 2 + 500;
    }

    func noteFailure() {
        retryCount += 1
    }

    func noteSuccess() {
        retryCount = 0
    }
}

struct NetworkService {
    static func fetch(completion: (String?) -> Void) {
        completion("")
    }
}
struct BackgroundTimer {
    static func schedule(time: TimeInterval, completion: () -> Void) {
        completion()
    }
}

struct OAuth {
    static var currentStrategy: FetchStrategy = ForegroundStrategy()

    static getOAuthToken() {
        updateStrategy()
        fetch(strategy: currentStrategy, completion: { _ in } )
    }

    static func updateStrategy() {
        if TruU.isForeground && currentStrategy is BackgroundStrategy {
            currentStrategy = ForegroundStrategy()
        }
        if !TruU.isForeground && currentStrategy is ForegroundStrategy {
            currentStrategy = BackgroundStrategy()
        }
    }

    static func fetch(strategy: FetchStrategy, completion: (Result<Void, Error>) -> Void) {
        guard strategy.isFetchAvailable else {
            completion(.failure(FetchError.denied))
            return
        }
        NetworkService.fetch() { token in
            if token == nil { // 429, 503
                strategy.noteFailure()
                guard strategy.isRetryAvailable else {
                    completion(.failure(FetchError.denied))
                    return
                }

                BackgroundTimer.schedule(time: 11) {
                    OAuthFetcher.fetch(strategy: strategy, completion: completion)
                }
            } else {
                strategy.noteSuccess()
                completion(.success(()))
                //
            }
        }
    }
}

//: [Next](@next)
