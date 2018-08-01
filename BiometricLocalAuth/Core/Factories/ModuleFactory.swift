//
//  ModuleFactory.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 31.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import Foundation

protocol AuthModuleFactory {
    func makeAuthOutput() -> AuthView
    func makeLogInSuccessOutput() -> LogInSuccessView
}

protocol AboutModuleFactory {
    func makeAboutOutput() -> AboutView
}
