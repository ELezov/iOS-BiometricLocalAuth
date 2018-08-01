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
import LocalAuthentication

class AuthViewController: UIViewController, AuthView {
    
    var onLogInSuccess: (() -> Void)?
    
    var onCompleteAuth: (() -> Void)?

    
    // MARK: - Private
    
    private var alertHelper: AlertHelper!
    private var biometricAuthHelper: BiometricAuthHelper!
    
    let loginView: LoginView = LoginView()
    let loginBiometricView = LoginBiometricView()

    @IBAction func tapGestureDetected(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertHelper = AlertHelper(presenter: self)
        biometricAuthHelper = BiometricAuthHelper()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.addSubview(loginView)
        loginView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.view).offset(100)
            make.right.equalTo(self.view)
            make.height.equalTo(300)
        }
        
        view.addSubview(loginBiometricView)
        
        loginBiometricView.snp.makeConstraints { (make) in
            make.top.equalTo(loginView.snp.bottom).offset(32)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(200)
        }
        
        loginBiometricView.buttonAction = { [weak self] in
            self?.authBiometric()
        }
        
    }
    
    private func authBiometric() {
        self.biometricAuthHelper.authenticationWithBiometric(reply: { [weak self] (_, error) in
            guard let `self` = self else { return }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                self.loginBiometricView.resetLoginBiometricView()
            })
            if let error = error {
                self.handleError(error: error)
            } else {
                // Отслеживаем изменение биометрических данных
                self.handleChangeBiometricDate()
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: { [weak self] in
                    self?.onLogInSuccess?()
                })
            }
        })
    }
    
    private func showErrorNotification(title: String, subtitle: String, style: BannerStyle = .danger) {
        DispatchQueue.main.async {
            let banner = NotificationBanner(title: title, subtitle: subtitle, style: style)
            banner.duration = 3.0
            banner.show()
        }
    }
    
    private func handleError(error: Error) {
        let messageError = biometricAuthHelper.evaluateAuthenticationPolicyMessageForLA(errorCode: error._code)
        let errorCode = error._code
        if #available(iOS 11.0, *) {
            if [LAError.biometryLockout.rawValue,
                LAError.biometryNotAvailable.rawValue,
                LAError.biometryNotEnrolled.rawValue].contains(where: { $0 == errorCode }) {
                    self.alertHelper.showAlertToDeviceSettings(errorMessage: messageError)
            } else {
                self.showErrorNotification(title: L10n.Auth.failed, subtitle: messageError)
            }
        } else {
            if [LAError.touchIDLockout.rawValue,
                LAError.touchIDNotAvailable.rawValue,
                LAError.touchIDNotEnrolled.rawValue].contains(where: { $0 == errorCode }) {
                    self.alertHelper.showAlertToDeviceSettings(errorMessage: messageError)
            } else {
                self.showErrorNotification(title: L10n.Auth.failed, subtitle: messageError)
            }
        }
    }
    
    private func handleChangeBiometricDate() {
        // Проверка на изменение данных
        if !self.biometricAuthHelper.biometricDateIsValid() {
            self.showErrorNotification(title: L10n.Auth.Biometric.changed,
                                       subtitle: L10n.Auth.carefull,
                                       style: .warning)
        }
    }
}
