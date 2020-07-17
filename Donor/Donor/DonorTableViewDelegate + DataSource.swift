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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        let snapshot = patientsRequest[indexPath.row]
        if let patientRequestDictionary = snapshot.value as? [String: AnyObject] {
            if let email = patientRequestDictionary["email"],
                let bloodType = patientRequestDictionary["bloodType"],
                let lat = patientRequestDictionary["latitude"] as? Double,
                let lon = patientRequestDictionary["longitude"] as? Double
            {
                let donorCLLocation = CLLocation(latitude: donorLocation.latitude, longitude: donorLocation.longitude)
                let patientCLLocation = CLLocation(latitude: lat, longitude: lon)
                let distance = donorCLLocation.distance(from: patientCLLocation) / 1000
                let roundedDistance = round(distance * 100) / 100
                
                cell.textLabel?.text = "\(email) - \(roundedDistance)km with blood type:  \(bloodType)"
            }
        }
        
        
        return cell
    }
}

//MARK: Delegate
extension DonorViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patientsRequest.count
    }
    
}

