//
// SignInPresenter.swift
// MobileWalletDemo
//

import UIKit

class SignInPresenter {
    
    var provider: SignInProvider?
    weak private var signInView: SignInView?
    
    // MARK: - Initialization & Configuration
    init(provider: SignInProvider) {
        self.provider = provider
    }
    
    func attachView(view: SignInView?) {
        guard let view = view else { return }
        self.signInView = view
    }
    
    func signIn(withUsername username: String?, password: String?) {
        guard let username = username, username.isValid else {
            signInView?.requestAndValidationFailure(withError: LocalizedString.Validation.usernameEmpty)
            return
        }
        
        guard let password = password, password.isValid else {
            signInView?.requestAndValidationFailure(withError: LocalizedString.Validation.passwordEmpty)
            return
        }
        
        provider?.signIn(withUsername: username, password: password, responseHandler: { (auth, error) in
            if let auth = auth {
                self.signInView?.requestSuccess(withAuth: auth)
            } else {
                self.signInView?.requestAndValidationFailure(withError: error)
            }
        })
    }
}
