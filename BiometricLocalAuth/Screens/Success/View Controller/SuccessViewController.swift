//
//  SuccessViewController.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 02.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func actionButtonTapped(_ sender: Any) {
        WindowBuilder.setVCasRoot(viewController: AuthViewController.self)
    }
}
