//
//  AboutViewController.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 31.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import UIKit
import Hero

final class AboutViewController: UIViewController, AboutView {
    
    var onLogOut: (() -> Void)?
    
    var buttonImage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "About"
        configureAppereance()
    }
    
    private func configureAppereance() {
        let titleLabel = UILabel()
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        titleLabel.text = "This is test app"
        titleLabel.adjustsFontSizeToFitWidth = true
        
        let button = UIButton()
        view.addSubview(button)
        
        button.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel).offset(20)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(44)
        }
        
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        button.rx.tap
            .subscribe { [weak self] (event) in
                self?.onLogOut?()
        }
        
        buttonImage = UIButton()
        buttonImage.setImage(Asset.logo.image, for: .normal)
        view.addSubview(buttonImage)
        buttonImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalTo(150)
        }
        buttonImage.rx.tap
            .subscribe { [weak self] (event) in
                let vc = TestViewController.controllerFromStoryboard(.about)
                self?.buttonImage.hero.id = "Test"
                vc.hero.isEnabled = true
                vc.hero.modalAnimationType = .none
                vc.button.hero.id = "Test"
                vc.button.setImage(Asset.logo.image, for: .normal)
                vc.button.contentMode = .scaleAspectFit
                self?.present(vc, animated: true, completion: nil)
        }
        
        
        
        
        
        
    }
}
