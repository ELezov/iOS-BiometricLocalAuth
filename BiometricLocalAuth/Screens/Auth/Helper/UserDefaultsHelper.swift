//
//  UserDefaultsHelper.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 03.07.18.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import Foundation

enum Constants {
    static let bioDateKey = "BiometricDate"
}

class UserDefaultsHelper {
    
    class var biometricDate: Data? {
        get {
            return UserDefaults.standard.data(forKey: Constants.bioDateKey)
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: Constants.bioDateKey)
        }
    }
    
}
