//
//  AboutCoordinator.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 31.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import Foundation

final class AboutCoordinator: BaseCoordinator {
    
    private let factory: AboutModuleFactory
    private let router: Router
    
    init(router: Router, factory: AboutModuleFactory) {
        self.factory = factory
        self.router = router
    }
    
    override func start() {
        showAbout()
    }
    
    //MARK: - Run current flow's controllers
    
    private func showAbout() {
        let aboutFlowOutput = factory.makeAboutOutput()
        router.setRootModule(aboutFlowOutput)
    }
}
