//
//  LoginBiometricView.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 25.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import UIKit

typealias ZeroButtonActionBlock = (() -> Void)

class LoginBiometricView: UIView {

    enum Constants {
        static let containerViewHeight: CGFloat = 200.0
        static let topViewHeight: CGFloat = 60.0
        static let bottomViewHeight: CGFloat = 40.0
        static let inputFieldHeight: CGFloat = 50.0
        static let touchIdAuth = L10n.Auth.biometric
    }
    
    var buttonAction: ZeroButtonActionBlock?
    var containerView: UIView = UIView()
    var authButton: UIButton = UIButton()
    var topView: UIView = UIView()
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var isAnimating = false
    
    init() {
        super.init(frame: CGRect.zero)
        setupContainerView()
        setupTitle()
        setupAuthButton()
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
            make.width.lessThanOrEqualTo(300)
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
        titleLabel.text = Constants.touchIdAuth
        titleLabel.textColor = UIColor.white
        titleLabel.backgroundColor = UIColor.clear
        
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(topView).inset(UIEdgeInsets(top: 0.0,
                                                           left: 16.0,
                                                           bottom: 0.0,
                                                           right: 16.0))
        }
    }
    
    private func setupAuthButton() {
        containerView.addSubview(authButton)
        
        authButton.setImage(Asset.finger.image, for: .normal)
        authButton.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom).offset(16)
            make.centerX.equalTo(containerView)
            make.height.equalTo(100)
            make.width.equalTo(authButton.snp.height)
        }
        
        _ = authButton.rx.tap
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
        
        buttonAction?()
        
        authButton.snp.remakeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom).offset(16)
            make.left.equalTo(containerView.snp.right).offset(10)
            make.height.equalTo(100)
            make.width.equalTo(authButton.snp.height)
        }
        
        activityIndicator.snp.updateConstraints { (make) in
            make.centerY.equalTo(containerView)
        }
        
        self.setNeedsLayout()
        
        
        UIView.animate(withDuration: 0.5, animations: {
            self.layoutIfNeeded()
        })
        
        isAnimating = true
    }
    
    func resetLoginBiometricView() {
        authButton.snp.remakeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom).offset(16)
            make.centerX.equalTo(containerView)
            make.height.equalTo(100)
            make.width.equalTo(authButton.snp.height)
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
