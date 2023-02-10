//
//  Created by Kanstantsin Bucha on 09/02/2023.
//

import Foundation

import Foundation
// Log in to console
// https://one.eu.newrelic.com/logger
// login: hqu92641@omeie.com
// pass: newPass4321

typealias Event = String

public enum NewRelicTelemetryError: Error {
    case invalidResponse
    case invalidStatusCode(Int)
}

private struct TelemetryReport: Encodable {
    let common: TelemetryReportCommon
    let logs: [TelemetryEvent]
}

private struct TelemetryReportCommon: Encodable {
    let attributes: TelemetryAttributes
}

private struct TelemetryAttributes: Encodable {
    let logtype: String
    let deviceType: String
}

private struct TelemetryEvent: Encodable {
    let timestamp: Date
    let message: Event
}

class NewRelicTelemetry {
    private let url = URL(string: "https://log-api.eu.newrelic.com/log/v1")!
    private let apiKey = "eu01xx8bfba4e5fff63f62cdb23105f4af21NRAL"
    private let sendIntervalSec: Int = 10
    private var timer: DispatchSourceTimer?
    private let queue = DispatchQueue(label: "NewRelicTelemetry.timerQueue")
    private var events = [TelemetryEvent]()
    private var isSending = false
    
    deinit {
        timer?.cancel()
    }
    
    func start() {
        timer = DispatchSource.makeTimerSource(queue: queue)
        timer?.setEventHandler { [weak self] in
            self?.sendEvents()
        }
        timer?.schedule(
            wallDeadline: .now() + 1,
            repeating: .seconds(sendIntervalSec),
            leeway: .seconds(1)
        )
        timer?.activate()
    }
    
    func stop() {
        timer?.cancel()
        sendEvents()
    }
    
    func add(event: Event) {
        queue.async { [weak self] in
            self?.events.append(.init(timestamp: Date(), message: event))
        }
    }
    
    // MARK: - Private methods
    
    private func sendEvents() {
        queue.async { [weak self] in
            guard let self, !self.isSending, !self.events.isEmpty else { return }
            self.isSending = true
            let reports = self.composeReports()
            self.events.removeAll()
            Task {
                do {
                    let encoder = JSONEncoder()
                    encoder.dateEncodingStrategy = .iso8601
                    let data = try encoder.encode(reports)
                    try await self.sendTelemetry(data: data)
                } catch {
                    print("[Error] [NewRelicTelemetry] Failed to send events: \(error)")
                }
                self.queue.async { self.isSending = false }
            }
        }
    }
    
    private func composeReports() -> [TelemetryReport] {
        [TelemetryReport(
            common: TelemetryReportCommon(
                attributes: TelemetryAttributes(logtype: "mobile", deviceType: "iPhone")
            ),
            logs: events
        )]
    }
    
    private func sendTelemetry(data: Data) async throws {
        var request = URLRequest(url: url, timeoutInterval: 10)
        request.addValue(apiKey, forHTTPHeaderField: "Api-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        request.httpBody = data
        request.httpMethod = "POST"
        let (respData, response) = try await URLSession.shared.data(for: request)
        if let responseMessage = String(data: respData, encoding: .utf8) {
            print("[Info] [NewRelicTelemetry] Response: \(responseMessage)")
        }
        guard let resp = response as? HTTPURLResponse else {
            throw NewRelicTelemetryError.invalidResponse
        }
        let acceptedCodes = [200, 202]
        guard acceptedCodes.contains(resp.statusCode) else {
            throw NewRelicTelemetryError.invalidStatusCode(resp.statusCode)
        }
    }
}
