//: [Previous](@previous)

import Foundation

struct Currency {}

enum APIError: Error {
    case loseContext
}

class CurrencyService {
    func currencyConverter(from currency: Currency, completion: @escaping (Result<Currency, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            completion(.success(currency))
        }
    }
    
    func asyncCurrencyConverter(from currency: Currency) async throws -> Currency {
        try await Task.sleep(nanoseconds: UInt64(1 * Double(NSEC_PER_SEC)))
        return currency
    }
}

class APIService {
    
    private var service: CurrencyService
    
    init(service: CurrencyService) {
        self.service = service
    }
    
    func getAllConversions(currencies: [Currency]) async throws -> [Currency] {
        var fetchedCurrencies = [Currency]()
        var errorMessage: Error?
        return try await withCheckedThrowingContinuation { continuation in
            let group = DispatchGroup()
            group.enter()
            group.notify(queue: .main) {
                print("notify")
                if let error = errorMessage {
                    continuation.resume(with: .failure(error))
                } else {
                    continuation.resume(with: .success(currencies))
                }
            }
            for currency in currencies {
                group.enter()
                service.currencyConverter(from: currency) { result in
                    switch result {
                    case let .success(currency):
                        fetchedCurrencies.append(currency)
                    case let .failure(error):
                        errorMessage = error
                    }
                    group.leave()
                    print("leave one inside cycle")
                }
            }
            print("leave one after cycle")
            group.leave()
        }
    }
    
    func groupsGetAllConversions(currencies: [Currency]) async throws -> [Currency] {
        try await withThrowingTaskGroup(of: Currency.self) { group in
            for currency in currencies {
                group.addTask { [weak self] in
                    guard let self = self else { throw APIError.loseContext }
                    print("before fetch one")
                    return try await self.service.asyncCurrencyConverter(from: currency)
                }
            }
            var fetchedCurrencies = [Currency]()
            print("before wait of results")
            for try await currency in group {
                print("get one result")
                fetchedCurrencies.append(currency)
            }
            print("before provide all results")
            return fetchedCurrencies
        }
    }
}

func proceed(isOldConcurrency: Bool) async {
    if isOldConcurrency {
        do {
            let result = try await APIService(service: CurrencyService())
                .getAllConversions(currencies: [Currency(), Currency()])
            print("result: \(result)")
        } catch {
            print(error)
        }
        return
    }
    
    do {
        let result = try await APIService(service: CurrencyService())
            .groupsGetAllConversions(currencies: [Currency(), Currency()])
        print("result: \(result)")
    } catch {
        print(error)
    }
}

await proceed(isOldConcurrency: true)

print("finished")


//: [Next](@next)
