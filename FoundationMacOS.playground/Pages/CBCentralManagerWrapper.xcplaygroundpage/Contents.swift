//: [Previous](@previous)

import Foundation

import CoreBluetooth

public protocol CBTCentralManager: AnyObject, TelemetryEventProducer {
    
    // MARK: - CBManager
    
    /*!
     *  @enum CBManagerState
     *
     *  @discussion Represents the current state of a CBManager.
     *
     *  @constant CBManagerStateUnknown       State unknown, update imminent.
     *  @constant CBManagerStateResetting     The connection with the system service was momentarily lost, update imminent.
     *  @constant CBManagerStateUnsupported   The platform doesn't support the Bluetooth Low Energy Central/Client role.
     *  @constant CBManagerStateUnauthorized  The application is not authorized to use the Bluetooth Low Energy role.
     *  @constant CBManagerStatePoweredOff    Bluetooth is currently powered off.
     *  @constant CBManagerStatePoweredOn     Bluetooth is currently powered on and available to use.
     *
     *    @seealso  authorization
     */
    
    /**
     *  @property state
     *
     *  @discussion The current state of the manager, initially set to <code>CBManagerStateUnknown</code>.
     *                Updates are provided by required delegate method {@link managerDidUpdateState:}.
     *
     */
    @available(macOS 10.13, iOS 10, *)
    var state: CBManagerState { get }
    
    
    /*!
     *  @enum CBManagerAuthorization
     *
     *  @discussion Represents the current authorization state of a CBManager.
     *
     *  @constant CBManagerAuthorizationStatusNotDetermined            User has not yet made a choice with regards to this application.
     *  @constant CBManagerAuthorizationStatusRestricted            This application is not authorized to use bluetooth. The user cannot change this application’s status,
     *                                                                 possibly due to active restrictions such as parental controls being in place.
     *  @constant CBManagerAuthorizationStatusDenied                User has explicitly denied this application from using bluetooth.
     *  @constant CBManagerAuthorizationStatusAuthorizedAlways        User has authorized this application to use bluetooth always.
     *
     */
    
    /**
     *  @property authorization
     *
     *  @discussion The current authorization of the manager, initially set to <code>CBManagerAuthorizationNotDetermined</code>.
     *                Updates are provided by required delegate method {@link managerDidUpdateState:}.
     *  @seealso    state
     */
    @available(macOS 10.15, iOS 13.0, *)
    var authorization: CBManagerAuthorization { get }
    
    
    /**
     *  @property authorization
     *
     *  @discussion The current authorization of the manager, initially set to <code>CBManagerAuthorizationNotDetermined</code>.
     *              You can check this in your implementation of required delegate method {@link managerDidUpdateState:}. You can also use it to check authorization status before allocating CBManager.
     *  @seealso    state
     */
    @available(macOS 10.15, iOS 13.1, *)
    static var authorization: CBManagerAuthorization { get }
    
    // MARK: - CBCentralManager
    
    /**
     *  @property delegate
     *
     *  @discussion The delegate object that will receive central events.
     *
     */
    var delegate: CBTCentralManagerDelegate? { get set }
    
    
    /**
     *  @property isScanning
     *
     *  @discussion Whether or not the central is currently scanning.
     *
     */
    @available(macOS 10.13, iOS 10, *)
    var isScanning: Bool { get }
    
#if !os(macOS)
    /**
     *  @method supportsFeatures
     *
     *  @param features    One or more features you would like to check if supported.
     *
     *  @discussion     Returns a boolean value representing the support for the provided features.
     *
     */
    @available(iOS 13.0, *)
    static func supports(_ features: CBCentralManager.Feature) -> Bool
#endif
    
