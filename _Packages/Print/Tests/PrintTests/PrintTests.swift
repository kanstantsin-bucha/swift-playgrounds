import XCTest
@testable import Print

final class PrintTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Print().text, "Hello, World!")
    }
}
