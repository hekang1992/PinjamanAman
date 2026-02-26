//
//  CenterViewController.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/9.
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
        
        centerView.settingBtn.addTarget(self, action: #selector(settingClick), for: .touchUpInside)
        
        centerView.cellBlock = { [weak self] model in
            guard let self = self else { return }
            let pageUrl = model.eyes ?? ""
            if pageUrl.contains(scheme_url) {
                DeepLinkNavigator.navigate(to: pageUrl, from: self)
            }else if pageUrl.contains("http") {
                self.goH5WebVc(pageUrl: pageUrl)
            }
        }
        
        centerView.tapBlock = { [weak self] type in
            guard let self = self else { return }
            let listVc = OrderListViewController()
            listVc.type = type
            self.navigationController?.pushViewController(listVc, animated: true)
        }
        
        centerView.tapPrivacyBlock = { [weak self] pageUrl in
            self?.goH5WebVc(pageUrl: pageUrl)
        }
        
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

extension CenterViewController {
    
    @objc func settingClick() {
        let settingVc = SettingViewController()
        self.navigationController?.pushViewController(settingVc, animated: true)
    }
}
