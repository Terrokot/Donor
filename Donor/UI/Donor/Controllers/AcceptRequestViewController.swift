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
    
    var dataBaseRef: DatabaseReference!
    
    var requestLocation = CLLocationCoordinate2D()
    var donorLocation = CLLocationCoordinate2D()
    var requestEmail = ""
    var requestPhoneNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataBaseRef =  Database.database().reference().child("PatientsRequests")
        
        let region = MKCoordinateRegion(center: requestLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        map.setRegion(region, animated: false)
        MapManager.addAnnotation(map: map, coordinate: requestLocation, title: requestEmail)
    }
    
    @IBAction func acceptButtonTapped(_ sender: Any) {
        //MARK: ACCEPT
        // Update the ride Request
        dataBaseRef.queryOrdered(byChild: "email").queryEqual(toValue: requestEmail).observe(.childAdded) { (snapshot) in
            snapshot.ref.updateChildValues(["donorLat":self.donorLocation.latitude, "donorLon":self.donorLocation.longitude])
            self.dataBaseRef.removeAllObservers()
        }
        
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
