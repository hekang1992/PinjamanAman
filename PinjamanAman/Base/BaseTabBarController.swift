//
//  BaseTabBarController.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/9.
//

import UIKit
import CoreLocation

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        self.delegate = self
    }

    private func setupTabBar() {

        let homeVC = HomeViewController()
        let homeNav = BaseNavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "tab_home_nor")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "tab_home_sel")?.withRenderingMode(.alwaysOriginal)
        )
        homeNav.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)

        let orderVC = OrderViewController()
        let orderNav = BaseNavigationController(rootViewController: orderVC)
        orderNav.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "tab_order_nor")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "tab_order_sel")?.withRenderingMode(.alwaysOriginal)
        )
        orderNav.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)

        let meVC = CenterViewController()
        let meNav = BaseNavigationController(rootViewController: meVC)
        meNav.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "tab_me_nor")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "tab_me_sel")?.withRenderingMode(.alwaysOriginal)
        )
        meNav.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)

        viewControllers = [homeNav, orderNav, meNav]

        tabBar.isTranslucent = false
    }
}


extension BaseTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let status = CLLocationManager().authorizationStatus
        let languageCode = AppLanguageCodeManager.getLanguageCode()
        if languageCode == "1100" {
            if status == .denied || status == .restricted {
                let title = languageCode == "1105" ? "Location Permission" : "Izin Lokasi"
                let message = languageCode == "1105" ? "To complete identity verification, we need your location permission. It will only be used for this verification to keep your application secure. Please enable location permission in Settings to continue." : "Untuk menyelesaikan verifikasi identitas, kami memerlukan izin lokasi Anda. Izin ini hanya digunakan untuk verifikasi ini. Silakan aktifkan izin lokasi di Pengaturan untuk melanjutkan."
                AppAlertCofigManager.showAuthAlert(title: title, message: message)
                return false
            }
        }
        
        return true
    }
}

