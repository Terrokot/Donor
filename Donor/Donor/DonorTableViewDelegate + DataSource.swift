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
        let donorCLLocation = CLLocation(latitude: donorLocation.latitude, longitude: donorLocation.longitude)
        
        let snapshot = patientsRequest[indexPath.row]
        if let patientRequestDictionary = snapshot.value as? [String: AnyObject] {
            if let email = patientRequestDictionary["email"] as? String {
                cell.textLabel?.text = email
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

