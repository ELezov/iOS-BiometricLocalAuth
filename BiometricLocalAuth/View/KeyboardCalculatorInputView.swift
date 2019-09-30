//
//  KeyboardCalculatorInputView.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 26.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import UIKit

class KeyboardCalculatorInputView: UIView {

    enum Constants {
        static let containerViewHeight: CGFloat = 200.0
        static let topViewHeight: CGFloat = 60.0
        static let bottomViewHeight: CGFloat = 40.0
        static let inputFieldHeight: CGFloat = 50.0
    }
    
    var buttonAction: ZeroButtonActionBlock?
    
    var containerView: UIView = UIView()
    var plusButton: UIButton = UIButton()
    var minusButton: UIButton = UIButton()
    
    var isAnimating = false
    
    
    init() {
        super.init(frame: CGRect.zero)
        setupContainerView()
        setupButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupContainerView() {
        containerView = UIView()
        self.addSubview(containerView)
        
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(self).priority(700)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
            make.height.equalTo(50.0)
        }
        containerView.backgroundColor = UIColor.lightGray
    }
    
    private func setupButtons() {
        
        let stackView = UIStackView()
        containerView.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        stackView.addArrangedSubview(plusButton)
        plusButton.setTitle("+", for: .normal)
        plusButton.setTitleColor(UIColor.black, for: .normal)
        
        stackView.addArrangedSubview(minusButton)
        minusButton.setTitle("-", for: .normal)
        minusButton.setTitleColor(UIColor.black, for: .normal)
    }

}
