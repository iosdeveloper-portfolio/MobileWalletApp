//
// SignInView.swift
// MobileWalletDemo
//

import UIKit

protocol SignInView: class {
    func requestAndValidationFailure(withError error: String?)
    func requestSuccess(withAuth auth: AuthResponse)
}
