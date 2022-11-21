//
//  iOSTimeControlTests.swift
//  iOSTimeControlTests
//
//  Created by Kanstantsin Bucha on 05/11/2022.
//

import XCTest
import Foundation
@testable import iOSTimeControl

extension NSRecursiveLock {
    @inlinable @discardableResult
    func sync<R>(operation: () -> R) -> R {
        self.lock()
        defer { self.unlock() }
        return operation()
    }
}

extension Task where Success == Failure, Failure == Never {
    static func megaYield(count: Int = 10) async {
        for _ in 1...count {
            await Task<Void, Never>.detached(priority: .background) { await Task.yield() }.value
        }
    }
}

public class TestClock: Clock, @unchecked Sendable {
    private let lock = NSRecursiveLock()
    private var scheduled: [(deadline: Instant, continuation: AsyncStream<Never>.Continuation)] = []
    
    public func sleep(until deadline: Instant, tolerance: Duration?) async throws {
        guard self.lock.sync(operation: { deadline > self.now })
        else { return }
        
        let stream = AsyncStream<Never> { continuation in
            self.lock.sync {
                self.scheduled.append((deadline: deadline, continuation: continuation))
            }
        }
        for await _ in stream {}
        try Task.checkCancellation()
    }
    
    public func advance(by duration: Duration) async {
        await self.advance(to: self.now.advanced(by: duration))
    }
    
    public func advance(to deadline: Instant) async {
        while self.lock.sync(operation: { self.now }) <= deadline {
            await Task.megaYield()
            let `return` = { () -> Bool in
                self.lock.lock()
                self.scheduled.sort { $0.deadline < $1.deadline }
                
                guard
                    let next = self.scheduled.first,
                    deadline >= next.deadline
                else {
                    self.now = deadline
                    self.lock.unlock()
                    return true
                }
                
                self.now = next.deadline
                self.scheduled.removeFirst()
                self.lock.unlock()
                next.continuation.finish()
                return false
            }()
            
            if `return` {
                return
            }
        }
    }
    
    public func run() async {
        while let deadline = self.lock.sync(operation: { self.scheduled.first?.deadline }) {
            await self.advance(to: deadline)
        }
    }
    
    public var now = Instant()
    public var minimumResolution = Duration.zero
    
    public typealias Duration = Swift.Duration
    public struct Instant: InstantProtocol {
        private var offset: Duration = .zero
        
        public func advanced(by duration: Duration) -> Self {
            .init(offset: self.offset + duration)
        }
        
        public func duration(to other: Self) -> Duration {
            other.offset - self.offset
        }
        
        public static func < (lhs: Self, rhs: Self) -> Bool {
            lhs.offset < rhs.offset
        }
        
        public typealias Duration = Swift.Duration
    }
    
    
}

@MainActor
final class ClocksExplorationTests: XCTestCase {
  func testWelcome_FirstTimer() async {
    UserDefaults.standard.set(false, forKey: "hasSeenViewBefore")

    let clock = TestClock()
    let model = FeatureModel(clock: clock)

    XCTAssertEqual(model.message, "")
    let task = Task {
      await model.task()
    }
    await clock.advance(by: .seconds(5))
    await task.value
    XCTAssertEqual(model.message, "Welcome!")
  }

  func testWelcome_RepeatVisitor() async {
    UserDefaults.standard.set(true, forKey: "hasSeenViewBefore")

    let clock = TestClock()
    let model = FeatureModel(clock: clock)

    XCTAssertEqual(model.message, "")
    let task = Task {
      await model.task()
    }
    await clock.advance(by: .seconds(1))
    await task.value
    XCTAssertEqual(model.message, "Welcome!")
  }

  func testCount() async {
    let model = FeatureModel(
      clock: ContinuousClock(),
      count: 10_000
    )

    model.incrementButtonTapped()
    XCTAssertEqual(model.count, 10_001)
    model.decrementButtonTapped()
    XCTAssertEqual(model.count, 10_000)
    await model.nthPrimeButtonTapped()
    XCTAssertEqual(model.message, "10000th prime is 104729")

    // TODO: assertion on how the analytics event was tracked
  }

  func testTimer() async throws {
    let clock = TestClock()
    let model = FeatureModel(clock: clock)

    model.startTimerButtonTapped()
    XCTAssertNotNil(model.timerTask)

    await clock.advance(by: .seconds(1))
    XCTAssertEqual(model.count, 1)

    await clock.advance(by: .seconds(1))
    XCTAssertEqual(model.count, 2)

    await clock.advance(by: .seconds(8))
    XCTAssertEqual(model.count, 10)

    model.stopTimerButtonTapped()
    XCTAssertNil(model.timerTask)
    XCTAssertEqual(model.count, 10)

    await clock.run()
    XCTAssertEqual(model.count, 10)
  }
}
