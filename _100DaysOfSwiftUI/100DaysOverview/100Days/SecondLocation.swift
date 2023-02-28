//
//  Location.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 22/02/2023.
//
import MapKit
import Foundation

struct SecondLocation: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = SecondLocation(id: UUID(), name: "Home", description: "Apartment to rent", latitude: 51.083, longitude: 17.026)
}
