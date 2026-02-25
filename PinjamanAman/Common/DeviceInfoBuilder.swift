//
//  DeviceInfoBuilder.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/11.
//

import UIKit
import SystemConfiguration.CaptiveNetwork
import AdSupport
import AppTrackingTransparency
import CoreTelephony
import SystemConfiguration
import Darwin
import MachO
import DeviceKit
import NetworkExtension

final class DeviceInfoBuilder {
    
    static let shared = DeviceInfoBuilder()
    private init() {}
    
    func build(completion: @escaping ([String: Any]) -> Void) {
        
        getWiFiInfo { wifiInfo in
            
            let result: [String: Any] = [
                "fading": self.fading(),
                "spring": self.spring(),
                "grove": self.grove(),
                "sight": [:],
                "inspiration": "",
                "beyond": self.beyond(),
                "especially": self.especially(wifi: wifiInfo),
                "oxygen": [
                    "global": [wifiInfo]
                ]
            ]
            
            completion(result)
        }
    }
}

private extension DeviceInfoBuilder {
    
    func fading() -> [String: Any] {
        
        let totalDisk = UIDevice.current.totalDiskSpace()
        let freeDisk = UIDevice.current.freeDiskSpace()
        let totalMemory = ProcessInfo.processInfo.physicalMemory
        let freeMemory = reportFreeMemory()
        
        return [
            "gradually": "\(freeDisk)",
            "then": "\(totalDisk)",
            "thriving": "\(totalMemory)",
            "growing": "\(freeMemory)"
        ]
    }
    
    func spring() -> [String: Any] {
        
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        let level = max(0, Int(UIDevice.current.batteryLevel * 100))
        let charging = UIDevice.current.batteryState == .charging ||
        UIDevice.current.batteryState == .full
        
        return [
            "soil": level,
            "sitting": charging ? 1 : 0
        ]
    }
    
    func grove() -> [String: Any] {
        
        return [
            "walking": UIDevice.current.systemVersion,
            "well": "iPhone",
            "fhaeimories": Device.identifier,
            "mental": Device.current.description,
            "mood": Int(UIScreen.main.bounds.height),
            "positive": Int(UIScreen.main.bounds.width),
            "profoundly": String(Device.current.diagonal)
        ]
    }
    
    func beyond() -> [String: Any] {
        
        return [
            "effect": 100,
            "lack": "0",
            "areas": isSimulator() ? 1 : 0,
            "urban": isJailbroken() ? 1 : 0,
            "important": 0
        ]
    }
    
    func especially(wifi: [String: Any]) -> [String: Any] {
        
        return [
            "absorbing": TimeZone.current.abbreviation() ?? "",
            "reflecting": 0,
            "temperature": isVPNConnected() ? 1 : 0,
            "reduce": carrierName(),
            "shade": AppIdentifierManager.getIDFV(),
            "system": Locale.current.identifier,
            "activities": networkType(),
            "negative": 1,
            "mitigate": currentIP(),
            "dioxide": wifi["gas"] ?? "",
            "respiration": AppIdentifierManager.getIDFA() ?? ""
        ]
    }
}

private extension DeviceInfoBuilder {
    
    func getWiFiInfo(completion: @escaping ([String: Any]) -> Void) {
        NEHotspotNetwork.fetchCurrent { hotspotNetwork in
            guard let network = hotspotNetwork else {
                completion([:])
                return
            }
            
            let wifi: [String: Any] = [
                "gas": network.bssid,
                "greenhouse": network.ssid,
                "dioxide": network.bssid,
                "blend": network.ssid,
            ]
            
            DispatchQueue.main.async {
                completion(wifi)
            }
        }
    }
    
}

private extension DeviceInfoBuilder {
    
    func isSimulator() -> Bool {
#if targetEnvironment(simulator)
        return true
#else
        return false
#endif
    }
    
    func isJailbroken() -> Bool {
        
#if targetEnvironment(simulator)
        return false
#endif
        
        let paths = [
            "/Applications/Cydia.app",
            "/usr/sbin/sshd",
            "/bin/bash",
            "/etc/apt"
        ]
        
        for path in paths {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        
        return false
    }
    
    func carrierName() -> String {
        let networkInfo = CTTelephonyNetworkInfo()
        if let carrier = networkInfo.serviceSubscriberCellularProviders?.values.first {
            return carrier.carrierName ?? "-"
        }
        return "-"
    }
    
    func networkType() -> String {
        
        if let reachability = SCNetworkReachabilityCreateWithName(nil, "www.apple.com") {
            var flags = SCNetworkReachabilityFlags()
            SCNetworkReachabilityGetFlags(reachability, &flags)
            
            if flags.contains(.isWWAN) {
                return "5G"
            }
        }
        
        return "WIFI"
    }
    
    func currentIP() -> String {
        
        var address = "0.0.0.0"
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        
        if getifaddrs(&ifaddr) == 0 {
            
            var ptr = ifaddr
            while ptr != nil {
                
                defer { ptr = ptr?.pointee.ifa_next }
                
                guard let interface = ptr?.pointee else { continue }
                let addrFamily = interface.ifa_addr.pointee.sa_family
                
                if addrFamily == UInt8(AF_INET) {
                    
                    let name = String(cString: interface.ifa_name)
                    if name == "en0" {
                        
                        var addr = interface.ifa_addr.pointee
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        
                        getnameinfo(&addr,
                                    socklen_t(interface.ifa_addr.pointee.sa_len),
                                    &hostname,
                                    socklen_t(hostname.count),
                                    nil,
                                    0,
                                    NI_NUMERICHOST)
                        
                        address = String(cString: hostname)
                    }
                }
            }
            
            freeifaddrs(ifaddr)
        }
        
        return address
    }
    
    func isVPNConnected() -> Bool {
        if let settings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any],
           let scopes = settings["__SCOPED__"] as? [String: Any] {
            for key in scopes.keys {
                if key.contains("tap") || key.contains("tun") || key.contains("ppp") {
                    return true
                }
            }
        }
        return false
    }
    
    func reportFreeMemory() -> UInt64 {
        var stats = vm_statistics64()
        var count = mach_msg_type_number_t(MemoryLayout<vm_statistics64_data_t>.size / MemoryLayout<integer_t>.size)
        
        let result = withUnsafeMutablePointer(to: &stats) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                host_statistics64(mach_host_self(), HOST_VM_INFO64, $0, &count)
            }
        }
        
        if result == KERN_SUCCESS {
            let pageSize = UInt64(vm_kernel_page_size)
            
            let free = UInt64(stats.free_count)
//            let inactive = UInt64(stats.inactive_count)
            let speculative = UInt64(stats.speculative_count)
            let purgeable = UInt64(stats.purgeable_count)
            let compressor = UInt64(stats.compressor_page_count)
            let availableMemory = (free + speculative + purgeable + compressor) * pageSize
            return availableMemory
        }
        
        return 0
    }
    
}

extension UIDevice {
    
    func totalDiskSpace() -> Int64 {
        let attr = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
        return attr?[.systemSize] as? Int64 ?? 0
    }
    
    func freeDiskSpace() -> Int64 {
        let attr = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
        return attr?[.systemFreeSize] as? Int64 ?? 0
    }
}
