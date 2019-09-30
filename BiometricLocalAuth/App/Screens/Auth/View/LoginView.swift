//
//  LoginView.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 25.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    enum Constants {
        static let containerViewHeight: CGFloat = 260.0
        static let topViewHeight: CGFloat = 60.0
        static let bottomViewHeight: CGFloat = 40.0
        static let inputFieldHeight: CGFloat = 50.0
        static let loginText: String = L10n.Auth.login
        static let emailText: String = L10n.Auth.mail
        static let passwordText: String = L10n.Auth.password
        static let logIn: String = L10n.Auth.signin
    }
    
    var containerView: UIView = UIView()
    var topView: UIView = UIView()
    var bottomView: UIView = UIView()
    var mailTextField: UITextField = UITextField()
    var passwordTextField: UITextField = UITextField()
    var loginButton: UIButton = UIButton()
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    var isAnimating = false

    var onAuthButtonTapped: (() -> Void)?
    
    init() {
        super.init(frame: CGRect.zero)
        
        setupContainerView()
        setupTitle()
        setupInputFields()
        setupBottomView()
        setupActivityIndicator()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupContainerView() {
        containerView = UIView()
        self.addSubview(containerView)
        
        containerView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(40)
            make.right.equalTo(self).offset(-40)
            make.width.lessThanOrEqualTo(400)
            make.center.equalTo(self)
            make.height.equalTo(Constants.containerViewHeight)
        }
        
        containerView.backgroundColor = UIColor.lightGray
        containerView.layer.cornerRadius = 8.0
        containerView.clipsToBounds = true
    }
    
    private func setupTitle() {
        containerView.addSubview(topView)
        topView.backgroundColor = UIColor.brown
        
        topView.snp.makeConstraints { (make) in
            make.left.equalTo(containerView)
            make.top.equalTo(containerView)
            make.right.equalTo(containerView)
            make.height.equalTo(Constants.topViewHeight)
        }
        
        let titleLabel = UILabel()
        topView.addSubview(titleLabel)
        titleLabel.text = Constants.loginText
        titleLabel.textColor = UIColor.white
        titleLabel.backgroundColor = UIColor.clear
        
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(topView).inset(UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0))
        }
    }
    
    private func setupInputFields() {
        containerView.addSubview(mailTextField)
        
        mailTextField.delegate = self
        mailTextField.placeholder = Constants.emailText
        mailTextField.borderStyle = .roundedRect
        mailTextField.backgroundColor = UIColor.white
        mailTextField.keyboardType = .emailAddress
        mailTextField.returnKeyType = .next
        mailTextField.autocapitalizationType = .none
        mailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom).offset(16)
            make.left.equalTo(containerView).offset(8)
            make.right.equalTo(containerView).offset(-8)
            make.height.equalTo(Constants.inputFieldHeight)
        }
        
        containerView.addSubview(passwordTextField)
        
        passwordTextField.delegate = self
        passwordTextField.placeholder = Constants.passwordText
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.backgroundColor = UIColor.white
        passwordTextField.keyboardType = .emailAddress
        passwordTextField.returnKeyType = .done
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(mailTextField.snp.bottom).offset(16)
            make.left.equalTo(mailTextField)
            make.right.equalTo(mailTextField)
            make.height.equalTo(Constants.inputFieldHeight)
        }
    }
    
    private func setupBottomView() {
        containerView.addSubview(bottomView)
        bottomView.backgroundColor = UIColor.brown
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.left.equalTo(containerView)
            make.right.equalTo(containerView)
            make.height.equalTo(Constants.bottomViewHeight).priority(750)
            make.bottom.equalTo(containerView)
        }
        bottomView.addSubview(loginButton)
        
        loginButton.setTitle(Constants.logIn, for: .normal)
        loginButton.setTitleColor(UIColor.black, for: .normal)
        loginButton.backgroundColor = UIColor.white
        loginButton.layer.borderWidth = 2
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.cornerRadius = 8
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(bottomView).offset(4)
            make.right.equalTo(bottomView).offset(-4)
            make.bottom.equalTo(bottomView).offset(-4)
            make.width.equalTo(150)
        }
        
        _ = loginButton.rx.tap
            .asObservable()
            .bind { [weak self] in
                self?.connect()
        }
    }
    
    func setupActivityIndicator() {
        containerView.addSubview(activityIndicator)
        
        activityIndicator.color = UIColor.yellow
        activityIndicator.startAnimating()
        
        activityIndicator.snp.makeConstraints { (make) in
            make.centerX.equalTo(containerView)
            make.centerY.equalTo(containerView).offset(-300)
            make.width.equalTo(40)
            make.height.equalTo(self.activityIndicator.snp.width)
        }
    }
    
    private func connect() {
        if isAnimating {
            return
        }
        mailTextField.snp.remakeConstraints { (make) in
            make.top.equalTo(containerView.snp.bottom).offset(400)
            make.left.equalTo(containerView).offset(8)
            make.right.equalTo(containerView).offset(-8)
            make.height.equalTo(Constants.inputFieldHeight)
        }
        passwordTextField.snp.remakeConstraints { (make) in
            make.top.equalTo(containerView.snp.bottom).offset(400)
            make.left.equalTo(mailTextField)
            make.right.equalTo(mailTextField)
            make.height.equalTo(Constants.inputFieldHeight)
        }
        bottomView.snp.remakeConstraints { (make) in
            make.top.equalTo(containerView.snp.bottom).offset(400)
            make.left.equalTo(containerView)
            make.right.equalTo(containerView)
            make.height.equalTo(Constants.bottomViewHeight).priority(750)
        }
        activityIndicator.snp.updateConstraints { (make) in
            make.centerY.equalTo(containerView)
        }
        self.setNeedsLayout()
        UIView.animate(withDuration: 0.5, animations: {
            self.layoutIfNeeded()
        }, completion: { finished in
            if finished {
                DispatchQueue.main.asyncAfter(
                    deadline: DispatchTime.now() + DispatchTimeInterval.seconds(3),
                    execute: { [weak self] in
                        self?.resetLoginView()
                        self?.onAuthButtonTapped?()
                })
            }
        }) 
        
        isAnimating = true
    }
    
    private func resetLoginView() {
        mailTextField.snp.remakeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom).offset(16)
            make.left.equalTo(containerView).offset(8)
            make.right.equalTo(containerView).offset(-8)
            make.height.equalTo(Constants.inputFieldHeight)
        }
        
        passwordTextField.snp.remakeConstraints { (make) in
            make.top.equalTo(mailTextField.snp.bottom).offset(16)
            make.left.equalTo(mailTextField)
            make.right.equalTo(mailTextField)
            make.height.equalTo(Constants.inputFieldHeight)
        }
        
        bottomView.snp.remakeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.left.equalTo(containerView)
            make.right.equalTo(containerView)
            make.height.equalTo(Constants.bottomViewHeight).priority(700)
            make.bottom.equalTo(containerView)
        }
        
        activityIndicator.snp.updateConstraints { (make) in
            make.centerY.equalTo(containerView).offset(-300)
        }
        
        self.setNeedsLayout()
        UIView.animate(withDuration: 0.5, animations: {
            self.layoutIfNeeded()
        }, completion: { [weak self] finished in
            if finished {
                self?.isAnimating = false
            }
        })
    }
}


extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == mailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
}
