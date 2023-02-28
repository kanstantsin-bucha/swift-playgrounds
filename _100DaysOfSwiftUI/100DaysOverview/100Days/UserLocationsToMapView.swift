//
//  UserLocationsToMapView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 22/02/2023.
//
import MapKit
import SwiftUI

struct UserLocationsToMapView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.093, longitude: 17.030), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @State private var locations = [SecondLocation]()
    @State private var selectedPlace: SecondLocation?
    
    private var region : Binding<MKCoordinateRegion> {
        Binding {
            mapRegion
        } set: { region in
            DispatchQueue.main.async {
                mapRegion = region
            }
        }
    }
    var body: some View {
        ZStack {
            Map(coordinateRegion: region, annotationItems: locations ) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    VStack {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(Circle())
                        Text(location.name)
                            .fixedSize()
                    }
                    .onTapGesture {
                        selectedPlace = location
                    }
                }
            }
                .ignoresSafeArea()
            Circle()
                .fill(.blue)
                .opacity(0.3)
                .frame(width: 50, height: 50)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        let newLocation = SecondLocation(id: UUID(), name: "New location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
                        locations.append(newLocation)
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                    .padding()
                    .background(.black.opacity(0.5))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding()
                }
            }
        }
        .sheet(item: $selectedPlace) { place in
            EditView(location: place) { newLocation in
                if let index = locations.firstIndex(of: place) {
                    locations[index] = newLocation
                }
            }
        }
    }
}

struct UserLocationsToMapView_Previews: PreviewProvider {
    static var previews: some View {
        UserLocationsToMapView()
    }
}
