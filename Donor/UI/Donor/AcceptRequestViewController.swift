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
    
    
    @IBOutlet weak var topView: TopView!
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var requestAcceptButton: UIButton!
    
    override var shouldAutorotate: Bool { return false }
    
    var dataBaseRef: DatabaseReference!
    
    var requestLocation = CLLocationCoordinate2D()
    var donorLocation   = CLLocationCoordinate2D()
    
    var requestName         = ""
    var requestEmail        = ""
    var requestPhoneNumber  = ""
    var acceptionStatus = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topViewSetup()
        topView.delegate = self
        
        dataBaseRef =  Database.database().reference().child("PatientsRequests")
        
        let region = MKCoordinateRegion(center: requestLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        map.setRegion(region, animated: false)
        MapManager.addAnnotation(map: map, coordinate: requestLocation, title: requestEmail)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let acceptAnyRequest: Bool = Defaults["acceptAnyRequest"] ?? false
        let acceptionStatus: Bool = Defaults[requestEmail] ?? false //for key email
        
        if acceptAnyRequest, acceptionStatus {
            requestAcceptButton.setTitle("Cancel", for: .normal)
        }
    }
    
    @IBAction func acceptButtonTapped(_ sender: Any) {
        //MARK: ACCEPT
        
        let acceptAnyRequest: Bool = Defaults["acceptAnyRequest"] ?? false
        let acceptionStatus: Bool = Defaults[requestEmail] ?? false //for key email
        
        if !acceptAnyRequest, !acceptionStatus  {
            
            // Update the Request
            dataBaseRef.queryOrdered(byChild: "email").queryEqual(toValue: requestEmail).observe(.childAdded) { (snapshot) in
                snapshot.ref.updateChildValues(["donorLat":self.donorLocation.latitude, "donorLon":self.donorLocation.longitude])
                self.dataBaseRef.removeAllObservers()
            }
            Defaults[requestEmail] = true
            Defaults["acceptAnyRequest"] = true
            requestAcceptButton.setTitle("Cancel", for: .normal)
            AlertManager.displayAlert(title: "You accept the request", message: "Don't forget. Patient is waiting you")
            
        } else {
            if acceptionStatus {
                Defaults[requestEmail] = false
                Defaults["acceptAnyRequest"] = false
                requestAcceptButton.setTitle("Accept Request", for: .normal)
                
            } else {
                AlertManager.displayAlert(title: "error", message: "You can't accept more than 1 request")
            }
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
                    let mapItem   = MKMapItem(placemark: placeMark)
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
}

extension AcceptRequestViewController: TopViewDelegate {
    func leftAction() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func topViewSetup() {
        topView.mailLabelText          = requestName
        topView.secondLabelText        = requestEmail
        topView.leftButton.isHidden   = false
        topView.leftButton.tintColor  = .white
        
    }
}
