//
// SessionManager.swift
// MobileWalletDemo
//

import Foundation
import Security

class KeychainService {
    
    public enum Keys: String {
        case token = "AuthenticatedUserToken"
        case username = "AuthenticatedUsername"
    }

    @discardableResult
    class func save(key: Keys, data: Data) -> Bool {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key.rawValue,
            kSecValueData as String   : data ] as [String : Any]

        SecItemDelete(query as CFDictionary)

        let status: OSStatus = SecItemAdd(query as CFDictionary, nil)
        return status == noErr
    }

    class func load(key: Keys) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key.rawValue,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]

        var dataTypeRef: AnyObject? = nil

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
    
    class func delete(key: Keys) -> Bool {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key.rawValue ] as [String : Any]
        let status: OSStatus = SecItemDelete(query as CFDictionary)
        return status == noErr
    }
}

extension Data {

    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }

    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.load(as: T.self) }
    }
}
