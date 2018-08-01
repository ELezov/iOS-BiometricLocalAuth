//
//  LogInSuccessView.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 31.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import Foundation

protocol LogInSuccessView: BaseView {
    var onCompleteAuth: (() -> Void)? { get set }
    var onFinish: (() -> Void)? { get set }
    var onContinueButtonTap: (() -> Void)? { get set }
}
