//
// String+Localized.swift
// MobileWalletDemo
//

import UIKit

struct LocalizedString {
    
    struct Errors {
        static let genericError = "Error_genric".localized
        static let networkUnreachableError  = "Error_no_internet".localized
        static let enterComment = "Error_empty_comment".localized
    }
    
    struct Validation {
        static let usernameEmpty = "Username_empty".localized
        static let passwordEmpty = "Password_empty".localized
        static let amountEmpty = "Amount_empty".localized
        static let transferMoneyOnSameAccount = "Transfer_money_on_same_account".localized
        static let notEnoughBalanceAddMoney = "Not_enough_balance_add_money".localized
    }
    
    struct Alert {
        static let genericTitle = "Alert_title".localized
        static let ok = "Alert_Ok".localized
    }
    
    struct Placeholder {
        static let username = "Username".localized
        static let password = "Password".localized
        static let enterAmount = "Enter Amount".localized
    }
    
    struct Constants {
        static let loading = "Loading".localized
        static let noTransactionFound = "No_transaction_found".localized
        static let transactionHistory = "Transaction_history".localized
        static let availableBalance = "Available_balance".localized
        static let signedUpSuccess = "Signed_up_success".localized
        static let balance = "Balance".localized
        
        //Buttons
        static let signup = "Signup".localized
        static let signin = "Signin".localized
        static let addMoney = "Add_money".localized
        static let sendMoney = "Send_money".localized
        static let dontHaveAccount = "Dont_have_account".localized
    }
}
