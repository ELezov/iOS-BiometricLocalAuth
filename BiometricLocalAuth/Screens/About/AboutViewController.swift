//
//  AboutViewController.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 31.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import UIKit

final class AboutViewController: UIViewController, AboutView {
    
    var onLogOut: (() -> Void)?
    
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
    }
}
