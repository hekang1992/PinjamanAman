//
//  HomeViewController.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/9.
//

import UIKit
import SnapKit

class HomeViewController: BaseViewController {
    
    lazy var oneView: OneView = {
        let oneView = OneView(frame: .zero)
        return oneView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(oneView)
        oneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
