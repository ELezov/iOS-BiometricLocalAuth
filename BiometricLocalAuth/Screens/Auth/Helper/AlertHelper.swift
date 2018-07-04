//
//  AlertHelper.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 04.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import Foundation
import UIKit

class AlertHelper {
    
    enum Constants {
        static let warning = "Warning"
        static let toSettings = "To Settings"
        static let cancel = "Cancel"
    }
    
    let presenter: UIViewController
    
    init(presenter: UIViewController) {
        self.presenter = presenter
    }
    
    public func showAlertToDeviceSettings(errorMessage: String) {
        let alert = makeAlert(title: Constants.warning, message: errorMessage)
        let toSettingsAction = UIAlertAction(
            title: Constants.toSettings,
            style: .default,
            handler: { action in
                URLSchemeHelper.showDeviceSettings()
        })
        
        alert.addAction(toSettingsAction)
        
        alert.addAction(UIAlertAction(title: Constants.cancel, style: .cancel, handler: nil))
        
        presenter.present(alert, animated: true, completion: nil)
    }
    
    private func makeAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        return alert
    }
}
