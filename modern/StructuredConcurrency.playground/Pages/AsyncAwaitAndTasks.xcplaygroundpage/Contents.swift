//: [Previous](@previous)

import Foundation


class StringsRepository {
    func getStrings() async throws -> [String] {
        try await Task.sleep(nanoseconds: UInt64(1 * Double(NSEC_PER_SEC)))
        return await MainActor.run { [] }
    }
    
    func getMoreStrings(completion: @escaping (Result<[String], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            completion(.success([]))
        }
    }
    
    func callAsyncFunctionSync() throws {
        Task() {
            _ = try await getStrings()
        }
    }
    
    func callAsyncFunction_ContinueWithCompletion(completion: @escaping (Result<[String], Error>) -> Void) throws {
        Task() { @MainActor in
            let result: Result<[String], Error>
            do {
                result = .success(try await getStrings())
            } catch {
                result = .failure(error)
            }
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func callFuncWithCompletion_ContinueAsync() async throws {
        try await withCheckedThrowingContinuation({ continuation in
            getMoreStrings { result in
                DispatchQueue.main.async {
                    continuation.resume(with: result)
                }
            }
        })
    }
}

import XCTest

class Tests: XCTestCase {
    private var repo: StringsRepository!
    override func setUp() {
        repo = StringsRepository()
    }
    
    override func tearDown() {
        repo = nil
    }
    
    func test_getStrings() async throws {
        // Given
        print(Date())
        // When
        let result = try await repo.getStrings()
        // Then
        print(Date())
        XCTAssertEqual(result, [])
    }
    
    func test_getMoreStrings() async throws {
        // Given
        print(Date())
        // When
        let result = try await withCheckedThrowingContinuation({ continuation in
            repo.getMoreStrings { result in
                continuation.resume(with: result)
            }
        })
        // Then
        print(Date())
        XCTAssertEqual(result, [])
    }
}

Tests.defaultTestSuite.run()

//: [Next](@next)
