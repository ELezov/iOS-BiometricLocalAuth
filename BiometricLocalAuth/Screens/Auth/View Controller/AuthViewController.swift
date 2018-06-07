//
//  AuthViewController.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 07.06.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class AuthViewController: UIViewController {

    // MARK: - Enums
    
    enum Constants {
        static let biometricAuthButtonTitle = "Войти"
    }
    
    
    // MARK: - Outlets
    
    
    @IBOutlet weak var biometricAuthButton: UIButton!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        configureBiometricAuthButton()
    }
    
    
    // MARK: - Private methods
    
    private func configureBiometricAuthButton() {
        biometricAuthButton.setTitle(Constants.biometricAuthButtonTitle, for: UIControlState())
        biometricAuthButton.backgroundColor = UIColor.blue
        biometricAuthButton.setTitleColor(UIColor.white, for: UIControlState())
        biometricAuthButton.rx.tap
            .asObservable()
            .bind {
                BiometricAuthHelper().authenticationWithBiometric(reply: { [weak self] (success, error) in
                    
                })
        }
    }
    
    

}

