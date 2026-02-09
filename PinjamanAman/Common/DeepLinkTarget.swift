//
//  DeepLinkTarget.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/9.
//


import UIKit

let scheme_url = "dapatkan://dana.dapatkan.app"

enum DeepLinkTarget {
    
    case main
    case setting
    case login
    case order
    case productDetail(id: String)

    private static let scheme = "dapatkan"
    private static let host = "dana.dapatkan.app"

    init?(url: URL) {
        guard url.scheme == Self.scheme, url.host == Self.host else { return nil }
        
        let path = url.path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        
        let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems
        let params = queryItems?.reduce(into: [String: String]()) { $0[$1.name] = $1.value } ?? [:]

        switch path {
        case "daily":
            self = .main
            
        case "always":
            self = .setting
            
        case "sorrow":
            self = .login
            
        case "enrich":
            self = .order
            
        case "family":
            let productID = params["transform"] ?? ""
            self = .productDetail(id: productID)
            
        default:
            return nil
        }
    }
}

final class DeepLinkNavigator {
    
    static func navigate(to link: String, from sender: UIViewController) {
        guard let url = URL(string: link),
              let target = DeepLinkTarget(url: url) else {
            return
        }
        
        guard let nav = sender.navigationController else {
            return
        }
        
        switch target {
        case .setting:
            let vc = SettingViewController()
            nav.pushViewController(vc, animated: true)
            
        case .productDetail(let productID):
            let vc = ProductStepListViewController()
            vc.productID = productID
            nav.pushViewController(vc, animated: true)
            
        case .main:
            NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil, userInfo: ["tab": 0])
            
        case .login:
            UserSessionManager.shared.clearLoginInfo()
            NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil, userInfo: ["tab": 0])
            
        case .order:
            NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil, userInfo: ["tab": 1])
            
        }
    }
}
