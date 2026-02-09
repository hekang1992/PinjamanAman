//
//  BaseViewController.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/9.
//

import UIKit

class BaseViewController: UIViewController {
    
    let languageCode = AppLanguageCodeManager.getLanguageCode()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }

}
