//: [Previous](@previous)

import Foundation
import XCTest

enum Timeout {
    static let desktopAuth: TimeInterval = 32
}

struct DateWrapper {
    public private(set) var expiryDate: Date?
    public let timeout: Int? = nil
    public private(set) var date: Date
    
    init(date: Date, timeout: TimeInterval? = nil) {
        self.date = date
        if let timeout = timeout {
            expiryDate = date.addingTimeInterval(timeout)
        }
    }
    
    public var calculatedExpiryDate: Date {
        guard let expiryDate = expiryDate else {
            return Date(timeIntervalSinceNow: remainingInterval)
        }
        return expiryDate
    }

    public var remainingInterval: TimeInterval {
        guard let expiryDate = expiryDate else {
            let validTimeout = timeout.map { TimeInterval($0) } ?? Timeout.desktopAuth
            let elapsedTime = Date().timeIntervalSince(date)
            return max(validTimeout - elapsedTime, 0)
        }
        return max(expiryDate.timeIntervalSince(Date()), 0)
    }
}

class DateWrapperTests: XCTestCase {
    var wrapper: DateWrapper!
    
    override func setUp() {
        wrapper = DateWrapper(date: Date())
    }
    
    override func tearDown() {
        wrapper = nil
    }
    
    func testRemaining12() {
        let wrapper = DateWrapper(date: Date(timeIntervalSinceNow: -20), timeout: 32)
        XCTAssertEqual(wrapper.remainingInterval, 12, accuracy: 0.1)
    }
}

func checkRemainingLogic() {
    func remain(date: Date) {
        let remainSec = Int(date.timeIntervalSince(Date()))
        print(remainSec)
        print(String(format: "is locked for %d sec", max(remainSec, 0)))
    }

    let date = Date(timeIntervalSinceNow: 30)
    DispatchQueue.main.asyncAfter(deadline: .now() + 13) {
        remain(date: date)
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 16) {
        remain(date: date)
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 28) {
        remain(date: date)
    }
}

DateWrapperTests.defaultTestSuite.run()


//checkRemainingLogic()
//: [Next](@next)
