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
import FirebaseDatabase

class AcceptRequestViewController: UIViewController {
    
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var titleNavigationItem: UINavigationItem!
    @IBOutlet weak var requestAcceptButton: UIButton!
    
    var dataBaseRef: DatabaseReference!
    
    var requestLocation = CLLocationCoordinate2D()
    var donorLocation = CLLocationCoordinate2D()
    var requestEmail = ""
    var requestPhoneNumber = ""
    var acceptionStatus = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataBaseRef =  Database.database().reference().child("PatientsRequests")
        
        let region = MKCoordinateRegion(center: requestLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        map.setRegion(region, animated: false)
        MapManager.addAnnotation(map: map, coordinate: requestLocation, title: requestEmail)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userDefaults = UserDefaults.standard
        let acceptAnyRequest = userDefaults.bool(forKey: "acceptAnyRequest")
        let acceptionStatus = userDefaults.bool(forKey: requestEmail) //for key email
        
        if acceptAnyRequest, acceptionStatus {
            requestAcceptButton.setTitle("Cancel", for: .normal)
        }
    }
    
    
    
    @IBAction func acceptButtonTapped(_ sender: Any) {
        //MARK: ACCEPT
        
        let userDefaults = UserDefaults.standard
        let acceptionStatus = userDefaults.bool(forKey: requestEmail) //for key email
        let acceptAnyRequest = userDefaults.bool(forKey: "acceptAnyRequest")
        
        if !acceptAnyRequest, !acceptionStatus  {
            
            // Update the Request
            dataBaseRef.queryOrdered(byChild: "email").queryEqual(toValue: requestEmail).observe(.childAdded) { (snapshot) in
                snapshot.ref.updateChildValues(["donorLat":self.donorLocation.latitude, "donorLon":self.donorLocation.longitude])
                self.dataBaseRef.removeAllObservers()
            }
            
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: requestEmail)
            userDefaults.set(true, forKey: "acceptAnyRequest")
            requestAcceptButton.setTitle("Cancel", for: .normal)
            AlertManager.displayAlert(title: "You accept the request", message: "Don't forget. Donor is waiting you", vc: self)
            
            
            
        } else {
            if acceptionStatus {
                let userDefaults = UserDefaults.standard
                userDefaults.set(false, forKey: requestEmail)
                userDefaults.set(false, forKey: "acceptAnyRequest")
                requestAcceptButton.setTitle("Accept Request", for: .normal)
                
            } else {
                AlertManager.displayAlert(title: "error", message: "You can't accept more than 1 request", vc: self)
            }
            
            //AlertManager.displayAlert(title: "You accept the request", message: "Don't forget that donor is waiting you", vc: self)
            
        }
        // not shure that we need this button
        
    }
    
    @IBAction func openMapsTapped(_ sender: Any) {
        //MARK: MAPS
        
        let requestCLLocation = CLLocation(latitude: requestLocation.latitude, longitude: requestLocation.longitude)
        
        CLGeocoder().reverseGeocodeLocation(requestCLLocation) { (placemarks, error) in
            if let placemarks = placemarks {
                if placemarks.count > 0 {
                    let placeMark = MKPlacemark(placemark: placemarks[0])
                    let mapItem = MKMapItem(placemark: placeMark)
                    mapItem.name = self.requestEmail
                    // let options = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                    mapItem.openInMaps()
                }
            }
        }
    }
    
    @IBAction func makeCallTapped(_ sender: Any) {
        //MARK: CALL
        //if let url = URL(string: "tel://\(phoneNumberTextfield.text!)"),
        if let url = URL(string: "tel://\(requestPhoneNumber)"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
