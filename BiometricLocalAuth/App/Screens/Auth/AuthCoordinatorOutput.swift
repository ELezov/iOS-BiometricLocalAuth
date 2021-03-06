//
//  AuthCoordinatorOutput.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 01.08.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import Foundation

protocol AuthCoordinatorOutput: class {
    var finishFlow: (() -> Void)? { get set }
}
