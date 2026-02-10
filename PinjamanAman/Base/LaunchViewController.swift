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
        
        NetworkMonitor.shared.startMonitoring { [weak self] isReachable, connectionType in
            if isReachable {
                if connectionType == .ethernetOrWiFi {
                    self?.appInfo()
                    NetworkMonitor.shared.stopMonitoring()
                } else if connectionType == .cellular {
                    self?.appInfo()
                    NetworkMonitor.shared.stopMonitoring()
                }
            } else {
                print("network===lose===🧊===")
            }
        }
        
    }
    
}

extension LaunchViewController {
    
    private func appInfo() {
        LoadingView.shared.show()
        NetworkManager.post(url: "/patkan/center/experience/emotions",
                            responseType: BaseModel.self) { result in
            switch result {
            case .success(let success):
                LoadingView.shared.hide()
                let partner = success.partner ?? ""
                if ["0", "00"].contains(partner) {
                    let languageCode = success.logic?.realm ?? ""
                    AppLanguageCodeManager.saveLanguageCode(code: languageCode)
//                    AppLanguageCodeManager.saveLanguageCode(code: "1105")
                    Task {
                        try? await Task.sleep(nanoseconds: 250_000_000)
                        NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil)
                    }
                }
                
            case .failure(_):
                LoadingView.shared.hide()
            }
        }
    }
    
}

