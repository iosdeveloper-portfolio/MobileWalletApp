//
// AuthResponse.swift
// MobileWalletDemo
//

import UIKit

struct AuthResponse: Codable {
    var accessToken: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}
