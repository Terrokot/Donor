//
//  PatientViewController.swift
//  Donor
//
//  Created by Egor Tereshonok on 6/27/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import UIKit
import MapKit
import FirebaseAuth
import FirebaseDatabase


class PatientViewController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var findDonorButton: UIButton!
    
    let locationService = LocationService()
    var userLocation = CLLocationCoordinate2D()
    var requestHasBeenSent = false

    
    override func viewDidLoad() {
        super.viewDidLoad()        
        // Location service
        locationService.manager.delegate = self
        
        switch locationService.status {
        case .notDetermined:
            locationService.getPermission()
        case .authorizedWhenInUse:
            break
        case .restricted:
            print("Get permission in settings")
        case .denied:
            print("Get permission in settings")
            
        default: assertionFailure("Location is: \(locationService.status)")
        }
    }
        
    @IBAction func findDonorTapped(_ sender: Any) {
        guard let email = Auth.auth().currentUser?.email else { return }

        let patientRequestDictionary : [String: Any] = ["email": email, "bloodType": "A+", "latitude": userLocation.latitude, "longitude": userLocation.longitude]
        Database.database().reference().child("PatientsRequests").childByAutoId().setValue(patientRequestDictionary)
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
    }
    
}


