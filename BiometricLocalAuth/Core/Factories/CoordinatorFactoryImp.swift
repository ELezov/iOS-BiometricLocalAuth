//
//  CoordinatorFactoryImpl.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 31.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import Foundation

final class CoordinatorFactoryImp: CoordinatorFactory {
    
    func makeMainCoordinator() -> (configurator: Coordinator, toPresent: Presentable?) {
        let controller = MainViewController.controllerFromStoryboard(.main)
        let coordinator = MainCoordinator(mainView: controller, coordinatorFactory: CoordinatorFactoryImp())
        return (coordinator, controller)
    }
    
    func makeAboutCoordinator(router: Router) -> Coordinator {
        let coordinator = AboutCoordinator(router: router, factory: ModuleFactoryImp())
        return coordinator
    }
    
    func makeAuthCoordinatorBox(router: Router) -> Coordinator {
        let coordinator = AuthCoordinator(router: router, factory: ModuleFactoryImp())
        return coordinator
    }
    
}
