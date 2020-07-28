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
    
    func updateUserLocation(coordinate: CLLocationCoordinate2D, userLocation: inout CLLocationCoordinate2D) {
        let center = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        userLocation = center
        print(userLocation)
        //let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        //map.setRegion(region, animated: true)
        
       // map.removeAnnotations(map.annotations)
        //  let annotation = MKPointAnnotation()
        //  annotation.coordinate = center
        //  annotation.title = "Your Location"
        //  map.addAnnotation(annotation)
    }
    
    func setRegion(coordinate: CLLocationCoordinate2D, map:MKMapView) {
           let center = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
           let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
           map.setRegion(region, animated: true)
    }
    
    
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.sorted(by: { $0.timestamp > $1.timestamp }).first {
            self.newestLocation?(location.coordinate)
        } else {
            self.newestLocation?(nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get the user loction: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Location status: \(status)")
        self.statusUpdated?(status)
    }
    
}


