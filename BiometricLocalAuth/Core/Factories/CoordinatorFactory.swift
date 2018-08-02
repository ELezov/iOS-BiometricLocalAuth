//
//  CoordinatorFactory.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 31.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import UIKit

protocol CoordinatorFactory {
    func makeAuthCoordinatorBox(router: Router) -> Coordinator  & AuthCoordinatorOutput
    
    func makeMainCoordinator() -> (configurator: Coordinator & MainCoordinatorOutput, toPresent: Presentable?)
    
    func makeAboutCoordinator() -> Coordinator & MainCoordinatorOutput
    func makeAboutCoordinator(navController: UINavigationController?) -> Coordinator & MainCoordinatorOutput
    
   func makeSettingsCoordinator(navController: UINavigationController?) -> Coordinator
    
    func makeAuthCoordinatorBox() -> Coordinator & AuthCoordinatorOutput
    
    func makeAuthCoordinatorBox(navController: UINavigationController?) -> Coordinator & AuthCoordinatorOutput
    
    func makeSettingsCoordinatorBox(isBack: Bool) ->
        (configurator: Coordinator & MainCoordinatorOutput,
        toPresent: Presentable?)
    
    func makeSettingsCoordinatorBox(navController: UINavigationController?,
                                    isBack: Bool) ->
        (configurator: Coordinator & MainCoordinatorOutput,
        toPresent: Presentable?)
}
