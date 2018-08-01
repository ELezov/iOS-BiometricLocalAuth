//
//  AboutViewController.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 31.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import UIKit

final class AboutViewController: UIViewController, AboutView {
    
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
    }
}
