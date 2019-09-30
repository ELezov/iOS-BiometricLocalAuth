//
//  AppDelegate.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 07.06.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var rootController: UINavigationController {
        guard let window = self.window,
            let navigationController = window.rootViewController as? UINavigationController
            else {
                fatalError("Приложение не смогло найти UINavigationController")
        }
        return navigationController
    }
    
    private lazy var applicationCoordinator: Coordinator = self.makeCoordinator()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        applicationCoordinator.start()
        return true
    }
    
    private func makeCoordinator() -> Coordinator {
        return ApplicationCoordinator(
            router: RouterImp(rootController: self.rootController),
            coordinatorFactory: CoordinatorFactoryImp()
        )
    }
}
