//
//  BiometricAuthHelper.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 07.06.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import Foundation
import LocalAuthentication

public typealias BiometricAuthReply = (Bool, Error?) -> Void

typealias BiometricAuthCheckResult = (Bool, BiometryType, NSError?)

/// Способ авторизации
///
/// - touchID: отпечаток пальца
/// - faceID: слепок лица
enum BiometryType {
    case touchID
    case faceID
}

final class BiometricAuthHelper {
    
    enum Constants {
        static let fallbackTitle = ""
        static let reasonString = "To access the secure data"
    }
    
    /// Проверка доступности тач/фэйс айди с учетом типа
    class var applicationCanUseBiometricAuth: BiometricAuthCheckResult {
        let context = LAContext()
        var biometryType: BiometryType
        var error: NSError?
        let result =  context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        if #available(iOS 11.0, *) {
            if result {
                biometryType = context.biometryType == LABiometryType.faceID ? .faceID : .touchID
            } else {
                biometryType = .touchID
            }
        } else {
            biometryType = .touchID
        }
        return (result, biometryType, error)
    }
    
    // Проверяем, были ли изменены биометрические данные
    func biometricDateIsValid() -> Bool {
        let context = LAContext()
        context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        var result: Bool = true
        // Получаем сохраненный биометрические данные
        let oldDomainState = UserDefaultsHelper.biometricDate
        // Получаем текущие биометрические данные
        guard let domainState = context.evaluatedPolicyDomainState
            else { return result }
        // Сохраняем новые текущие биометрические данные в UserDefaults
        UserDefaultsHelper.biometricDate = domainState
        result = (domainState == oldDomainState || oldDomainState == nil)
        return result
    }
    
    func authenticationWithBiometric(reason: String = Constants.reasonString, reply: @escaping  BiometricAuthReply) {
        let context = LAContext()
        context.localizedFallbackTitle = Constants.fallbackTitle
        /* URL: https://developer.apple.com/documentation/localauthentication/lacontext/1622329-touchidauthenticationallowablere */
        // для технологии "быстрого входа", работает лишь с TouchId
        context.touchIDAuthenticationAllowableReuseDuration = 30
        var authError: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason) { success, evaluateError in
                reply (success, evaluateError)
            }
        } else {
            guard let error = authError else {
                return
            }
            reply (false, error)
        }
    }
    
    func evaluatePolicyFailErrorMessageForLA(errorCode: Int) -> String {
        var message = ""
        if #available(iOS 11.0, macOS 10.13, *) {
            switch errorCode {
            case LAError.biometryNotAvailable.rawValue:
                message = L10n.Biometry.notAvailable
            case LAError.biometryLockout.rawValue:
                message = L10n.Biometry.lockout
            case LAError.biometryNotEnrolled.rawValue:
                message = L10n.Biometry.notEnrolled
            default:
                message = L10n.Biometry.unknown
            }
        } else {
            switch errorCode {
            case LAError.touchIDLockout.rawValue:
                message = L10n.Touchid.lockout
            case LAError.touchIDNotAvailable.rawValue:
                message = L10n.Touchid.notAvailable
            case LAError.touchIDNotEnrolled.rawValue:
                message = L10n.Touchid.notEnrolled
            default:
                message = L10n.Biometry.unknown
            }
        }
        return message
    }
    
    func evaluateAuthenticationPolicyMessageForLA(errorCode: Int) -> String {
        var message = ""
        switch errorCode {
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
        case LAError.notInteractive.rawValue:
            message = "Not interactive"
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
        default:
            message = evaluatePolicyFailErrorMessageForLA(errorCode: errorCode)
        }
        return message
    }
}
