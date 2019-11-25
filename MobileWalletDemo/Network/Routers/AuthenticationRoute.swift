//
// AuthenticationRoute.swift
// MobileWalletDemo
//

import UIKit
import Alamofire

enum AuthenticationRoute: HTTPRouter {
    
    case signup(username: String, password: String)
    case authenticate(username: String, password: String)
    
    var baseURL: String {
        return ConfigurationURLs.auth.rawValue
    }
    
    internal var method: HTTPMethod {
        switch self {
        case .signup, .authenticate:
            return .post
        }
    }
    
    internal var path: String {
        switch self {
        case .signup:
            return "signup"
        case .authenticate:
            return "auth"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case let .signup(username, password):
            return ["username": username, "password": password]
        default:
            return nil
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case let .authenticate(username, password):
            let loginString = String(format: "%@:%@", username, password)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString()
            return ["Authorization": "Basic \(base64LoginString)"]
        default:
            return nil
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        return try JSONEncoding.default.encode(request, with: parameters)
    }
}
