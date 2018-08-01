//
//  SuccessViewController.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 02.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController, LogInSuccessView {
    
    var onContinueButtonTap: (() -> Void)?
    
    var onCompleteAuth: (() -> Void)?
    
    var onSignUpButtonTap: (() -> Void)?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    @IBAction func actionButtonTapped(_ sender: Any) {
        onContinueButtonTap?()
    }
}
