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
    
    
    @IBOutlet weak var topView: TopView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override var shouldAutorotate: Bool { return false }
    
    var fireBaseRef = Database.database().reference().child("PatientsRequests")
    
    var patientsRequest : [DataSnapshot] = [] // change for dict
    var patientsRequestCopy : [DataSnapshot] = [] // change for dict
    
    let locationService = LocationService()
    var donorLocation   = CLLocationCoordinate2D()
    var donorData       = Donor()
    
    
    //MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topViewSetup()
        topView.delegate = self
        
        // Location
        locationService.manager.delegate = self
        parseData()
        
        //MARK: TableView Timer
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (timer) in
            self.tableView.reloadData()
        }
    }
    
    //MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        tableSetup()
    }
    
    func parseData() {
        fireBaseRef.observe(.childAdded) { (DataSnapshot) in
            self.patientsRequest.append(DataSnapshot)
            self.tableView.reloadData()
            self.patientsRequestCopy = self.patientsRequest
        }
        fireBaseRef.observe(.childRemoved) { (snapshot) in
            self.patientsRequest.removeAll {$0.key == snapshot.key}
            self.tableView.reloadData()
            self.patientsRequestCopy = self.patientsRequest
        }
    }
}


//MARK: DonorPickerViewControllerDelegate
extension DonorViewController: DonorPickerViewControllerDelegate {
    func sendData(_ data: Donor) {
        donorData = data
        //MARK: Table Filter
        patientsRequest = patientsRequestCopy
        var sortedTable: [DataSnapshot] = []
        for snapshot in patientsRequest {
            if let requestDictionary = snapshot.value as? [String: AnyObject] {
                if  let bloodType    = requestDictionary["bloodType"] as? String,
                    let patientType  = Blood.init(rawValue: bloodType) {
                    if TableFilter.sortByBloodType(donorType: donorData.bloodType, patientType: patientType) {
                        sortedTable.append(snapshot)
                    }
                }
            }
        }
        print(data)
        patientsRequest = sortedTable
        tableView.reloadData()
    }
}

//MARK: Top View Delegate & Setup


extension DonorViewController: TopViewDelegate {
    
    func leftAction() {
        _Defaults.clearAll()
        try? Auth.auth().signOut()
        dismiss(animated: true, completion: nil)
    }
    
    func rightAction() {
        let vc = R.storyboard.donor.donorPickerViewController()!
        vc.donorPickerViewControllerDelegate = self
        present(vc, animated: true, completion: nil)
    }
    
    fileprivate func topViewSetup() {
        let leftImage   = UIImage(named: R.image.logouT.name)
        let rightImage  = UIImage(named: R.image.settingS.name)
        
        topView.leftButton.setImage(leftImage, for: .normal)
        topView.rightButton.setImage(rightImage, for: .normal)
        
        topView.mailLabelText          = "Patients list"
        topView.secondLabelText        = "Use settins to choose your blood type"
        
        topView.leftButton.isHidden    = false
        topView.rightButton.isHidden   = false
        
        topView.leftButton.tintColor   = .white
        topView.rightButton.tintColor  = .white
    }
}

