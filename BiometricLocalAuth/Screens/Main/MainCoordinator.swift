//
//  MainCoordinator.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 31.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import UIKit

class MainCoordinator: BaseCoordinator {
    
    private let mainView: MainView
    private let coordinatorFactory: CoordinatorFactory
    
    init(mainView: MainView, coordinatorFactory: CoordinatorFactory) {
        self.mainView = mainView
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        mainView.onViewDidLoad = runAboutFlow()
        mainView.onItemFlowSelect = runAboutFlow()
        mainView.onAboutFlowSelect = runAboutFlow()
    }
    
    private func runAboutFlow() -> ((UINavigationController) -> ()) {
        return { navController in
            if navController.viewControllers.isEmpty == true {
                let itemCoordinator = self.coordinatorFactory.make
                itemCoordinator.start()
                self.addDependency(itemCoordinator)
            }
        }
    }
    
//    private func runSettingsFlow() -> ((UINavigationController) -> ()) {
//        return { navController in
//            if navController.viewControllers.isEmpty == true {
//                let settingsCoordinator = self.coordinatorFactory.makeAboutCoordinator(navController: navController)
//                settingsCoordinator.start()
//                self.addDependency(settingsCoordinator)
//            }
//        }
//    }
}
