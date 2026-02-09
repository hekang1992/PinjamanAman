//
//  DeviceInfoManager.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/9.
//

import UIKit
import DeviceKit

class DeviceInfoManager {
    
    class func getDeviceInfoDictionary() -> [String: String] {
        var deviceInfo: [String: String] = [:]
        
        deviceInfo["plan"] = "ios"
        
        deviceInfo["floor"] = getAppVersion()
        
        deviceInfo["open"] = Device.current.description
        
        deviceInfo["spacious"] = AppIdentifierManager.getIDFV()
        
        deviceInfo["greeted"] = Device.current.systemVersion
        
        deviceInfo["stepping"] = "appstore-data"
        
        deviceInfo["complements"] = UserSessionManager.shared.token ?? ""
        
        deviceInfo["realm"] = Locale.current.identifier
        
        return deviceInfo
    }
    
    private class func getAppVersion() -> String {
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return appVersion
        }
        return "1.0.0"
    }
    
}

