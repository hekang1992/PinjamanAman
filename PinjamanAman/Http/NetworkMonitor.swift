//
//  NetworkMonitor.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/9.
//

import Alamofire

class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private var reachabilityManager: NetworkReachabilityManager?
    private var statusChangeHandler: ((Bool, NetworkReachabilityManager.NetworkReachabilityStatus.ConnectionType?) -> Void)?
    
    private init() {}
    
    func startMonitoring(_ handler: @escaping (Bool, NetworkReachabilityManager.NetworkReachabilityStatus.ConnectionType?) -> Void) {
        self.statusChangeHandler = handler
        
        reachabilityManager = NetworkReachabilityManager()
        
        reachabilityManager?.startListening { [weak self] status in
            guard let self = self else { return }
            
            var isReachable = false
            var connectionType: NetworkReachabilityManager.NetworkReachabilityStatus.ConnectionType?
            
            switch status {
            case .reachable(let type):
                isReachable = true
                connectionType = type
            case .notReachable, .unknown:
                isReachable = false
                connectionType = nil
            }
            
            self.statusChangeHandler?(isReachable, connectionType)
        }
    }
    
    func stopMonitoring() {
        reachabilityManager?.stopListening()
        reachabilityManager = nil
        statusChangeHandler = nil
    }
    
}
