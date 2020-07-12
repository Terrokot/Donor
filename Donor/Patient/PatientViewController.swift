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
    
    @IBOutlet var bloodTypeLabel: UILabel!
    
    
    var ref: DatabaseReference!
    
    let locationService = LocationService()
    var userLocation = CLLocationCoordinate2D()
    var requestHasBeenSent = false
    var patientData = PatientDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
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
        
        
        if let email = Auth.auth().currentUser?.email {
            ref.child("PatientsRequests").queryOrdered(byChild: "email").queryEqual(toValue: email).observe(.childAdded, with: { (snapshot) in
                self.requestHasBeenSent = true
                self.findDonorButton.setTitle("Cancel Uber", for: .normal)
                self.ref.child("PatientsRequests").removeAllObservers()
                
                
            })
        }
    }
    
    @IBAction func findDonorTapped(_ sender: Any) {
        guard let email = Auth.auth().currentUser?.email else { return }
        if requestHasBeenSent {
            findDonorButton.setTitle("Find Donor", for: .normal)
            requestHasBeenSent = false
            ref.child("PatientsRequests").queryOrdered(byChild: "email").queryEqual(toValue: email).observe(.childAdded, with: { (snapshot) in
                snapshot.ref.removeValue()
                self.ref.child("PatientsRequests").removeAllObservers()
            })
        } else {
            let patientRequestDictionary : [String: Any] = ["email": email, "bloodType": "A+", "latitude": userLocation.latitude, "longitude": userLocation.longitude]
            ref.child("PatientsRequests").childByAutoId().setValue(patientRequestDictionary)
            findDonorButton.setTitle("Cancel Request", for: .normal)
            requestHasBeenSent = true
        }
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        try? Auth.auth().signOut()
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @available(iOS 13.0, *)
    @IBAction func selectBloodTypeTapped(_ sender: Any) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "PickerViewController") as! PickerViewController
        vc.pickerViewControllerDelegate = self
        present(vc, animated: true, completion: nil)
    }
}
extension PatientViewController: PickerViewControllerDelegate {
    func sendData(_ data: PatientDataModel) {
        patientData = data
        bloodTypeLabel.text = data.bloodType
        print(data)
    }
    
    
}

