//
//  HomeViewController.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/9.
//

import UIKit
import SnapKit
import MJRefresh
import FBSDKCoreKit

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
        
        self.oneView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            self.homeDataInfo()
        })
        
        self.oneView.tapBlock = { [weak self] model in
            guard let self = self else { return }
            let productID = String(model.opening ?? 0)
            self.clickProductInfo(productID: productID)
        }
        
        Task {
            await uploadIDFAInfo()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.homeDataInfo()
    }
}

extension HomeViewController {
    
    private func uploadIDFAInfo() async {
        let params = ["shade": AppIdentifierManager.getIDFV(),
                      "respiration": AppIdentifierManager.getIDFA() ?? ""]
        NetworkManager.post(url: "/patkan/sophistication/especially/dream",
                            params: params,
                            responseType: BaseModel.self) { [weak self] result in
            switch result {
            case .success(let success):
                let partner = success.partner ?? ""
                if ["0", "00"].contains(partner) {
                    self?.configureFacebookSDK(with: success.logic?.analysisability ?? analysisabilityModel())
                }
            case .failure(_):
                break
            }
        }
    }
    
    func configureFacebookSDK(with model: analysisabilityModel) {
        Settings.shared.displayName = model.cur ?? ""
        Settings.shared.appURLSchemeSuffix = model.walkety ?? ""
        Settings.shared.appID = model.shortster ?? ""
        Settings.shared.clientToken = model.middleee ?? ""
        
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            didFinishLaunchingWithOptions: nil
        )
    }
    
    private func homeDataInfo() {
        
        LoadingView.shared.show()
        NetworkManager.get(url: "/patkan/fathers/season/natural", responseType: BaseModel.self) { result in
            switch result {
            case .success(let success):
                LoadingView.shared.hide()
                self.oneView.scrollView.mj_header?.endRefreshing()
                let partner = success.partner ?? ""
                if ["0", "00"].contains(partner) {
                    let modelArray = success.logic?.see ?? []
                    if let cardModel = modelArray.first(where: { $0.acceptance == "appreciate3" }) {
                        self.oneView.isHidden = true
                        return
                    }
                    
                    if let cardModel = modelArray.first(where: { $0.acceptance == "appreciate2" }), let listModel = cardModel.forgiveness?.first  {
                        self.oneView.isHidden = false
                        self.oneView.model = listModel
                        return
                    }
                    
                }
            case .failure(_):
                LoadingView.shared.hide()
                self.oneView.scrollView.mj_header?.endRefreshing()
            }
        }
    }
    
    private func clickProductInfo(productID: String) {
        LoadingView.shared.show()
        let params = ["transform": productID,
                      "imagined": "1000",
                      "enters": "1001",
                      "breath": "1000"]
        NetworkManager.post(url: "/patkan/static/mother/still", params: params, responseType: BaseModel.self) { result in
            switch result {
            case .success(let success):
                LoadingView.shared.hide()
                let partner = success.partner ?? ""
                if ["0", "00"].contains(partner) {
                    let pageUrl = success.logic?.vigor ?? ""
                    if pageUrl.contains(scheme_url) {
                        DeepLinkNavigator.navigate(to: pageUrl, from: self)
                    }else if pageUrl.contains("http") {
                        self.goH5WebVc(pageUrl: pageUrl)
                    }
                }
            case .failure(_):
                LoadingView.shared.hide()
            }
        }
    }
}
