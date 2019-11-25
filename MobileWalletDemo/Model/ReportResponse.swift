//
// ReportResponse.swift
// MobileWalletDemo
//

import UIKit

struct ReportResponse: Codable {
    let count: String?
    let results: [ReportResults]?
}

struct ReportResults: Codable {
    let id: String?
    let amount: String?
    let createdAt: String?
    let to: String?
    let from: String?
}
