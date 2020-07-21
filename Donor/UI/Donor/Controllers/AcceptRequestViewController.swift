//
//  AcceptRequestViewController.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/8/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class AcceptRequestViewController: UIViewController {
    
    
    
    @IBOutlet weak var map: MKMapView!
    
    
    var requestLocation = CLLocationCoordinate2D()
    var DonorLocation = CLLocationCoordinate2D()
    var requestEmail = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //make manager
        let region = MKCoordinateRegion(center: requestLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        map.setRegion(region, animated: false)
        
        // make manager
        MapManager.addAnnotation(map: map, coordinate: requestLocation, title: requestEmail)
    
    }
    
    @IBAction func acceptButtonTapped(_ sender: Any) {
        //sent location
    }
    
    @IBAction func makeCallTapped(_ sender: Any) {
        //make call
    }
    
    @IBAction func openMapsTapped(_ sender: Any) {
        //open apple maps
    }
    
    
    

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