    @available(macOS 10.9, iOS 10, *)
    init()
    
    
    /**
     *  @method initWithDelegate:queue:
     *
     *  @param delegate The delegate that will receive central role events.
     *  @param queue    The dispatch queue on which the events will be dispatched.
     *
     *  @discussion     The initialization call. The events of the central role will be dispatched on the provided queue.
     *                  If <i>nil</i>, the main queue will be used.
     *
     */
    @available(macOS 10.9, iOS 10, *)
    init(delegate: CBTCentralManagerDelegate?, queue: DispatchQueue?)
    
    
    /**
     *  @method initWithDelegate:queue:options:
     *
     *  @param delegate The delegate that will receive central role events.
     *  @param queue    The dispatch queue on which the events will be dispatched.
     *  @param options  An optional dictionary specifying options for the manager.
     *
     *  @discussion     The initialization call. The events of the central role will be dispatched on the provided queue.
     *                  If <i>nil</i>, the main queue will be used.
     *
     *    @seealso        CBCentralManagerOptionShowPowerAlertKey
     *    @seealso        CBCentralManagerOptionRestoreIdentifierKey
     *
     */
    @available(macOS 10.9, iOS 10, *)
    init(delegate: CBTCentralManagerDelegate?, queue: DispatchQueue?, options: [String : Any]?)
    
    
    /**
     *  @method retrievePeripheralsWithIdentifiers:
     *
     *  @param identifiers    A list of <code>NSUUID</code> objects.
     *
     *  @discussion            Attempts to retrieve the <code>CBPeripheral</code> object(s) with the corresponding <i>identifiers</i>.
     *
     *    @return                A list of <code>CBPeripheral</code> objects.
     *
     */
    @available(macOS 10.9, iOS 10, *)
    func retrievePeripherals(withIdentifiers identifiers: [UUID]) -> [CBPeripheral]
    
    
    /**
     *  @method retrieveConnectedPeripheralsWithServices
     *
     *  @discussion Retrieves all peripherals that are connected to the system and implement any of the services listed in <i>serviceUUIDs</i>.
     *                Note that this set can include peripherals which were connected by other applications, which will need to be connected locally
     *                via {@link connectPeripheral:options:} before they can be used.
     *
     *    @return        A list of <code>CBPeripheral</code> objects.
     *
     */
    @available(macOS 10.9, iOS 10, *)
    func retrieveConnectedPeripherals(withServices serviceUUIDs: [CBUUID]) -> [CBPeripheral]
    
    
    /**
     *  @method scanForPeripheralsWithServices:options:
     *
     *  @param serviceUUIDs A list of <code>CBUUID</code> objects representing the service(s) to scan for.
     *  @param options      An optional dictionary specifying options for the scan.
     *
     *  @discussion         Starts scanning for peripherals that are advertising any of the services listed in <i>serviceUUIDs</i>. Although strongly discouraged,
     *                      if <i>serviceUUIDs</i> is <i>nil</i> all discovered peripherals will be returned. If the central is already scanning with different
     *                      <i>serviceUUIDs</i> or <i>options</i>, the provided parameters will replace them.
     *                      Applications that have specified the <code>bluetooth-central</code> background mode are allowed to scan while backgrounded, with two
     *                      caveats: the scan must specify one or more service types in <i>serviceUUIDs</i>, and the <code>CBCentralManagerScanOptionAllowDuplicatesKey</code>
     *                      scan option will be ignored.
     *
     *  @see                centralManager:didDiscoverPeripheral:advertisementData:RSSI:
     *  @seealso            CBCentralManagerScanOptionAllowDuplicatesKey
     *    @seealso            CBCentralManagerScanOptionSolicitedServiceUUIDsKey
     *
     */
    @available(macOS 10.9, iOS 10, *)
    func scanForPeripherals(withServices serviceUUIDs: [CBUUID]?, options: [String : Any]?)
    
    
    /**
     *  @method stopScan:
     *
     *  @discussion Stops scanning for peripherals.
     *
     */
    @available(macOS 10.9, iOS 10, *)
    func stopScan()
    
    
    /**
     *  @method connectPeripheral:options:
     *
     *  @param peripheral   The <code>CBPeripheral</code> to be connected.
     *  @param options      An optional dictionary specifying connection behavior options.
     *
     *  @discussion         Initiates a connection to <i>peripheral</i>. Connection attempts never time out and, depending on the outcome, will result
     *                      in a call to either {@link centralManager:didConnectPeripheral:} or {@link centralManager:didFailToConnectPeripheral:error:}.
     *                      Pending attempts are cancelled automatically upon deallocation of <i>peripheral</i>, and explicitly via {@link cancelPeripheralConnection}.
     *
     *  @see                centralManager:didConnectPeripheral:
     *  @see                centralManager:didFailToConnectPeripheral:error:
     *  @seealso            CBConnectPeripheralOptionNotifyOnConnectionKey
     *  @seealso            CBConnectPeripheralOptionNotifyOnDisconnectionKey
     *  @seealso            CBConnectPeripheralOptionNotifyOnNotificationKey
     *  @seealso            CBConnectPeripheralOptionEnableTransportBridgingKey
     *    @seealso            CBConnectPeripheralOptionRequiresANCS
     *
     */
    @available(macOS 10.9, iOS 10, *)
    func connect(_ peripheral: CBPeripheral, options: [String : Any]?)
    
    
    /**
     *  @method cancelPeripheralConnection:
     *
     *  @param peripheral   A <code>CBPeripheral</code>.
     *
     *  @discussion         Cancels an active or pending connection to <i>peripheral</i>. Note that this is non-blocking, and any <code>CBPeripheral</code>
     *                      commands that are still pending to <i>peripheral</i> may or may not complete.
     *
     *  @see                centralManager:didDisconnectPeripheral:error:
     *
     */
    @available(macOS 10.9, iOS 10, *)
    func cancelPeripheralConnection(_ peripheral: CBPeripheral)
    
#if !os(macOS)
    /**
     *  @method registerForConnectionEventsWithOptions:
     *
     *  @param options        A dictionary specifying connection event options.
     *
     *  @discussion         Calls {@link centralManager:connectionEventDidOccur:forPeripheral:} when a connection event occurs matching any of the given options.
     *                      Passing nil in the option parameter clears any prior registered matching options.
     *
     *  @see                centralManager:connectionEventDidOccur:forPeripheral:
     *  @seealso            CBConnectionEventMatchingOptionServiceUUIDs
     *  @seealso            CBConnectionEventMatchingOptionPeripheralUUIDs
     */
    @available(iOS 13.0, *)
    func registerForConnectionEvents(options: [CBConnectionEventMatchingOption : Any]?)
#endif
}

