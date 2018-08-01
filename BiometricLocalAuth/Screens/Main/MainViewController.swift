//
//  MainViewController.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 31.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import UIKit

final class MainViewController: UITabBarController, UITabBarControllerDelegate, MainView, MainCoordinatorOutput {
    var onItemFlowSelect: ((UINavigationController) -> ())?
    
    var onAboutFlowSelect: ((UINavigationController) -> ())?
    
    var onViewDidLoad: ((UINavigationController) -> ())?
    
    var onFinish: (() -> ())?
    
    var finishFlow: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        if let controller = customizableViewControllers?.first as? UINavigationController {
            onViewDidLoad?(controller)
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let controller = viewControllers?[selectedIndex] as? UINavigationController else { return }
        
        if selectedIndex == 0 {
            onItemFlowSelect?(controller)
        }
        else if selectedIndex == 1 {
            onAboutFlowSelect?(controller)
        }
    }
}

