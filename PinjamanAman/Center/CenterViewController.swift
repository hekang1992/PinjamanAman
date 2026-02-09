//
//  CenterViewController.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/9.
//

import UIKit
import SnapKit
import MJRefresh

class CenterViewController: BaseViewController {
    
    lazy var centerView: CenterView = {
        let centerView = CenterView(frame: .zero)
        return centerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(centerView)
        centerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.centerView.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            self.centerInfo()
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.centerInfo()
    }
}

extension CenterViewController {
    
    private func centerInfo() {
        LoadingView.shared.show()
        NetworkManager.get(url: "/patkan/proud/fatherly/quiet", responseType: BaseModel.self) { result in
            switch result {
            case .success(let success):
                LoadingView.shared.hide()
                self.centerView.tableView.mj_header?.endRefreshing()
                let partner = success.partner ?? ""
                if ["0", "00"].contains(partner) {
                    self.centerView.modelArray = success.logic?.confide ?? []
                    self.centerView.tableView.reloadData()
                }
            case .failure(_):
                LoadingView.shared.hide()
                self.centerView.tableView.mj_header?.endRefreshing()
            }
        }
    }
    
}
