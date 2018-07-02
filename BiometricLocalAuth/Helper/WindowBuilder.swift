//
//  WindowBuilder.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 02.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import Foundation
import UIKit

class WindowBuilder {
    
    static func setVCasRoot(vc: AnyClass) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: String(describing: vc.self))
        UIApplication.shared.keyWindow?.rootViewController = initialViewController
    }
}
