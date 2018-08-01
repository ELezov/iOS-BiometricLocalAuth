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
    
    func makeMainCoordinator() -> (configurator: Coordinator, toPresent: Presentable?)
    
    func makeAboutCoordinator() -> Coordinator
    func makeAboutCoordinator(navController: UINavigationController?) -> Coordinator
}
