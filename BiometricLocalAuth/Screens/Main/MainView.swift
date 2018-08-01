//
//  MainView.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 31.07.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import UIKit

protocol MainView: BaseView {
    var onItemFlowSelect: ((UINavigationController) -> ())? { get set }
    var onAboutFlowSelect: ((UINavigationController) -> ())? { get set }
    var onViewDidLoad: ((UINavigationController) -> ())? { get set }
    var finishFlow: (() -> Void)? { get set }
}
