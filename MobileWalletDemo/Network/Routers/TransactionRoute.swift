//
// TransactionRoute.swift
// MobileWalletDemo
//

import UIKit
import Alamofire

enum TransactionRoute: HTTPRouter {
    
    case issue(amount: String)
    case transfer(to: String, amount: String)
    case balance
    case report
    
    internal var method: HTTPMethod {
        switch self {
        case .balance, .report:
            return .get
        case .issue, .transfer:
            return .post
        }
    }
    
    internal var path: String {
        switch self {
        case .issue: return "issue"
        case .transfer: return "transfer"
        case .balance: return "balance"
        case .report: return "report"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case let .issue(amount):
            return ["amount": amount]
        case let .transfer(to, amount):
            return ["to": to, "amount": amount]
        default:
            return nil
        }
    }
    
    var headers: [String : String]? {
        if let accessToken = SessionManager.accessToken {
            return ["Authorization": "Bearer \(accessToken)"]
        }
        return nil
    }
    
    public func asURLRequest() throws -> URLRequest {
        return try JSONEncoding.default.encode(request, with: parameters)
    }
}
