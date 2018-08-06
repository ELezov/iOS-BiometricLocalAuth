//
//  MainCoordinator.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 31.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import UIKit

class MainCoordinator: BaseCoordinator, MainCoordinatorOutput {
    
    var finishFlow: (() -> Void)?
    
    private let mainView: MainView
    private let coordinatorFactory: CoordinatorFactory
    
    init(mainView: MainView, coordinatorFactory: CoordinatorFactory) {
        self.mainView = mainView
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        mainView.onViewDidLoad = runAboutFlow()
        mainView.onItemFlowSelect = runAboutFlow()
        mainView.onAboutFlowSelect = runSettingsFlow()
    }
    
    private func runAboutFlow() -> ((UINavigationController) -> () ) {
        return { navController in
            if navController.viewControllers.isEmpty == true {
                let itemCoordinator = self.coordinatorFactory.makeAboutCoordinator(navController: navController)
                itemCoordinator.finishFlow = { [weak self] in
                    self?.finishFlow?()
                }
                itemCoordinator.start()
                self.addDependency(itemCoordinator)
            }
        }
    }
    
    private func runSettingsFlow() -> ((UINavigationController) -> () ) {
        return { navController in
            if navController.viewControllers.isEmpty == true {
                let settingsCoordinator = self.coordinatorFactory.makeSettingsCoordinator(navController: navController)
                settingsCoordinator.start()
                self.addDependency(settingsCoordinator)
            }
        }
    }
}
