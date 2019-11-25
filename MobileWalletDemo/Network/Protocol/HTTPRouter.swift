//
// HTTPRouter.swift
// MobileWalletDemo
//

import Foundation
import Alamofire

enum ConfigurationURLs: String {
    case base = "http://mobile-interview.imagine-orb.com:28081"
    case auth = "http://mobile-interview.imagine-orb.com:28080"
}

protocol HTTPRouter: URLRequestConvertible {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
    var request: URLRequest { get }
}

extension HTTPRouter {
    
    var baseURL: String {
        return ConfigurationURLs.base.rawValue
    }
    
    var url: URL {
        return URL(string: baseURL + "/" + path)!
    }
    
    private var parameters: [String: Any]? {
        return nil
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var request: URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.timeoutInterval = 5
        return urlRequest
    }
}
