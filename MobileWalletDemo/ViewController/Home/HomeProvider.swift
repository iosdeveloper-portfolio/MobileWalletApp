//
// HomeProvider.swift
// MobileWalletDemo
//

import UIKit

struct HomeProvider {

    typealias BalanceResponseHandler = (BalanceResponse?, String?) -> Void
    typealias FetchReportResponseHandler = (ReportResponse?, String?) -> Void
    
    func loadBalance(isShowProgress: Bool, responseHandler: @escaping BalanceResponseHandler) {
        
        NetworkManager.shared.makeRequest(TransactionRoute.balance, isShowProgress: isShowProgress) { (result: Result<BalanceResponse, NetworkError>) in
            
            switch result {
            case .success(let auth):
                responseHandler(auth, nil)
            case .failure(let error):
                responseHandler(nil, error.localizedDescription)
            }
        }
    }
    
    func fetchReports(isShowProgress: Bool, responseHandler: @escaping FetchReportResponseHandler) {
        
        NetworkManager.shared.makeRequest(TransactionRoute.report, isShowProgress: isShowProgress) { (result: Result<ReportResponse, NetworkError>) in
            
            switch result {
            case .success(let auth):
                responseHandler(auth, nil)
            case .failure(let error):
                responseHandler(nil, error.localizedDescription)
            }
        }
    }
    
    func addMoney(amount: String, responseHandler: @escaping BalanceResponseHandler) {
        
        let route = TransactionRoute.issue(amount: amount)
        NetworkManager.shared.makeRequest(route) { (result: Result<BalanceResponse, NetworkError>) in
            
            switch result {
            case .success(_ ):
                self.loadBalance(isShowProgress: true, responseHandler: responseHandler)
            case .failure(let error):
                responseHandler(nil, error.localizedDescription)
            }
        }
    }
    
    func transfer(withUsername to: String, amount: String, responseHandler: @escaping FetchReportResponseHandler) {
        
        let route = TransactionRoute.transfer(to: to, amount: amount)
        NetworkManager.shared.makeRequest(route) { (result: Result<ReportResponse, NetworkError>) in
            
            switch result {
            case .success(_ ):
                self.fetchReports(isShowProgress: true, responseHandler: responseHandler)
            case .failure(let error):
                responseHandler(nil, error.localizedDescription)
            }
        }
    }
}