public protocol CBTCentralManagerDelegate: AnyObject {
    
    /**
     *  @method centralManagerDidUpdateState:
     *
     *  @param central  The central manager whose state has changed.
     *
     *  @discussion     Invoked whenever the central manager's state has been updated. Commands should only be issued when the state is
     *                  <code>CBCentralManagerStatePoweredOn</code>. A state below <code>CBCentralManagerStatePoweredOn</code>
     *                  implies that scanning has stopped and any connected peripherals have been disconnected. If the state moves below
     *                  <code>CBCentralManagerStatePoweredOff</code>, all <code>CBPeripheral</code> objects obtained from this central
     *                  manager become invalid and must be retrieved or discovered again.
     *
     *  @see            state
     *
     */
    @available(macOS 10.7, iOS 10, *)
    func centralManagerDidUpdateState(_ central: CBTCentralManager)
    
    
    /**
     *  @method centralManager:willRestoreState:
     *
     *  @param central      The central manager providing this information.
     *  @param dict            A dictionary containing information about <i>central</i> that was preserved by the system at the time the app was terminated.
     *
     *  @discussion            For apps that opt-in to state preservation and restoration, this is the first method invoked when your app is relaunched into
     *                        the background to complete some Bluetooth-related task. Use this method to synchronize your app's state with the state of the
     *                        Bluetooth system.
     *
     *  @seealso            CBCentralManagerRestoredStatePeripheralsKey;
     *  @seealso            CBCentralManagerRestoredStateScanServicesKey;
     *  @seealso            CBCentralManagerRestoredStateScanOptionsKey;
     *
     */
    @available(macOS 10.7, iOS 10, *)
    func centralManager(_ central: CBTCentralManager, willRestoreState dict: [String : Any])
    
    
    /**
     *  @method centralManager:didDiscoverPeripheral:advertisementData:RSSI:
     *
     *  @param central              The central manager providing this update.
     *  @param peripheral           A <code>CBPeripheral</code> object.
     *  @param advertisementData    A dictionary containing any advertisement and scan response data.
     *  @param RSSI                 The current RSSI of <i>peripheral</i>, in dBm. A value of <code>127</code> is reserved and indicates the RSSI
     *                                was not available.
     *
     *  @discussion                 This method is invoked while scanning, upon the discovery of <i>peripheral</i> by <i>central</i>. A discovered peripheral must
     *                              be retained in order to use it; otherwise, it is assumed to not be of interest and will be cleaned up by the central manager. For
     *                              a list of <i>advertisementData</i> keys, see {@link CBAdvertisementDataLocalNameKey} and other similar constants.
     *
     *  @seealso                    CBAdvertisementData.h
     *
     */
    @available(macOS 10.7, iOS 10, *)
    func centralManager(_ central: CBTCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber)
    
    
    /**
     *  @method centralManager:didConnectPeripheral:
     *
     *  @param central      The central manager providing this information.
     *  @param peripheral   The <code>CBPeripheral</code> that has connected.
     *
     *  @discussion         This method is invoked when a connection initiated by {@link connectPeripheral:options:} has succeeded.
     *
     */
    @available(macOS 10.7, iOS 10, *)
    func centralManager(_ central: CBTCentralManager, didConnect peripheral: CBPeripheral)
    
    
    /**
     *  @method centralManager:didFailToConnectPeripheral:error:
     *
     *  @param central      The central manager providing this information.
     *  @param peripheral   The <code>CBPeripheral</code> that has failed to connect.
     *  @param error        The cause of the failure.
     *
     *  @discussion         This method is invoked when a connection initiated by {@link connectPeripheral:options:} has failed to complete. As connection attempts do not
     *                      timeout, the failure of a connection is atypical and usually indicative of a transient issue.
     *
     */
    @available(macOS 10.7, iOS 10, *)
    func centralManager(_ central: CBTCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?)
    
    
    /**
     *  @method centralManager:didDisconnectPeripheral:error:
     *
     *  @param central      The central manager providing this information.
     *  @param peripheral   The <code>CBPeripheral</code> that has disconnected.
     *  @param error        If an error occurred, the cause of the failure.
     *
     *  @discussion         This method is invoked upon the disconnection of a peripheral that was connected by {@link connectPeripheral:options:}. If the disconnection
     *                      was not initiated by {@link cancelPeripheralConnection}, the cause will be detailed in the <i>error</i> parameter. Once this method has been
     *                      called, no more methods will be invoked on <i>peripheral</i>'s <code>CBPeripheralDelegate</code>.
     *
     */
    @available(macOS 10.7, iOS 10, *)
    func centralManager(_ central: CBTCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?)
    
#if !os(macOS)
    /**
     *  @method centralManager:connectionEventDidOccur:forPeripheral:
     *
     *  @param central      The central manager providing this information.
     *  @param event        The <code>CBConnectionEvent</code> that has occurred.
     *  @param peripheral   The <code>CBPeripheral</code> that caused the event.
     *
     *  @discussion         This method is invoked upon the connection or disconnection of a peripheral that matches any of the options provided in {@link registerForConnectionEventsWithOptions:}.
     *
     */
    @available(iOS 13.0, *)
    func centralManager(_ central: CBTCentralManager, connectionEventDidOccur event: CBConnectionEvent, for peripheral: CBPeripheral)
    
