// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum L10n {

  enum Auth {
    /// Be carefull
    static let carefull = L10n.tr("Localizable", "auth.carefull")
    /// Auth Failed
    static let failed = L10n.tr("Localizable", "auth.failed")

    enum Biometric {
      /// You biometric data was changed
      static let changed = L10n.tr("Localizable", "auth.biometric.changed")
    }
  }

  enum Biometry {
    /// Authentication could not continue because the user has been locked out of biometric authentication, due to failing authentication too many times.
    static let lockout = L10n.tr("Localizable", "biometry.lockout")
    /// Authentication could not start because the device does not support biometric authentication.
    static let notAvailable = L10n.tr("Localizable", "biometry.notAvailable")
    /// Authentication could not start because the user has not enrolled in biometric authentication.
    static let notEnrolled = L10n.tr("Localizable", "biometry.notEnrolled")
    /// Did not find error code on LAError object
    static let unknown = L10n.tr("Localizable", "biometry.unknown")
  }

  enum Touchid {
    /// Too many failed attempts.
    static let lockout = L10n.tr("Localizable", "touchId.lockout")
    /// TouchID is not available on the device
    static let notAvailable = L10n.tr("Localizable", "touchId.notAvailable")
    /// TouchID is not enrolled on the device
    static let notEnrolled = L10n.tr("Localizable", "touchId.notEnrolled")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
