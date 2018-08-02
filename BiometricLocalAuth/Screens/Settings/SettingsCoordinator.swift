//
//  SettingsCoordinator.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 01.08.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import Foundation

final class SettingsCoordinator: BaseCoordinator {
    
    private let factory: SettingsModuleFactory
    private let router: Router
    
    init(router: Router, factory: SettingsModuleFactory) {
        self.factory = factory
        self.router = router
    }
    
    override func start() {
        showSettings()
    }
    
    private func showSettings() {
        let settingsFlowOutput = factory.makeSettingsOutput()
        router.setRootModule(settingsFlowOutput)
    }
//    private func showAbout() {
//        let aboutFlowOutput = factory.makeAboutOutput()
//        aboutFlowOutput.onLogOut = { [weak self] in
//            self?.finishFlow?()
//        }
//        router.setRootModule(aboutFlowOutput)
//    }
}
