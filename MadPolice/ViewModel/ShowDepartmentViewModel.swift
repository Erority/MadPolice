//
//  ShowDepartmentViewModel.swift
//  MadPolice
//
//  Created by Денис Большачков on 03.03.2022.
//

import MapKit
import Foundation

final class ShowDepartmentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var mapView = MKMapView()
    @Published var region: MKCoordinateRegion!
    
    @Published var locationManager = CLLocationManager()
    
    @Published var permissionDenied: Bool = false
    
    @Published var currentViewIsINFO = true
    
    @Published var coordsOfDepartment: CLLocationCoordinate2D?
    @Published var nameOfDepartment: String?
    
    @Published var userLocation: CLLocationCoordinate2D?
    
    func focusLocation(){
        guard let _ = region else { return }
        mapView.setRegion(region, animated: true )
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    func calculateCoordsOfDepartment(depCoords: String){
        let coordsDouble = getCoordsFromString(stringCoords: depCoords)
        self.coordsOfDepartment = CLLocationCoordinate2D.init(latitude: coordsDouble[0], longitude: coordsDouble[1])
    }

    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        //Checking permissions
        switch manager.authorizationStatus{
        case .notDetermined:
            manager .requestWhenInUseAuthorization()
        case .restricted:
            print("")
        case .denied:
            permissionDenied.toggle()
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        @unknown default:
            break
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last else { return }

        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)

        userLocation = location.coordinate
        
        self.mapView.setRegion(self.region, animated: true)

        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
    }
    
    func getCoordsFromString(stringCoords: String) -> [Double] {
        var prepareString = stringCoords
        
        prepareString.removeFirst()
        prepareString.removeLast()
        
        var arrString = prepareString.components(separatedBy: ",")
        
        arrString[1].removeFirst()
        
        var toRet = [Double]()
        toRet.append(Double(arrString[0])!)
        toRet.append(Double(arrString[1])!)
        
        return toRet
        
    }
    

    func createRoutes(destination: CLLocationCoordinate2D) -> MKMapView{
        
        let mapView = self.mapView
        
        let p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 23.12, longitude: 32.23))
        
        let p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 42.36, longitude: -71.05))
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: p1)
        request.destination = MKMapItem(placemark: p2)
        request.transportType = .automobile
        
        
        
        let direcitons = MKDirections(request: request)
        direcitons.calculate { response, error in
            guard let route = response?.routes.first else { return }
            mapView.addAnnotations([p1, p2])
            mapView.addOverlay(route.polyline)
            mapView.setVisibleMapRect(
                route.polyline.boundingMapRect,
                edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20) ,
                animated: true)
        }
     
        return mapView
    }
    
    
    func setNameDepartmen(depName: String){
        self.nameOfDepartment = depName
    }
}

