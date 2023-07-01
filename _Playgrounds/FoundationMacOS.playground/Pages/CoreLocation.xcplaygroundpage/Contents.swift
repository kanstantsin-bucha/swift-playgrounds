//: [Previous](@previous)

import Foundation
import Cocoa
import CoreLocation

extension String {
    func doubleValue() -> Double {
        return (self as NSString).doubleValue
    }
}

var shouldKeepRunning = true
let runLoop = RunLoop.current
let distantFuture = Date.distantFuture

let args = CommandLine.arguments

if args.count != 3 {
    print("usage: \(args[0]) <lat> <lon>")
    exit(-1)
}

let lat: Double = Double(args[1].doubleValue())
let lon: Double = Double(args[2].doubleValue())

let location = CLLocation(latitude: lat, longitude: lon)
let geocoder = CLGeocoder()
geocoder.reverseGeocodeLocation(location) { placemarks, error in
    if let error {
        print("\(error)")
        return
    }
    placemarks?.forEach { placemark in
        print("ISOcountryCode:     \(String(describing: placemark.isoCountryCode))")
        print("country:            \(String(describing: placemark.country))")
        print("postalCode:         \(String(describing: placemark.postalCode))")
        print("administrativeArea: \(String(describing: placemark.administrativeArea))")
        print("locality:           \(String(describing: placemark.locality))")
        print("subLocality:        \(String(describing: placemark.subLocality))")
        print("subThoroughfare:    \(String(describing: placemark.subThoroughfare))")
    }
    shouldKeepRunning = false
}

//while shouldKeepRunning == true &&
//        runLoop.run(mode: .default, before: distantFuture) {}

//: [Next](@next)
