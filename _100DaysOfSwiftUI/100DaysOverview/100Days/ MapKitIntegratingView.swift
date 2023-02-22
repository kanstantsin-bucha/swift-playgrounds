//
//   MapKitIntegratingView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 21/02/2023.
//
import MapKit
import SwiftUI

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapKitIntegratingView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.08, longitude: 17.02), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    let locations: [Location] = [
        .init(name: "Wrocłavia", coordinate: CLLocationCoordinate2D(latitude: 51.097, longitude: 17.035)),
        .init(name: "Aquapark Wrocław", coordinate: CLLocationCoordinate2D(latitude: 51.092, longitude: 17.031)),
        .init(name: "Park Południowy", coordinate: CLLocationCoordinate2D(latitude: 51.075, longitude: 17.011)),
    ]
    
    var body: some View {
        Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
            MapAnnotation(coordinate: location.coordinate) {
                Image(systemName: "mappin.and.ellipse")
                    .foregroundColor(.red)
                    .onTapGesture {
                        print(location.name)
                    }
            }
            
        }
    }
}

struct MapKitIntegratingView_Previews: PreviewProvider {
    static var previews: some View {
        MapKitIntegratingView()
    }
}
