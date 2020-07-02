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
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func findDonorTapped(_ sender: Any) {
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


