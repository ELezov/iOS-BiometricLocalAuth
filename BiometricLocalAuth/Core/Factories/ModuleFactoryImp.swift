//
//  ModuleFactoryImp.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 31.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import UIKit

final class ModuleFactoryImp: AuthModuleFactory {

    // MARK: - AuthModuleFactory
    
    func makeAuthOutput() -> AuthView {
        return AuthViewController.controllerFromStoryboard(.auth)
    }
    
    func makeLogInSuccessOutput() -> LogInSuccessView {
        return SuccessViewController.controllerFromStoryboard(.auth)
    }
}
