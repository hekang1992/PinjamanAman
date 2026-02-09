//
//  AppDelegate.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/9.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: .zero)
        window?.frame = UIScreen.main.bounds
        window?.rootViewController = LaunchViewController()
        window?.makeKeyAndVisible()
        return true
    }

}

extension AppDelegate {
    
}
