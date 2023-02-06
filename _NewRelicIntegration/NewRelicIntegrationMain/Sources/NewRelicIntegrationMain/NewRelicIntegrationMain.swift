import NewRelic

public struct NewRelicIntegrationMain {
    public private(set) var text = "Hello, World!"

    public init() {}
    
    public func startTelemetry() {
        NewRelic.start(withApplicationToken:"eu01xx70af9ba14518a8b5591e877e3503b82a6123-NRMA")
    }
}
