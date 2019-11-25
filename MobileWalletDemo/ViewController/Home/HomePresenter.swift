//
// HomePresenter.swift
// MobileWalletDemo
//

import UIKit

class HomePresenter: NSObject {

    var provider: HomeProvider?
    weak private var homeView: HomeView?
    
    var balance: BalanceResponse?
    var reportResults: [ReportResults] = []
    
    // MARK: - Initialization & Configuration
    init(provider: HomeProvider) {
        self.provider = provider
    }
    
    func attachView(view: HomeView?) {
        guard let view = view else { return }
        self.homeView = view
    }
    
    func loadBalance(isShowProgress: Bool = true) {
        provider?.loadBalance(isShowProgress: isShowProgress, responseHandler: { (response, error) in
            if let balance = response {
                self.balance = balance
                self.homeView?.balanceRequestSuccess(withBalance: balance)
            } else {
                self.homeView?.requestAndValidationFailure(withError: error)
            }
        })
    }
    
    func fetchReports(isShowProgress: Bool = true) {
        provider?.fetchReports(isShowProgress: isShowProgress, responseHandler: { (response, error) in
            if let report = response {
                self.reportResults = (report.results ?? []).reversed()
                self.homeView?.reportRequestSuccess(withReport: report)
            } else {
                self.homeView?.requestAndValidationFailure(withError: error)
            }
        })
    }
    
    func addMoney(amount: String) {
        provider?.addMoney(amount: amount, responseHandler: { (response, error) in
            if let balance = response {
                self.balance = balance
                self.fetchReports()
                self.homeView?.balanceRequestSuccess(withBalance: balance)
            } else {
                self.homeView?.requestAndValidationFailure(withError: error)
            }
        })
    }
    
    func transfer(withUsername to: String?, amount: String?) {
        guard let to = to, to.isValid else {
            homeView?.requestAndValidationFailure(withError: LocalizedString.Validation.usernameEmpty)
            return
        }
        
        guard let amount = amount, amount.isValid else {
            homeView?.requestAndValidationFailure(withError: LocalizedString.Validation.amountEmpty)
            return
        }
        
        guard to != SessionManager.username else {
            homeView?.requestAndValidationFailure(withError: LocalizedString.Validation.transferMoneyOnSameAccount)
            return
        }
        
        guard let a = Double(amount), a > 0, a < (Double(self.balance?.amount ?? "0") ?? 00) else {
            homeView?.requestAndValidationFailure(withError: LocalizedString.Validation.notEnoughBalanceAddMoney)
            return
        }
        
        provider?.transfer(withUsername: to, amount: amount, responseHandler: { (response, error) in
            if let report = response {
                self.reportResults = (response?.results ?? []).reversed()
                self.loadBalance()
                self.homeView?.reportRequestSuccess(withReport: report)
            } else {
                self.homeView?.requestAndValidationFailure(withError: error)
            }
        })
    }
}
