import CoreBluetooth
import Foundation

let delegate = CentralDelegate()
let manager = CBCentralManager(delegate: delegate, queue: nil)
let swizzler = CBCentralManagerSwizzler()
swizzler.startIntercepting()
delegate.onPoweredOn = {
    print("onPoweredOn called")
    manager.scanForPeripherals(withServices: nil)
}

let runLoop = RunLoop.current
let distantFuture = Date.distantFuture
fputs("[Swift] [Run] Started the app. Entering RunLoop. \n", stdout)
while true &&
        runLoop.run(mode: .default, before: distantFuture) {
    print("[Swift] [Run] Runloop event handled")
}

