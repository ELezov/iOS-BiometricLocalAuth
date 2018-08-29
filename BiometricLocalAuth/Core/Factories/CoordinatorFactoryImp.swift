//
//  CoordinatorFactoryImpl.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 31.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import UIKit

final class CoordinatorFactoryImp: CoordinatorFactory {
    
    func makeAuthCoordinatorBox(router: Router) -> Coordinator & AuthCoordinatorOutput {
        let coordinator = AuthCoordinator(
            router: router,
            factory: ModuleFactoryImp(),
            coordinatorFactory: CoordinatorFactoryImp())
        return coordinator
    }
    
    func makeAuthCoordinatorBox() -> Coordinator & AuthCoordinatorOutput {
        return makeAuthCoordinatorBox(navController: navigationController(nil))
    }
    
    func makeAuthCoordinatorBox(navController: UINavigationController?) -> Coordinator & AuthCoordinatorOutput {
        let coordinator = AuthCoordinator(
            router: router(navController),
            factory: ModuleFactoryImp(),
            coordinatorFactory: CoordinatorFactoryImp())
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
