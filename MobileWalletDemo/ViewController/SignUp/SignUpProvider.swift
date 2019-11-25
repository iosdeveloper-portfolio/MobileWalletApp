//
// SignUpProvider.swift
// MobileWalletDemo
//

import UIKit

struct SignUpProvider {

    typealias SignUpResponseHandler = (AuthResponse?, String?) -> Void
    
    func signup(withUsername username: String, password: String, responseHandler: @escaping SignUpResponseHandler) {
        
        let route = AuthenticationRoute.signup(username: username, password: password)
        NetworkManager.shared.makeRequest(route, completion: { (result: Swift.Result<AuthResponse, NetworkError>) in
            switch result {
            case .success(let auth):
                responseHandler(auth, nil)
            case .failure(let error):
                responseHandler(nil, error.localizedDescription)
            }
        })
    }
}
