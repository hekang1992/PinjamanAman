//
//  AppIdentifierManager.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/9.
//

import Foundation
import AdSupport
import Security
import UIKit

class AppIdentifierManager {
    
    private static let service = Bundle.main.bundleIdentifier ?? "com.app.device"
    private static let idfvKey = "device_idfv_key"
    
    private class func saveToKeychain(_ value: String, forKey key: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    private class func loadFromKeychain(forKey key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    class func getIDFV() -> String {
        if let savedIDFV = loadFromKeychain(forKey: idfvKey), !savedIDFV.isEmpty {
            return savedIDFV
        }
        
        let newIDFV = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
        
        _ = saveToKeychain(newIDFV, forKey: idfvKey)
        
        return newIDFV
    }
    
    class func getIDFA() -> String? {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
}
