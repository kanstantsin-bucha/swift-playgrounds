//
//  Clock.swift
//  iOSTimeControl
//
//  Created by Kanstantsin Bucha on 05/11/2022.
//

import Foundation

public final class ImmediateClock: Clock {
    public func sleep(until deadline: Instant, tolerance: Duration?) async throws {
        try Task.checkCancellation()
        await MainActor.run { now = deadline }
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

extension Clock {
    /// Suspends for the given duration.
    public func sleep(
        for duration: Duration,
        tolerance: Duration? = nil
    ) async throws {
        try await self.sleep(until: self.now.advanced(by: duration), tolerance: tolerance)
    }
}
