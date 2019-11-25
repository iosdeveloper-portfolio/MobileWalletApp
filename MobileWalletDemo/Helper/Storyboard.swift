//
// Storyboard.swift
// MobileWalletDemo
//

import UIKit
import IQKeyboardManager

enum Storyboard: String {
    case Main
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func instantiateViewController<T : UIViewController>(withClass viewController: T.Type) -> T {
        let storyboardID = viewController.storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
    
    func navigationCotrollerWith<T: UINavigationController>(identifier: String) -> T {
        return instance.instantiateViewController(withIdentifier: identifier) as! T
    }
    
    static func barConfigure() {
        UINavigationBar.appearance().barTintColor = UIColor.appColor
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().toolbarBarTintColor = UIColor.appColor
        IQKeyboardManager.shared().toolbarTintColor = UIColor.white
    }
}

extension UIViewController {
    class var storyboardID : String {
        return String(describing: self)
    }
}


