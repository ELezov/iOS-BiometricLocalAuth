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
import NotificationBannerSwift

class AuthViewController: UIViewController {

    
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
        
        biometricAuthButton.rx.tap
            .asObservable()
            .bind {
                let biometricAuthHelper = BiometricAuthHelper()
                biometricAuthHelper.authenticationWithBiometric(reply: { [weak self] (success, error) in
                    guard biometricAuthHelper.biometricDateIsValid()
                        else {
                            self?.showErrorNotification(title: "You biometric data was changed", subtitle: "Be carefull")
                            return
                    }
                    if let error = error {
                        let messageError = biometricAuthHelper.evaluateAuthenticationPolicyMessageForLA(errorCode: error._code)
                        self?.showErrorNotification(title: "Auth Failed", subtitle: messageError)
                        DispatchQueue.main.async {
                            self?.configureBiometricAuthButton(image: #imageLiteral(resourceName: "fingerprint_wrong"), isEnabled: false)
                        }
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                            self?.configureBiometricAuthButton(image: #imageLiteral(resourceName: "finger"), isEnabled: true)
                        })
                    } else {
                        
                        DispatchQueue.main.async {
                            self?.configureBiometricAuthButton(image: #imageLiteral(resourceName: "fingerprint_success"), isEnabled: false)
                        }
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                            self?.setRootAsSuccess()
                        })
                    }
                })
        }
    }
    
    private func configureBiometricAuthButton(image: UIImage, isEnabled: Bool) {
        self.biometricAuthButton.setImage(image, for: UIControlState())
        self.biometricAuthButton.isEnabled = isEnabled
    }
    
    func setRootAsSuccess() {
       WindowBuilder.setVCasRoot(vc: SuccessViewController.self)
    }
    
    private func showErrorNotification(title: String, subtitle: String, style: BannerStyle = .danger) {
        let banner = NotificationBanner(title: title, subtitle: subtitle, style: style)
        banner.show()
    }

}

