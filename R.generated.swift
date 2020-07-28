//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 4 storyboards.
  struct storyboard {
    /// Storyboard `Authorization`.
    static let authorization = _R.storyboard.authorization()
    /// Storyboard `Donor`.
    static let donor = _R.storyboard.donor()
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Patient`.
    static let patient = _R.storyboard.patient()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Authorization", bundle: ...)`
    static func authorization(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.authorization)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Donor", bundle: ...)`
    static func donor(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.donor)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Patient", bundle: ...)`
    static func patient(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.patient)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.file` struct is generated, and contains static references to 1 files.
  struct file {
    /// Resource file `GoogleService-Info.plist`.
    static let googleServiceInfoPlist = Rswift.FileResource(bundle: R.hostingBundle, name: "GoogleService-Info", pathExtension: "plist")

    /// `bundle.url(forResource: "GoogleService-Info", withExtension: "plist")`
    static func googleServiceInfoPlist(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.googleServiceInfoPlist
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 6 images.
  struct image {
    /// Image `Group_16`.
    static let group_16 = Rswift.ImageResource(bundle: R.hostingBundle, name: "Group_16")
    /// Image `cancel`.
    static let cancel = Rswift.ImageResource(bundle: R.hostingBundle, name: "cancel")
    /// Image `heartRequest`.
    static let heartRequest = Rswift.ImageResource(bundle: R.hostingBundle, name: "heartRequest")
    /// Image `launchScreenImage`.
    static let launchScreenImage = Rswift.ImageResource(bundle: R.hostingBundle, name: "launchScreenImage")
    /// Image `loadingCat`.
    static let loadingCat = Rswift.ImageResource(bundle: R.hostingBundle, name: "loadingCat")
    /// Image `patientDefaultImage`.
    static let patientDefaultImage = Rswift.ImageResource(bundle: R.hostingBundle, name: "patientDefaultImage")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Group_16", bundle: ..., traitCollection: ...)`
    static func group_16(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.group_16, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "cancel", bundle: ..., traitCollection: ...)`
    static func cancel(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.cancel, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "heartRequest", bundle: ..., traitCollection: ...)`
    static func heartRequest(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.heartRequest, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "launchScreenImage", bundle: ..., traitCollection: ...)`
    static func launchScreenImage(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.launchScreenImage, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "loadingCat", bundle: ..., traitCollection: ...)`
    static func loadingCat(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.loadingCat, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "patientDefaultImage", bundle: ..., traitCollection: ...)`
    static func patientDefaultImage(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.patientDefaultImage, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 1 nibs.
  struct nib {
    /// Nib `DonorCell`.
    static let donorCell = _R.nib._DonorCell()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "DonorCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.donorCell) instead")
    static func donorCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.donorCell)
    }
    #endif

    static func donorCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> DonorCell? {
      return R.nib.donorCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? DonorCell
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib {
    struct _DonorCell: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "DonorCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> DonorCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? DonorCell
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try authorization.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try donor.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try patient.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct authorization: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = AuthViewController

      let bundle = R.hostingBundle
      let name = "Authorization"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct donor: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController

      let acceptRequestViewController = StoryboardViewControllerResource<AcceptRequestViewController>(identifier: "AcceptRequestViewController")
      let bundle = R.hostingBundle
      let donorPickerViewController = StoryboardViewControllerResource<DonorPickerViewController>(identifier: "DonorPickerViewController")
      let donorViewController = StoryboardViewControllerResource<DonorViewController>(identifier: "DonorViewController")
      let name = "Donor"
      let navigationController = StoryboardViewControllerResource<UIKit.UINavigationController>(identifier: "NavigationController")

      func acceptRequestViewController(_: Void = ()) -> AcceptRequestViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: acceptRequestViewController)
      }

      func donorPickerViewController(_: Void = ()) -> DonorPickerViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: donorPickerViewController)
      }

      func donorViewController(_: Void = ()) -> DonorViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: donorViewController)
      }

      func navigationController(_: Void = ()) -> UIKit.UINavigationController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: navigationController)
      }

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.donor().acceptRequestViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'acceptRequestViewController' could not be loaded from storyboard 'Donor' as 'AcceptRequestViewController'.") }
        if _R.storyboard.donor().donorPickerViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'donorPickerViewController' could not be loaded from storyboard 'Donor' as 'DonorPickerViewController'.") }
        if _R.storyboard.donor().donorViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'donorViewController' could not be loaded from storyboard 'Donor' as 'DonorViewController'.") }
        if _R.storyboard.donor().navigationController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'navigationController' could not be loaded from storyboard 'Donor' as 'UIKit.UINavigationController'.") }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if UIKit.UIImage(named: "launchScreenImage", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'launchScreenImage' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct patient: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController

      let bundle = R.hostingBundle
      let name = "Patient"
      let navigationController = StoryboardViewControllerResource<UIKit.UINavigationController>(identifier: "NavigationController")
      let patientViewController = StoryboardViewControllerResource<PatientViewController>(identifier: "PatientViewController")
      let pickerViewController = StoryboardViewControllerResource<PickerViewController>(identifier: "PickerViewController")

      func navigationController(_: Void = ()) -> UIKit.UINavigationController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: navigationController)
      }

      func patientViewController(_: Void = ()) -> PatientViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: patientViewController)
      }

      func pickerViewController(_: Void = ()) -> PickerViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: pickerViewController)
      }

      static func validate() throws {
        if UIKit.UIImage(named: "Group_16", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'Group_16' is used in storyboard 'Patient', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.patient().navigationController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'navigationController' could not be loaded from storyboard 'Patient' as 'UIKit.UINavigationController'.") }
        if _R.storyboard.patient().patientViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'patientViewController' could not be loaded from storyboard 'Patient' as 'PatientViewController'.") }
        if _R.storyboard.patient().pickerViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'pickerViewController' could not be loaded from storyboard 'Patient' as 'PickerViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
