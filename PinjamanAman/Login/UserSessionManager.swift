//
//  UserSessionManager.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/9.
//

import Foundation

class UserSessionManager {
    
    static let shared = UserSessionManager()
    private init() {}
    
    private let phoneKey = "user_phone"
    private let tokenKey = "user_token"
    
    var phone: String? {
        get {
            return UserDefaults.standard.string(forKey: phoneKey)
        }
        set {
            if let newPhone = newValue {
                UserDefaults.standard.set(newPhone, forKey: phoneKey)
            } else {
                UserDefaults.standard.removeObject(forKey: phoneKey)
            }
            UserDefaults.standard.synchronize()
        }
    }
    
    var token: String? {
        get {
            return UserDefaults.standard.string(forKey: tokenKey)
        }
        set {
            if let newToken = newValue {
                UserDefaults.standard.set(newToken, forKey: tokenKey)
            } else {
                UserDefaults.standard.removeObject(forKey: tokenKey)
            }
            UserDefaults.standard.synchronize()
        }
    }
    
    var isLoggedIn: Bool {
        return token != nil && phone != nil
    }
    
    func saveLoginInfo(phone: String, token: String) {
        self.phone = phone
        self.token = token
    }
    
    func clearLoginInfo() {
//        phone = nil
        token = nil
    }
    
}

class AppLanguageCodeManager {
    
    static func saveLanguageCode(code: String) {
        UserDefaults.standard.set(code, forKey: "languageCode")
        UserDefaults.standard.synchronize()
    }
    
    static func getLanguageCode() -> String {
        let languageCode = UserDefaults.standard.object(forKey: "languageCode") as? String ?? ""
        return languageCode
    }
    
}
