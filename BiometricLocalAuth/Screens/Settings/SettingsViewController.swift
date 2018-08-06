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
    
    var isBack: Bool = false
    var onFinish: (() -> Void)?
    var animationView: LOTAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        configureAppereance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animationView.play()
        if isBack {
            let backBarButton = UIBarButtonItem(barButtonSystemItem: .undo,
                                                target: self,
                                                action: #selector(backButtonTapped))
            navigationItem.leftBarButtonItem = backBarButton
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        animationView.stop()
    }
    
    private func configureAppereance() {
        animationView = LOTAnimationView(name: "techno_penguin")
        animationView.contentMode = .scaleAspectFill
        animationView.loopAnimation = true
        self.view.addSubview(animationView)
        animationView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    @objc
    private func backButtonTapped() {
        onFinish?()
    }
}
