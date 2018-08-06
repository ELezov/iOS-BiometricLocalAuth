//
//  SettingsCoordinator.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 01.08.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import Foundation

final class SettingsCoordinator: BaseCoordinator, MainCoordinatorOutput {
    
    var finishFlow: (() -> Void)?

    private let factory: SettingsModuleFactory
    private let router: Router
    private let isBack: Bool
    
    init(router: Router, factory: SettingsModuleFactory, isBack: Bool = false) {
        self.factory = factory
        self.router = router
        self.isBack = isBack
    }
    
    override func start() {
        showSettings()
    }
    
    private func showSettings() {
        let settingsFlowOutput = factory.makeSettingsOutput()
        settingsFlowOutput.isBack = isBack
        settingsFlowOutput.onFinish = { [weak self] in
            self?.finishFlow?()
        }
        router.setRootModule(settingsFlowOutput)
    }
}
