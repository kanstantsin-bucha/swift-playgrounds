import NewRelic

public struct NewRelicIntegrationMain {
    public private(set) var text = "Hello, World!"

    public init() {}
    
    public func startTelemetry() {
        updateUserID()
        NewRelic.enableFeatures(NRMAFeatureFlags.NRFeatureFlag_NSURLSessionInstrumentation)
        NewRelic.enableFeatures(NRMAFeatureFlags.NRFeatureFlag_SwiftInteractionTracing)
        NewRelic.enableFeatures(NRMAFeatureFlags.NRFeatureFlag_NetworkRequestEvents)
        NRLogger.setLogLevels(NRLogLevelInfo.rawValue)
        NewRelic.start(withApplicationToken:"eu01xx70af9ba14518a8b5591e877e3503b82a6123-NRMA")
    }
    
    public func sendLog() {
        NewRelic.incrementAttribute("LogsCount")
        NRLogger.log(
            NRLogLevelInfo.rawValue,
            inFile: #filePath,
            atLine: #line,
            inMethod: #function,
            withMessage: "New Log: \(Date())"
        )
    }
    
    public func sendEvent() {
        NewRelic.incrementAttribute("EventsCount")
        let result = NewRelic.recordCustomEvent(
            "Event1",
            attributes: ["DateKey": Date().timeIntervalSince1970]
        )
        print("Send event: \(result)")
        NewRelic.recordMetric(withName: "MyMetricName", category: "MobileApp")
        NewRelic.recordBreadcrumb("SendEvent")
    }
    
    private func updateUserID() {
        let idKey = "UserID"
        if let id = UserDefaults.standard.string(forKey: idKey) {
            print("Loaded: UserID: \(id)")
            NewRelic.setUserId(id)
        } else {
            let id = UUID().uuidString
            UserDefaults.standard.set(id, forKey: idKey)
            NewRelic.setUserId(id)
            print("Created: UserID: \(id)")
        }
    }
}
