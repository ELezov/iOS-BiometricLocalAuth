//
//  SettingsViewController.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 01.08.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import Foundation

import UIKit
import Lottie

final class SettingsViewController: UIViewController, SettingsView {
    
    var onLogOut: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        configureAppereance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    private func configureAppereance() {
        let animationView = LOTAnimationView(name: "techno_penguin")
        animationView.contentMode = .scaleAspectFill
        animationView.loopAnimation = true
        self.view.addSubview(animationView)
        animationView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        animationView.play()
    }
}

