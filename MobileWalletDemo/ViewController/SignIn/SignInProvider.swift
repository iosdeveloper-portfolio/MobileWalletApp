//
// SignInProvider.swift
// MobileWalletDemo
//

import UIKit

struct SignInProvider {
    
    typealias SignInResponseHandler = (AuthResponse?, String?) -> Void
    
    func signIn(withUsername username: String, password: String, responseHandler: @escaping SignInResponseHandler) {
        
        let route = AuthenticationRoute.authenticate(username: username, password: password)
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
