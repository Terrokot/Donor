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
    
    
    var patientsRequest : [DataSnapshot] = [] // change for dict
    let locationService = LocationService()
    var donorLocation = CLLocationCoordinate2D()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Location
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
        
        Database.database().reference().child("PatientsRequests").observe(.childAdded) { (DataSnapshot) in
            self.patientsRequest.append(DataSnapshot)
            self.tableView.reloadData()
        }
        
        Database.database().reference().child("PatientsRequests").observe(.childRemoved) { (snapshot) in
            self.patientsRequest.removeAll {$0.key == snapshot.key}
            print(snapshot.key)
            self.tableView.reloadData()

        }
        
         //MARK: TableView Timer
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (timer) in
            self.tableView.reloadData()
        }
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        try? Auth.auth().signOut()
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

//MARK: CLLocationManagerDelegate
extension DonorViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coord = manager.location?.coordinate {
            donorLocation = coord
        }
    }
}