    /**
     *  @method centralManager:didUpdateANCSAuthorizationForPeripheral:
     *
     *  @param central      The central manager providing this information.
     *  @param peripheral   The <code>CBPeripheral</code> that caused the event.
     *
     *  @discussion         This method is invoked when the authorization status changes for a peripheral connected with {@link connectPeripheral:} option {@link CBConnectPeripheralOptionRequiresANCS}.
     *
     */
    @available(iOS 13.0, *)
    func centralManager(_ central: CBTCentralManager, didUpdateANCSAuthorizationFor peripheral: CBPeripheral)
#endif
}

// MARK: - Implement optional methods for the protocol

public extension CBTCentralManagerDelegate {
    func centralManager(_ central: CBTCentralManager, willRestoreState dict: [String : Any]) {}
    func centralManager(
        _ central: CBTCentralManager,
        didDiscover peripheral: CBPeripheral,
        advertisementData: [String : Any],
        rssi RSSI: NSNumber
    ) {}
    func centralManager(_ central: CBTCentralManager, didConnect peripheral: CBPeripheral) {}
    func centralManager(
        _ central: CBTCentralManager,
        didFailToConnect peripheral: CBPeripheral,
        error: Error?
    ) {}
    func centralManager(
        _ central: CBTCentralManager,
        didDisconnectPeripheral peripheral: CBPeripheral,
        error: Error?
    ) {}
#if !os(macOS)
    func centralManager(
        _ central: CBTCentralManager,
        connectionEventDidOccur event: CBConnectionEvent,
        for peripheral: CBPeripheral
    ) {}
    func centralManager(
        _ central: CBTCentralManager,
        didUpdateANCSAuthorizationFor peripheral: CBPeripheral
    ) {}
#endif
    
}


