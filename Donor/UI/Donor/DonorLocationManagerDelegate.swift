//
//   DonorLocationManagerDelegate.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/20/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import Foundation
import CoreLocation

//MARK: CLLocationManagerDelegate
extension DonorViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coord = manager.location?.coordinate {
            donorLocation = coord
        }
    }
}
