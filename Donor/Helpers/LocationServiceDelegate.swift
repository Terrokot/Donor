//
//  LocationServiceDelegate.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/2/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import Foundation
import CoreLocation

extension PatientViewController: CLLocationManagerDelegate  {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coord = manager.location?.coordinate {
            locationService.addAnnotation(coordinate: coord,
                                          map: map,
                                          userLocation: &userLocation
            )

        }
    }
  
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get the user loction: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Location status: \(status.rawValue)")
        locationService.statusUpdated?(status)
    }
}
