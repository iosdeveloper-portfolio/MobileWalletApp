//
// SessionManager.swift
// MobileWalletDemo
//

import UIKit

class SessionManager {
    
    static var accessToken: String? {
        //self.logoutUser()
        if let token = KeychainService.load(key: .token),
            let accessToken = String(data: token, encoding: .utf8),
            accessToken.isValid {
            
            return accessToken
        }
        return nil
    }
    
    static var username: String? {
        if let token = KeychainService.load(key: .username),
            let username = String(data: token, encoding: .utf8),
            username.isValid {
            return username
        }
        return nil
    }
    
    static func setupRootView() {
        if (SessionManager.accessToken != nil) {
            let homeVc = Storyboard.Main.instantiateViewController(withClass: HomeViewController.self)
            let navigationController = UINavigationController(rootViewController: homeVc)
            UIApplication.shared.windows.first?.rootViewController = navigationController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
    
    static func logoutUser() {
        if KeychainService.delete(key: .token) && KeychainService.delete(key: .username) {
            let signUpVc = Storyboard.Main.instantiateViewController(withClass: SignInViewController.self)
            let navigation = UINavigationController(rootViewController: signUpVc)
            UIApplication.shared.windows.first?.rootViewController = navigation
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
}
