//
//  AuthView.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 31.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import Foundation

protocol AuthView: BaseView {
    var onCompleteAuth: (() -> Void)? { get set }
    var onLogInSuccess: (() -> Void)? { get set }
    var onManualLogIn: (() -> Void)? { get set }
}
