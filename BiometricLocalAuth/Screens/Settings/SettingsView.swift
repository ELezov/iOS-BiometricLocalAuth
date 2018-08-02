//
//  SettingsView.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 01.08.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import UIKit

protocol SettingsView: BaseView {
    var onFinish: (() -> Void)? { get set }
    var isBack: Bool { get set }
}
