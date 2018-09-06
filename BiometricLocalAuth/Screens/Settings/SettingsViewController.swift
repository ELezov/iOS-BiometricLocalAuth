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
    var toggle: LOTAnimatedSwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        configureAppereance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if toggle.isOn { animationView.play() }
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
    
    private func configurePenguin() {
        animationView = LOTAnimationView(name: "techno_penguin")
        animationView.contentMode = .scaleAspectFill
        animationView.loopAnimation = true
        self.view.addSubview(animationView)
        animationView.snp.makeConstraints { (make) in
            make.center.equalToSuperview().offset(100)
            make.right.equalToSuperview().offset(-64)
            make.left.equalToSuperview().offset(64)
            make.height.equalTo(300)
        }
        animationView.play()
    }
    
    private func configureAppereance() {
        toggle = LOTAnimatedSwitch(named: "Switch_States")
        toggle.setOn(false, animated: false)
        toggle.setProgressRangeForOnState(fromProgress: 1, toProgress: 0)
        toggle.setProgressRangeForOffState(fromProgress: 0, toProgress: 1)
        
        toggle.addTarget(self, action: #selector(switchTapped), for: .valueChanged)
        view.addSubview(toggle)
        
        toggle.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(70)
            make.width.equalTo(140)
        }
    }
    
    @objc
    private func backButtonTapped() {
        onFinish?()
    }
    
    @objc
    private func switchTapped() {
        if toggle.isOn {
            configurePenguin()
        } else {
            animationView.stop()
            animationView.removeFromSuperview()
        }
    }
}
