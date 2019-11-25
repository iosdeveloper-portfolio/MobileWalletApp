//
// HomeView.swift
// MobileWalletDemo
//

import UIKit

protocol HomeView: class {
    func requestAndValidationFailure(withError error: String?)
    func balanceRequestSuccess(withBalance balance: BalanceResponse)
    func reportRequestSuccess(withReport report: ReportResponse)
}
