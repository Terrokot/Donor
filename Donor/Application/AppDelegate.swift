//
//  AppDelegate.swift
//  Donor
//
//  Created by Egor Tereshonok on 6/24/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
@UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let locationService = LocationService()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        var topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
        topWindow?.rootViewController = UIViewController()
        topWindow?.windowLevel = UIWindow.Level.alert + 1
        
        let alert = UIAlertController(title: "error", message: "please get permission in settings", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
            
            topWindow?.isHidden = true
            topWindow = nil
         })
        
        switch locationService.status {
        case .notDetermined:
            locationService.getPermission()
        case .authorizedWhenInUse:
            break
        case .restricted:
           topWindow?.makeKeyAndVisible()
           topWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        case .denied:
           topWindow?.makeKeyAndVisible()
           topWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        default: assertionFailure("Location is: \(locationService.status)")
        }

        FirebaseApp.configure()
        return true
    }
}



