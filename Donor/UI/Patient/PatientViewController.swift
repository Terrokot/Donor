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
    @IBOutlet weak var findDonorButton: HeartButton!
    @IBOutlet var requestStatusLabel: UILabel!
    
    
    var ref: DatabaseReference!
    
    let locationService = LocationService()
    var userLocation = CLLocationCoordinate2D()
    var requestHasBeenSent = false
    var patientData = Patient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        print("KOK")
        readFromDefaults()
        
        // Location service
        locationService.manager.delegate = self
        
        if let email = Auth.auth().currentUser?.email {
            ref.child("PatientsRequests").queryOrdered(byChild: "email").queryEqual(toValue: email).observe(.childAdded, with: { (snapshot) in
                self.requestHasBeenSent = true
                self.requestStatusLabel.text = "Cancel Request"
                self.findDonorButton.cancelMode() // MARK: Button switch mode
                self.ref.child("PatientsRequests").removeAllObservers()
            })
        }
    }
    
    @IBAction func findDonorTapped(_ sender: Any) {
        
        guard let email = Auth.auth().currentUser?.email else { return }
        if requestHasBeenSent {
            self.requestStatusLabel.text = "Find a Donor"
            self.findDonorButton.setup()
            self.findDonorButton.acceptMode() //MARK: Button switch mode
            requestHasBeenSent = false
            ref.child("PatientsRequests").queryOrdered(byChild: "email").queryEqual(toValue: email).observe(.childAdded, with: { (snapshot) in
                snapshot.ref.removeValue()
                self.ref.child("PatientsRequests").removeAllObservers()
            })
        } else {
            guard let name  = patientData.name else {
                openSettings()
                return
            }
            if name == "" {
                openSettings()
                return
            }
            let patientRequestDictionary : [String: Any] = [ "email": email,
                                                             "name": name,
                                                             "phoneNumber": patientData.phoneNumber,
                                                             "bloodType": patientData.bloodType.rawValue,
                                                             "latitude": userLocation.latitude,
                                                             "longitude": userLocation.longitude ]
            
            ref.child("PatientsRequests").childByAutoId().setValue(patientRequestDictionary)
            self.requestStatusLabel.text = "Cancel Request"
            self.findDonorButton.cancelMode() // MARK: Button switch mode
            requestHasBeenSent = true
            AlertManager.displayAlert(title: "Your request is registered", message: "We are already looking for a donor for you. You will be contacted soon")
        }
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        _Defaults.clearAll()
        try? Auth.auth().signOut()
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectBloodTypeTapped(_ sender: Any) {
        openSettings()
    }
    
    private func openSettings() {
        let vc = R.storyboard.patient.pickerViewController()!
        vc.data.name        = patientData.name
        vc.data.phoneNumber = patientData.phoneNumber
        vc.pickerViewControllerDelegate = self
        present(vc, animated: true, completion: nil)
    }
    //MARK: Defaults 
     func readFromDefaults() {
        patientData.name        =  Defaults["userName"]         ?? ""
        patientData.bloodType   =  Defaults["userBloodType"]    ?? Blood.O_minus
        patientData.phoneNumber =  Defaults["userPhoneNumber"]  ?? ""
    }
}
extension PatientViewController: PickerViewControllerDelegate {
    func sendData(_ data: Patient) {
        patientData = data
        //equestStatusLabel.text = "You blood type: \(data.bloodType.rawValue)"
        print(data)
    }
}

