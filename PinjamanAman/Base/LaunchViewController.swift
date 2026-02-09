//
//  LaunchViewController.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/9.
//

import UIKit
import SnapKit
import Alamofire

class LaunchViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "q_lac_image")
        bgImageView.contentMode = .scaleAspectFill
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        NetworkMonitor.shared.startMonitoring { isReachable, connectionType in
            if isReachable {
                if connectionType == .ethernetOrWiFi {
                    NetworkMonitor.shared.stopMonitoring()
                } else if connectionType == .cellular {
                    NetworkMonitor.shared.stopMonitoring()
                }
            } else {
                print("network===lose===🧊===")
            }
        }
        
    }
    
}

extension LaunchViewController {
    
}
