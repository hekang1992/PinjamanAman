//
//  BaseViewController.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/9.
//

import UIKit

class BaseViewController: UIViewController {
    
    let languageCode = AppLanguageCodeManager.getLanguageCode()
    
    lazy var headView: AppHeadView = {
        let headView = AppHeadView()
        return headView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hexString: "#33954F")
        return bgView
    }()
    
    lazy var footView: UIView = {
        let footView = UIView()
        footView.layer.cornerRadius = 20
        footView.layer.masksToBounds = true
        footView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        footView.backgroundColor = UIColor.init(hexString: "#F6F6F4")
        return footView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }

}

extension BaseViewController {
    
    func goH5WebVc(pageUrl: String) {
        let h5WebVc = H5WebViewController()
        h5WebVc.pageUrl = pageUrl
        self.navigationController?.pushViewController(h5WebVc, animated: true)
    }
    
}
