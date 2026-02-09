//
//  AppDelegate.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/9.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        changeRootVcNoti()
        window = UIWindow(frame: .zero)
        window?.frame = UIScreen.main.bounds
        window?.rootViewController = LaunchViewController()
        window?.makeKeyAndVisible()
        return true
    }

}

extension AppDelegate {
    
    private func changeRootVcNoti() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        NotificationCenter.default.addObserver(self, selector: #selector(changeRootVc(_:)), name: NSNotification.Name("changeRootVc"), object: nil)
    }
    
    @objc func changeRootVc(_ noti: Notification) {
        if UserSessionManager.shared.isLoggedIn {
            let tabBar = BaseTabBarController()
            window?.rootViewController = tabBar
        }else {
            window?.rootViewController = BaseNavigationController(rootViewController: LoginViewController())
        }
    }
    
}
