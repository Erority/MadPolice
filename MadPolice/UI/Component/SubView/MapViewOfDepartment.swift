//
//  MapViewOfDepartment.swift
//  MadPolice
//
//  Created by Денис Большачков on 06.03.2022.
//

import SwiftUI
import MapKit



struct MapViewOfDepartment: UIViewRepresentable {
    @StateObject var mapData = ShowDepartmentViewModel()
    
    func viewDidLoad() {
        
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    func makeUIView(context: Context) -> some MKMapView {
        let view = mapData.mapView
        
        view.showsUserLocation = true
        view.delegate = context.coordinator
        
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer{
            let render = MKPolylineRenderer(overlay: overlay)
            render.strokeColor = .blue
            render.lineWidth = 2
            return render
        }
    }
    
}

