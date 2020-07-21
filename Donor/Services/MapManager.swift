//
//  MapManager.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/21/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import Foundation
import MapKit

class MapManager {
    
    private init() {}
    
    static func addAnnotation(map: MKMapView, coordinate: CLLocationCoordinate2D, title: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        map.addAnnotation(annotation)
    }
}
