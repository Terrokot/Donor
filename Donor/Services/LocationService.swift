//
//  LocationService.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/2/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit


class LocationService: NSObject {
    
    var newestLocation: ((CLLocationCoordinate2D?) -> Void)?
    var statusUpdated: ((CLAuthorizationStatus) -> Void)?
    let manager: CLLocationManager
    
    var status: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    init(manager: CLLocationManager = CLLocationManager()) {
        self.manager = manager
        super.init()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        
        
        
    }
    func getPermission() {
        manager.requestWhenInUseAuthorization()
    }
    
    
    func getLocation() {
        manager.requestLocation()
    }
    
    func addAnnotation(coordinate: CLLocationCoordinate2D, map:MKMapView, userLocation: inout CLLocationCoordinate2D) {
        let center = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        userLocation = center
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        map.setRegion(region, animated: true)
        map.removeAnnotations(map.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "Your Location"
        map.addAnnotation(annotation)
        
    }
    
}

