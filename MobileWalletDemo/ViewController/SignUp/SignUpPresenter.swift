//
// SignUpPresenter.swift
// MobileWalletDemo
//

import UIKit

class SignUpPresenter {
    
    var provider: SignUpProvider?
    weak private var signUpView: SignUpView?
    
    // MARK: - Initialization & Configuration
    init(provider: SignUpProvider) {
        self.provider = provider
    }
    
    func attachView(view: SignUpView?) {
        guard let view = view else { return }
        self.signUpView = view
    }
    
    func signup(withUsername username: String?, password: String?) {
        guard let username = username, username.isValid else {
            signUpView?.requestAndValidationFailure(withError: LocalizedString.Validation.usernameEmpty)
            return
        }
        
        guard let password = password, password.isValid else {
            signUpView?.requestAndValidationFailure(withError: LocalizedString.Validation.passwordEmpty)
            return
        }
        
        provider?.signup(withUsername: username, password: password, responseHandler: { (auth, error) in
            if auth != nil {
                self.signUpView?.requestSuccess()
            } else {
                self.signUpView?.requestAndValidationFailure(withError: error)
            }
        })
    }
}
