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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }

}
