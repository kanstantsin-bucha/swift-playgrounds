//: [Previous](@previous)

import Foundation
import Cocoa
import CoreBluetooth

let runLoop = RunLoop.current
let distantFuture = Date.distantFuture
let args = CommandLine.arguments

class PheripheralDelegate: NSObject, CBPeripheralManagerDelegate {
    var didUpdateStateHandler: ((CBPeripheralManager) -> Void)?
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        didUpdateStateHandler?(peripheral)
    }
}

class App {
    let heartRateServiceCBUUID = CBUUID(string: "0x180D")
    private(set) var isRunning = true
    private let pheripheral = CBPeripheralManager()
    private let delegate = PheripheralDelegate()
    private var service: CBMutableService {
        CBMutableService(type: heartRateServiceCBUUID, primary: true)
    }
    
    deinit {
        pheripheral.stopAdvertising()
        pheripheral.removeAllServices()
    }
    
    init() {
        pheripheral.delegate = delegate
        delegate.didUpdateStateHandler = { [weak self] pheripheral in
            guard let self else { return }
            guard pheripheral.state == .poweredOn else {
                print("pheripheral: invalid state")
                return
            }
            pheripheral.add(self.service)
            let data: [String: Any] = [
                CBAdvertisementDataLocalNameKey: "M HeartMonitor",
                CBAdvertisementDataServiceUUIDsKey: [self.heartRateServiceCBUUID]
            ]
            pheripheral.startAdvertising(data)
            print("pheripheral: started advertisement")
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10)) {
                self.isRunning = false
            }
        }
        print("app: inited")
    }
}

let app = App()

while app.isRunning &&
        runLoop.run(mode: .default, before: distantFuture) {}

print("exit")

exit(0)

//: [Next](@next)
