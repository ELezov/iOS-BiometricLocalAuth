//
//  AuthCoordinator.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 31.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import Foundation

final class AuthCoordinator: BaseCoordinator {
    
    var finishFlow: (() -> Void)?
    
    private let factory: AuthModuleFactory
    private let router: Router
    
    init(router: Router, factory: AuthModuleFactory) {
        self.factory = factory
        self.router = router
    }
    
    override func start() {
        showLogin()
    }
    
    //MARK: - Run current flow's controllers
    
    private func showLogin() {
        let loginOutput = factory.makeAuthOutput()
        loginOutput.onCompleteAuth = { [weak self] in
            //self?.finishFlow?()
        }
        
        loginOutput.onLogInSuccess = { [weak self] in
            self?.showLogInSuccess()
        }
        
        router.setRootModule(loginOutput)
    }
    
    private func showLogInSuccess() {
        let logInSuccessView = factory.makeLogInSuccessOutput()
        logInSuccessView.onCompleteAuth = { [weak self] in
            self?.finishFlow?()
        }
        
        logInSuccessView.onContinueButtonTap = { [weak self] in
            self?.router.popModule(animated: true)
        }
        router.push(logInSuccessView)
    }
}
