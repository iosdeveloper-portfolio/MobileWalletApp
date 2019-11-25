//
// String+Extension.swift
// MobileWalletDemo
//

import UIKit

extension String {
    
    public var isValid: Bool {
        if isBlank == false && count > 0 {
            return true
        }
        return false
    }
    
    public var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
            return trimmed.isEmpty
        }
    }

    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", value: "\(self)", comment: "")
    }
    
    func amountLocalized() -> String {
        if let currencySign = Locale.current.currencySymbol {
            return "\(currencySign)\(self)"
        } else {
            return self
        }
    }
}

extension Optional where Wrapped == String {
    public var isBlank: Bool {
        switch self {
        case .none: return true
        case .some(let text):
            return text.isBlank
        }
    }
}


