//
//  CoordinatorFactoryImpl.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 31.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import UIKit

final class CoordinatorFactoryImp: CoordinatorFactory {
    
    
    func makeMainCoordinator() -> (configurator: Coordinator, toPresent: Presentable?) {
        let controller = MainViewController.controllerFromStoryboard(.main)
        let coordinator = MainCoordinator(mainView: controller, coordinatorFactory: CoordinatorFactoryImp())
        return (coordinator, controller)
    }
    
    func makeAuthCoordinatorBox(router: Router) -> Coordinator & AuthCoordinatorOutput {
        let coordinator = AuthCoordinator(router: router, factory: ModuleFactoryImp())
        return coordinator
    }
    
    func makeAboutCoordinator() -> Coordinator {
        return makeAboutCoordinator(navController: navigationController(nil))
    }
    
    func makeAboutCoordinator(navController: UINavigationController?) -> Coordinator {
        let coordinator = AboutCoordinator(router: router(navController), factory: ModuleFactoryImp())
        return coordinator
    }
    
    
    // MARK: - Private
    
    private func router(_ navController: UINavigationController?) -> Router {
        return RouterImp(rootController: navigationController(navController))
    }
    
    private func navigationController(_ navController: UINavigationController?) -> UINavigationController {
        if let navController = navController { return navController }
        else { return UINavigationController.controllerFromStoryboard(.main) }
    }
    
}
