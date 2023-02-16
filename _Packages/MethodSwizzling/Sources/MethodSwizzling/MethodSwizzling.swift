import CoreBluetooth

class CBCentralManagerSwizzler: NSObject {
    private class Swizzler {
        private let destinationSel: Selector
        private let destinationType: AnyObject.Type
        private let originalSel: Selector

        init(_ originalSel: Selector, _ destinationSel: Selector, destinationType: AnyObject.Type = CBCentralManagerSwizzler.self) {
            self.originalSel = originalSel
            self.destinationSel = destinationSel
            self.destinationType = destinationType
            
            method_exchangeImplementations(
                class_getInstanceMethod(CBCentralManager.self, originalSel)!,
                class_getInstanceMethod(destinationType.self, destinationSel)!
            )
        }

        deinit {
            method_exchangeImplementations(
                class_getInstanceMethod(destinationType.self, destinationSel)!,
                class_getInstanceMethod(CBCentralManager.self, originalSel)!
            )
        }
        
        func originalMethod() -> (IMP, Selector) {
            let sel = #selector(CBCentralManagerSwizzler.scanForPeripherals(withServices:options:))
            let method = class_getInstanceMethod(CBCentralManagerSwizzler.self, sel)!
            return (method_getImplementation(method), destinationSel)
        }
    }
    
    private var scanSwizzler: Swizzler?
    
    public func startIntercepting() {
        scanSwizzler = Swizzler(
            #selector(CBCentralManager.scanForPeripherals(withServices:options:)),
            #selector(Self.scanForPeripherals(withServices:options:))
        )
    
    }
    
    // MARK: - CBCentralManager
    
    @available(macOS 10.7, iOS 10, *)
    weak var delegate: CentralDelegate?
    
  
#if !os(macOS)
    @available(iOS 13.0, *)
    static func supports(_ features: CBCentralManager.Feature) -> Bool {
        CBCentralManager.supports(features)
    }
#endif
    
    @available(macOS 10.9, iOS 10, *)
    @objc func scanForPeripherals(withServices serviceUUIDs: [CBUUID]?, options: [String : Any]? = nil) {
        print("Swizzled scanForPeripherals called")
        guard let (impl, selector) = scanSwizzler?.originalMethod() else { return }
        typealias Method = @convention(c) (AnyObject, Selector, [CBUUID]?, [String : Any]?) -> Void
        unsafeBitCast(impl, to: Method.self)(self, selector, serviceUUIDs, options)
        print("Original scanForPeripherals called")
    }
}
