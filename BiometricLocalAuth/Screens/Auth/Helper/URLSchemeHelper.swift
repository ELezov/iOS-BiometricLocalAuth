//
//  URLSchemeHelper.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 04.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import Foundation
import UIKit

class URLSchemeHelper {
    
    class var settingURL:URL? {
        return URL(string : "App-Prefs:")
    }
    
    static func showDeviceSettings() {
        guard let settingURL = settingURL else { return }
        
        if UIApplication.shared.canOpenURL(settingURL){
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(settingURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(settingURL)
            }
        }
    }
}
