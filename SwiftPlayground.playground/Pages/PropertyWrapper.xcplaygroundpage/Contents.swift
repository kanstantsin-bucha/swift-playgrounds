//: [Previous](@previous)

import UIKit
import XCPlayground
import PlaygroundSupport


fileprivate enum LocalFeature: String {
    case exampleOfLocalFeature = "eolf" // for testing purposes
    case disappearingMessages = "dm"
}

public protocol LocalFeatureSwitcherStorage {
    var localFeatures: String? { get set }
}

public final class LocalFeatureSwitcher: NSObject {
    public static let shared = LocalFeatureSwitcher()
    public var isExampleOfLocalFeatureEnabled: Bool {
        get { return isFeatureEnabled(.exampleOfLocalFeature) }
        set { updateFeature(.exampleOfLocalFeature, isEnabled: newValue)}
    }
    public var isDisappearingMessagesEnabled: Bool {
        get { return isFeatureEnabled(.disappearingMessages) }
        set { updateFeature(.disappearingMessages, isEnabled: newValue)}
    }

    private enum Constants {
        static let separator: Character = ","
    }
    private var storage: LocalFeatureSwitcherStorage?
    private let queue = DispatchQueue(
        label: "ViberConfiguration.LocalFeatureSwitcherQueue",
        attributes: .concurrent)

    public func initialize(storage: LocalFeatureSwitcherStorage?) {
        #if !DEBUG_OPTIONS_ENABLED
        return
        #endif
        self.storage = storage
    }
}

extension LocalFeatureSwitcher {
    fileprivate func isFeatureEnabled(_ feature: LocalFeature) -> Bool {
        guard let localFeatures = readLocalFeatures() else {
            return false
        }
        return localFeatures.contains(feature)
    }

    fileprivate func updateFeature(_ feature: LocalFeature, isEnabled: Bool) {
        let localFeatures = readLocalFeatures() ?? []
        guard localFeatures.contains(feature) != isEnabled else {
            return
        }

        if isEnabled {
            writeLocalFeatures(localFeatures + [feature])
        }
        else {
            writeLocalFeatures(localFeatures.filter { $0 != feature })
        }
    }

    private func readLocalFeatures() -> [LocalFeature]? {
        #if !DEBUG_OPTIONS_ENABLED
        return nil
        #endif
        var features: String?
        queue.sync {
            features = self.storage?.localFeatures
        }
        guard let localFeatures = features else {
            return nil
        }
        return localFeatures
            .split(separator: Constants.separator)
            .compactMap { LocalFeature(rawValue: String($0)) }
    }

    private func writeLocalFeatures(_ features: [LocalFeature]) {
        #if !DEBUG_OPTIONS_ENABLED
        return
        #endif
        let string = features.map { $0.rawValue }.joined(separator: String(Constants.separator))
        queue.async(flags: .barrier) {
            self.storage?.localFeatures = !string.isEmpty ? string : nil
        }
    }
}


@propertyWrapper
struct LocalFeatureWrapper {
    private var feature: LocalFeature
    private var switcher: LocalFeatureSwitcher { LocalFeatureSwitcher.shared }

    var wrappedValue: Bool {
        get { switcher.isFeatureEnabled(feature) }
        set { switcher.updateFeature(feature, isEnabled: newValue) }
    }

    fileprivate init(_ feature: LocalFeature) {
        self.feature = feature
    }
}

struct Test {
    @LocalFeatureWrapper(.exampleOfLocalFeature) var test: Bool
}

var test = Test()
print(test.test)

//: [Next](@next)
