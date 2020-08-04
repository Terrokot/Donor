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
    
    @IBOutlet weak var topView: TopView!
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var findDonorButton: HeartButton!
    @IBOutlet var requestStatusLabel: UILabel!
    
    override var shouldAutorotate: Bool { return false }
    
    var ref: DatabaseReference!
    
    let locationService  = LocationService()
    var userLocation     = CLLocationCoordinate2D()
    var patientData      = Patient()
    var requestHasBeenSent = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topViewSetup()
        topView.delegate = self
        
        ref = Database.database().reference()
        readFromDefaults()
        
        // Location service
        locationService.manager.delegate = self
        if let coordinate = locationService.manager.location?.coordinate {
            locationService.setRegion(coordinate: coordinate, map: map)
        }
        
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
    
    
    @IBAction func showMyLocationTapped(_ sender: Any) {
        locationService.setRegion(coordinate: userLocation, map: map)
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

//MARK: Top View Delegate & Setup

extension PatientViewController: TopViewDelegate {
    
    func leftAction() {
        _Defaults.clearAll()
        try? Auth.auth().signOut()
        dismiss(animated: true, completion: nil)
    }
    
    func rightAction() {
        openSettings()
    }
    
    fileprivate func topViewSetup() {
        let leftImage   = UIImage(named: R.image.logoutBtn.name)
        let rightImage  = UIImage(named: R.image.settingsBtn.name)
        
        topView.leftButton.setImage(leftImage, for: .normal)
        topView.rightButton.setImage(rightImage, for: .normal)
        
        topView.rightButtonWidthConstraint.constant = 26
        topView.rightButtonHeightConstraint.constant = 26
        
        topView.mailLabelText          = "Profile"
        topView.secondLabelText        = "Fill the form"
        
        topView.leftButton.isHidden    = false
        topView.rightButton.isHidden   = false
        
        topView.leftButton.tintColor   = .white
        topView.rightButton.tintColor  = .white
    }
}

