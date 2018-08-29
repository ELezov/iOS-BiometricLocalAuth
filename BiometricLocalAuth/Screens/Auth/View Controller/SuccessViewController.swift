//
//  SuccessViewController.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 02.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import UIKit
import Lottie

class SuccessViewController: UIViewController, LogInSuccessView {
    var onFinish: (() -> Void)?
    
    var onContinueButtonTap: (() -> Void)?
    
    var onCompleteAuth: (() -> Void)?
    
    var animationView: LOTAnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        animationView.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
        animationView.stop()
    }
    
    private func configureAnimation() {
        animationView = LOTAnimationView(name: "success")
        view.addSubview(animationView)
        animationView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(animationView.snp.height)
        }
        animationView.contentMode = .scaleAspectFill
    }

    @IBAction func actionButtonTapped(_ sender: Any) {
        onCompleteAuth?()
    }
}
