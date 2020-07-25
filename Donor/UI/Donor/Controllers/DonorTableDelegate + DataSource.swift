//
//  DonorTableViewDelegate + DataSource.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/16/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

//MARK: DataSource
extension DonorViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.register(UINib(nibName: "DonorCell", bundle: nil), forCellReuseIdentifier: DonorCell.reuseId)
        let cell = tableView.dequeueReusableCell(withIdentifier: DonorCell.reuseId) as! DonorCell
        
        let snapshot = patientsRequest[indexPath.row]
        if let patientRequestDictionary = snapshot.value as? [String: AnyObject] {
            if let email = patientRequestDictionary["email"],
                let name = patientRequestDictionary["name"],
                let bloodType = patientRequestDictionary["bloodType"],
                let lat = patientRequestDictionary["latitude"] as? Double,
                let lon = patientRequestDictionary["longitude"] as? Double
            {
                let donorCLLocation = CLLocation(latitude: donorLocation.latitude, longitude: donorLocation.longitude)
                let patientCLLocation = CLLocation(latitude: lat, longitude: lon)
                let distance = donorCLLocation.distance(from: patientCLLocation) / 1000
                let roundedDistance = round(distance * 100) / 100
                
                cell.nameLabel.text = "\(name) - \(email)"
                cell.distanceLabel.text = "\(roundedDistance)km"
                cell.bloodTypeLabel.text = "Blood type:\(bloodType)"
            }
        }
        
        return cell
    }
}

//MARK: Delegate
extension DonorViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patientsRequest.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUserData = patientsRequest[indexPath.row]
        
        if let patientRequestDictionary = selectedUserData.value as? [String: AnyObject] {
            if let email = patientRequestDictionary["email"],
                let phoneNumber = patientRequestDictionary["phoneNumber"],
                let lat = patientRequestDictionary["latitude"] as? Double,
                let lon = patientRequestDictionary["longitude"] as? Double
            {
                let acceptVC = R.storyboard.donor.acceptRequestViewController()!
                acceptVC.requestEmail = "\(email)"
                acceptVC.requestPhoneNumber = ("\(phoneNumber)")
                acceptVC.donorLocation = self.donorLocation
                acceptVC.requestLocation = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                present(acceptVC, animated: true, completion: nil)
            }
        }
    }
}
