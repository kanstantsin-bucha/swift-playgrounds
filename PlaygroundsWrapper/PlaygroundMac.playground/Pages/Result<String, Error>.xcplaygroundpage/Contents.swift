//: [Previous](@previous)

import Foundation

public enum NetworkTransportError: Error, Equatable {
    case noValidURLForDomain
    case noOAuthToken
    case stompError(description: String)
    case resendAttemptWhileNotConnected
    case sendAttemptWhileStillConnecting
    case applicationSuspended
    case stompBodyNotString
    case transportWasDisconnected
}

extension NetworkTransportError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noValidURLForDomain:
            return "No valid URL could be created for the provided domain"
        case .noOAuthToken:
            return "No valid OAuth token was provided by SDK"
        case .stompError(let description):
            return "Stomp error: \(description)"
        case .resendAttemptWhileNotConnected:
            return "Transport can't resend a message. It is not connected."
        case .sendAttemptWhileStillConnecting:
            return "Transport can't send a message during connecting sequence"
        case .applicationSuspended:
            return "The application was suspended by the OS"
        case .stompBodyNotString:
            return "Stomp received frame with no string body"
        case .transportWasDisconnected:
            return "Network transport was disconnected"
        }
    }
}

class Handler {
    func handle(result: Result<String, Error>) {
        let closure = { [weak self] in
            switch result {
            case .success:
                print("success")

            case .failure(let error):
                (error as? LocalizedError).flatMap { self?.showAlert($0) }
            }
        }
        closure()
    }

    func showAlert(_ error: LocalizedError) {
        print("Alert \(error.localizedDescription)")
    }
}

let resultOne: Result<String, Error> = .failure(NetworkTransportError.noOAuthToken)

print("the error: \(resultOne)")

Handler().handle(result: .failure(NetworkTransportError.noOAuthToken))



//: [Next](@next)
