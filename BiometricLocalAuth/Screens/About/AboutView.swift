//
//  AboutView.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 31.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import UIKit

protocol AboutView: BaseView {
     var onLogOut: (() -> Void)? { get set }
}


