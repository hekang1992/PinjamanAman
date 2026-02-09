//
//  BaseView.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/9.
//

import UIKit

class BaseView: UIView {

    let languageCode = AppLanguageCodeManager.getLanguageCode()

    lazy var footView: UIView = {
        let footView = UIView()
        footView.layer.cornerRadius = 20
        footView.layer.masksToBounds = true
        footView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        footView.backgroundColor = UIColor.init(hexString: "#F6F6F4")
        return footView
    }()
    
}


