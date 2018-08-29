//
//  AuthCoordinator.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 31.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import Foundation

final class AuthCoordinator: BaseCoordinator, AuthCoordinatorOutput {

    var finishFlow: (() -> Void)?
    
    private let factory: AuthModuleFactory
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    
    init(router: Router, factory: AuthModuleFactory, coordinatorFactory: CoordinatorFactory) {
        self.factory = factory
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        showLogin()
    }
    
    private func showLogin() {
        let loginOutput = factory.makeAuthOutput()
        loginOutput.onCompleteAuth = { [weak self] in
            self?.finishFlow?()
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
        logInSuccessView.onFinish = { [weak self] in
            self?.finishFlow?()
        }
        router.push(logInSuccessView)
    }
    
    
    
}
