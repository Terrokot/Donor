//
//  DonorViewController.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/8/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import UIKit
import CoreLocation
import FirebaseAuth
import FirebaseDatabase

class DonorViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var patientsRequests : [DataSnapshot] = []
    let locationService = LocationService()
    var donorLocation = CLLocationCoordinate2D()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}

extension DonorViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        let driverCLLocation = CLLocation(latitude: donorLocation.latitude, longitude: donorLocation.longitude)
        cell.textLabel?.text = "\(driverCLLocation.coordinate)"
        return cell
    }
}

extension DonorViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
          if let coord = manager.location?.coordinate {
              donorLocation = coord
          }
      }
    
}
