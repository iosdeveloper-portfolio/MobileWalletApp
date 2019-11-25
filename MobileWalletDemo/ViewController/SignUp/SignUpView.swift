//
// SignUpView.swift
// MobileWalletDemo
//

import UIKit

protocol SignUpView: class {
    func requestAndValidationFailure(withError error: String?)
    func requestSuccess()
}