final class TCBCentralManagerImpl: NSObject, CBTCentralManager, CBCentralManagerDelegate {
    private var manager: CBCentralManager?
    
    var eventsHandler: (TelemetryEvent) -> Void = { _ in }
    
    // MARK: - CBManager
    
    @available(macOS 10.13, iOS 10.0, *)
    var state: CBManagerState { manager?.state ?? .unknown}
    
    @available(macOS 10.15, iOS 13.0, *)
    var authorization: CBManagerAuthorization { manager?.authorization ?? .notDetermined }
    
    @available(macOS 10.15, iOS 13.1, *)
    class var authorization: CBManagerAuthorization { CBCentralManager.authorization }
    
    
    // MARK: - CBCentralManager
    
    @available(macOS 10.7, iOS 10, *)
    weak var delegate: CBTCentralManagerDelegate?
    
    @available(macOS 10.13, iOS 10, *)
    var isScanning: Bool { manager?.isScanning ?? false}
    
#if !os(macOS)
    @available(iOS 13.0, *)
    static func supports(_ features: CBCentralManager.Feature) -> Bool {
        CBCentralManager.supports(features)
    }
#endif
    
    public convenience override init() {
        if #available(macOS 10.9, iOS 10, *) {
            self.init(delegate: nil, queue: nil, options: nil)
        } else {
            preconditionFailure("Inti is not available, see @available(macOS 10.9, iOS 10, *)")
        }
    }
    
    @available(macOS 10.9, iOS 10, *)
    public convenience init(delegate: CBTCentralManagerDelegate?, queue: DispatchQueue?) {
        self.init(delegate: delegate, queue: queue, options: nil)
    }
    
    @available(macOS 10.9, iOS 10, *)
    public init(
        delegate: CBTCentralManagerDelegate?,
        queue: DispatchQueue?,
        options: [String : Any]?
    ) {
        self.delegate = delegate
        super.init()
        let manager = CBCentralManager(
            delegate: self,
            queue: queue,
            options: options
        )
        self.manager = manager
    }
    
    @available(macOS 10.9, iOS 10, *)
    func retrievePeripherals(withIdentifiers identifiers: [UUID]) -> [CBPeripheral] {
        manager?.retrievePeripherals(withIdentifiers: identifiers) ?? []
    }
    
    @available(macOS 10.9, iOS 10, *)
    func retrieveConnectedPeripherals(withServices serviceUUIDs: [CBUUID]) -> [CBPeripheral] {
        manager?.retrieveConnectedPeripherals(withServices: serviceUUIDs) ?? []
    }
    
    @available(macOS 10.9, iOS 10, *)
    func scanForPeripherals(withServices serviceUUIDs: [CBUUID]?, options: [String : Any]? = nil) {
        manager?.scanForPeripherals(withServices: serviceUUIDs, options: options)
    }
    
    @available(macOS 10.9, iOS 10, *)
    func stopScan() {
        manager?.stopScan()
    }
    
    @available(macOS 10.9, iOS 10, *)
    func connect(_ peripheral: CBPeripheral, options: [String : Any]? = nil) {
        manager?.connect(peripheral, options: options)
    }
    
    @available(macOS 10.9, iOS 10, *)
    func cancelPeripheralConnection(_ peripheral: CBPeripheral) {
        manager?.cancelPeripheralConnection(peripheral)
    }
    
    @available(macOS, unavailable, message: "iOS only")
    @available(iOS 13.0, *)
    func registerForConnectionEvents(options: [CBConnectionEventMatchingOption : Any]?) {
        manager?.registerForConnectionEvents(options: options)
    }
    
    // MARK: - CBCentralManagerDelegate
    
    @objc @available(macOS 10.7, iOS 10, *)
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        delegate?.centralManagerDidUpdateState(self)
    }
    
    @objc @available(macOS 10.7, iOS 10, *)
    func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
        delegate?.centralManager(self, willRestoreState: dict)
    }
    
    @objc @available(macOS 10.7, iOS 10, *)
    func centralManager(
        _ central: CBCentralManager,
        didDiscover peripheral: CBPeripheral,
        advertisementData: [String : Any],
        rssi RSSI: NSNumber
    ) {
        delegate?.centralManager(
            self,
            didDiscover: peripheral,
            advertisementData: advertisementData,
            rssi: RSSI
        )
    }
    
    @objc @available(macOS 10.7, iOS 10, *)
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        delegate?.centralManager(self, didConnect: peripheral)
    }
    
    @objc @available(macOS 10.7, iOS 10, *)
    func centralManager(
        _ central: CBCentralManager,
        didFailToConnect peripheral: CBPeripheral,
        error: Error?
    ) {
        delegate?.centralManager(self, didFailToConnect: peripheral, error: error)
    }
    
    @objc @available(macOS 10.7, iOS 10, *)
    func centralManager(
        _ central: CBCentralManager,
        didDisconnectPeripheral peripheral: CBPeripheral,
        error: Error?
    ) {
        delegate?.centralManager(self, didDisconnectPeripheral: peripheral, error: error)
    }
    
    // MARK: - iOS only
    
#if !os(macOS)
    @available(iOS 13.0, *)
    func centralManager(
        _ central: CBCentralManager,
        connectionEventDidOccur event: CBConnectionEvent,
        for peripheral: CBPeripheral
    ) {
        delegate?.centralManager(self, connectionEventDidOccur: event, for: peripheral)
    }
    
    @objc @available(macOS, unavailable, message: "iOS only")
    @available(iOS 13.0, *)
    func centralManager(
        _ central: CBCentralManager,
        didUpdateANCSAuthorizationFor peripheral: CBPeripheral
    ) {
        delegate?.centralManager(self, didUpdateANCSAuthorizationFor: peripheral)
    }
#endif
}


//: [Next](@next)
