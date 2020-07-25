//
//  Defaults.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/25/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import Foundation

class _Defaults {
    
    private let defaults = UserDefaults.standard;
    
    fileprivate init() { }
    
    subscript<T>(key: String) -> T? {
        get {
            return defaults.value(forKey: key) as? T
        }
        set {
            defaults.set(newValue, forKey: key)
            defaults.synchronize()
        }
    }
    
    public static func synchronize() {
        UserDefaults.standard.synchronize()
    }
    public static func clearAll() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
    }
}

let Defaults = _Defaults()
