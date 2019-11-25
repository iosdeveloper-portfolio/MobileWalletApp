//
// NetworkError.swift
// MobileWalletDemo
//

import UIKit

enum NetworkError: MobileWalletLocalizedError {
    
    case errorString(String)
    case error(code: Double?, message: String)
    case generic
    
    var errorDescription: String? {
        switch self {
        case .errorString(let errorMessage): return errorMessage
        case .error(_,let message): return message
        case .generic: return LocalizedString.Errors.genericError
        }
    }
}


protocol MobileWalletLocalizedError: LocalizedError {
    var title: String { get }
    var localDescription: String { get }
}

extension MobileWalletLocalizedError {
    var title: String {
        return ""
    }
    
    var localDescription : String {
        return ""
    }
}
