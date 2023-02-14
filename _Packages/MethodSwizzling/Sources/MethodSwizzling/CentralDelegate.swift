
import CoreBluetooth
import Foundation

class CentralDelegate: NSObject, CBCentralManagerDelegate {
    var onPoweredOn: () -> Void = {}
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("centralManagerDidUpdateState \(central.state)")
        if central.state == .poweredOn {
            onPoweredOn()
        }
    }
    
    func centralManager(
        _ central: CBCentralManager,
        didDiscover peripheral: CBPeripheral,
        advertisementData: [String : Any],
        rssi RSSI: NSNumber
    ) {
        print("didDiscover \(peripheral.identifier) rssi: \(RSSI)")
    }
}
