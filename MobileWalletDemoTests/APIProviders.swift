//
// APIProviders.swift
// MobileWalletDemo
//

import XCTest
@testable import MobileWalletDemo

class APIProviders: XCTestCase {
    
    let username: String = "bob"
    let password: String = "test"
    
    func testSignup() {
        let authExpectation = expectation(description: "auth")
        var authResponse: AuthResponse?
        let signupProvider = SignUpProvider()
        if let accessToken = SessionManager.accessToken {
            authResponse = AuthResponse(accessToken: accessToken)
            authExpectation.fulfill()
        } else {
            signupProvider.signup(withUsername: username, password: password, responseHandler: { (auth, error) in
                authResponse = auth
                authExpectation.fulfill()
            })
        }
        
        waitForExpectations(timeout: 3) { (error) in
            self.testSignin()
            XCTAssertNotNil(authResponse)
        }
    }
    
    func testSignin() {
        let authExpectation = expectation(description: "auth")
        var authResponse: AuthResponse?
        let signupProvider = SignInProvider()
        signupProvider.signIn(withUsername: self.username, password: self.password, responseHandler: { (auth, error) in
            authResponse = auth
            if let accessToken = auth?.accessToken?.data(using: .utf8, allowLossyConversion: false),
                KeychainService.save(key: .token, data: accessToken) {
                authExpectation.fulfill()
            }
        })
        
        waitForExpectations(timeout: 3) { (error) in
            XCTAssertNotNil(authResponse)
        }
    }
    
    func testTransactionApis() {

        let balanceExpectation = expectation(description: "balance")
        let homeProvider = HomeProvider()
        var balanceResponse: BalanceResponse?
        var balanceString: String = "50"
        
        homeProvider.addMoney(amount: "100") { (balance, error) in
            balanceResponse = balance
            
            let amountToTransfer = Int(Double(balanceResponse?.amount ?? "0") ?? 0) - 50
            homeProvider.transfer(withUsername: "nish1", amount: amountToTransfer.description) { (report, error) in
                if report == nil {
                    balanceResponse = nil
                    balanceExpectation.fulfill()
                }
                homeProvider.loadBalance(isShowProgress: false) { (balance, error) in
                    balanceString = balance?.amount ?? ""
                    balanceResponse = balance
                    balanceExpectation.fulfill()
                }
            }
        }
        
        waitForExpectations(timeout: 6) { (error) in
            XCTAssertEqual(balanceString, "50")
            XCTAssertNotNil(balanceResponse)
        }
    }
}
