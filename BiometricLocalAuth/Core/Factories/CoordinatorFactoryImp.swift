//
//  CoordinatorFactoryImpl.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 31.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import UIKit

final class CoordinatorFactoryImp: CoordinatorFactory {
    
    func makeMainCoordinator() -> (configurator: Coordinator & MainCoordinatorOutput, toPresent: Presentable?) {
        let controller = MainViewController.controllerFromStoryboard(.main)
        let coordinator = MainCoordinator(mainView: controller, coordinatorFactory: CoordinatorFactoryImp())
        return (coordinator, controller)
    }
    
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
    
    func makeAboutCoordinator() -> Coordinator & MainCoordinatorOutput {
        return makeAboutCoordinator(navController: navigationController(nil))
    }
    
    func makeAboutCoordinator(navController: UINavigationController?) -> Coordinator & MainCoordinatorOutput{
        let coordinator = AboutCoordinator(router: router(navController), factory: ModuleFactoryImp())
        return coordinator
    }
    
    func makeSettingsCoordinator(navController: UINavigationController?) -> Coordinator {
        let coordinator = SettingsCoordinator(router: router(navController), factory: ModuleFactoryImp())
        return coordinator
    }
    
    func makeSettingsCoordinatorBox(isBack: Bool = false) ->
        (configurator: Coordinator & MainCoordinatorOutput,
        toPresent: Presentable?) {
            
            return makeSettingsCoordinatorBox(navController: navigationController(nil),
                                              isBack: isBack)
    }
    func makeSettingsCoordinatorBox(navController: UINavigationController?,
                                    isBack: Bool = false) ->
        (configurator: Coordinator & MainCoordinatorOutput,
        toPresent: Presentable?) {
            
            let router = self.router(navController)
            let coordinator = SettingsCoordinator(router: router, factory: ModuleFactoryImp(), isBack: isBack)
            return (coordinator, router)
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
