//
//  HomeViewController.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/9.
//

import UIKit
import SnapKit
import MJRefresh
import FBSDKCoreKit
import CoreLocation

class HomeViewController: BaseViewController {
    
    private let singleLocationManager = SingleLocationService()
    
    lazy var oneView: OneView = {
        let oneView = OneView(frame: .zero)
        oneView.isHidden = true
        return oneView
    }()
    
    lazy var twoView: TwoView = {
        let twoView = TwoView(frame: .zero)
        twoView.isHidden = true
        return twoView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(oneView)
        oneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(twoView)
        twoView.snp.makeConstraints { make in
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
        
        self.oneView.tapABlock = { [weak self] in
            guard let self = self else { return }
            let pageUrl = h5_url + "/breezeHolds"
            self.goH5WebVc(pageUrl: pageUrl)
        }
        
        self.twoView.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            self.homeDataInfo()
        })
        
        self.twoView.tapCellBlock = { [weak self] model in
            guard let self = self else { return }
            let productID = String(model.opening ?? 0)
            self.clickProductInfo(productID: productID)
        }
        
        self.twoView.tapBlock = { [weak self] model in
            guard let self = self else { return }
            let pageUrl = model.vigor ?? ""
            if pageUrl.contains(scheme_url) {
                DeepLinkNavigator.navigate(to: pageUrl, from: self)
            }else if pageUrl.contains("http") {
                self.goH5WebVc(pageUrl: pageUrl)
            }
        }
        
        
        Task {
            let up_type = UserDefaults.standard.object(forKey: "idfa_app") as? String ?? ""
            if up_type == "1" {
                await getAdcInfo()
            }else {
                await uploadIDFAInfo()
                await getAdcInfo()
            }
        }
        
        singleLocationManager.requestCurrentLocation { params in
            //            if let params = params {
            //                NetworkManager.post(url: "/patkan/survival/relationships/companionship",
            //                                    params: params,
            //                                    responseType: BaseModel.self) { result in
            //                    switch result {
            //                    case .success(_):
            //                        break
            //                    case .failure(_):
            //                        break
            //                    }
            //                }
            //            }
        }
        
        //        DeviceInfoBuilder.shared.build { result in
        //            guard let jsonData = try? JSONSerialization.data(withJSONObject: result, options: []) else {
        //                return
        //            }
        //            let base64String = jsonData.base64EncodedString()
        //            print("Base64：")
        //            print(base64String)
        //        }
        
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
                    UserDefaults.standard.set("1", forKey: "idfa_app")
                    UserDefaults.standard.synchronize()
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
                self.twoView.tableView.mj_header?.endRefreshing()
                let partner = success.partner ?? ""
                if ["0", "00"].contains(partner) {
                    let modelArray = success.logic?.see ?? []
                    if let _ = modelArray.first(where: { $0.acceptance == "appreciate3" }) {
                        self.oneView.isHidden = true
                        self.twoView.isHidden = false
                        self.twoView.modelArray = modelArray
                        self.twoView.tableView.reloadData()
                        return
                    }
                    
                    if let cardModel = modelArray.first(where: { $0.acceptance == "appreciate2" }), let listModel = cardModel.forgiveness?.first  {
                        self.oneView.isHidden = false
                        self.twoView.isHidden = true
                        self.oneView.model = listModel
                        return
                    }
                    
                }
            case .failure(_):
                LoadingView.shared.hide()
                self.oneView.scrollView.mj_header?.endRefreshing()
                self.twoView.tableView.mj_header?.endRefreshing()
            }
        }
    }
    
    private func clickProductInfo(productID: String) {
        
        let status = CLLocationManager().authorizationStatus
        
        if languageCode == "1100" {
            if status == .denied || status == .restricted {
                let title = languageCode == "1105" ? "Location Permission" : "Izin Lokasi"
                let message = languageCode == "1105" ? "To complete identity verification, we need your location permission. It will only be used for this verification to keep your application secure. Please enable location permission in Settings to continue." : "Untuk menyelesaikan verifikasi identitas, kami memerlukan izin lokasi Anda. Izin ini hanya digunakan untuk verifikasi ini. Silakan aktifkan izin lokasi di Pengaturan untuk melanjutkan."
                AppAlertCofigManager.showAuthAlert(title: title, message: message)
                return
            }
        }
        
        if languageCode == "1100" {
            singleLocationManager.requestCurrentLocation { params in
                if let params = params {
                    NetworkManager.post(url: "/patkan/survival/relationships/companionship",
                                        params: params,
                                        responseType: BaseModel.self) { result in
                        switch result {
                        case .success(_):
                            break
                        case .failure(_):
                            break
                        }
                    }
                }
            }
            
            DeviceInfoBuilder.shared.build { result in
                guard let jsonData = try? JSONSerialization.data(withJSONObject: result, options: []) else {
                    return
                }
                let base64String = jsonData.base64EncodedString()
                NetworkManager.post(url: "/patkan/journey/granite/conclusion",
                                    params: ["logic": base64String],
                                    responseType: BaseModel.self) { result in
                    switch result {
                    case .success(_):
                        break
                    case .failure(_):
                        break
                    }
                }
            }
            
            let onetime = UserDefaults.standard.object(forKey: "start_time") as? String ?? ""
            let twotime = UserDefaults.standard.object(forKey: "end_time") as? String ?? ""
            
            if !onetime.isEmpty && !twotime.isEmpty {
                Task {
                    try? await Task.sleep(nanoseconds: 3_000_000_000)
                    self.lycCocelleInfo(type: "1",
                                        orderID: "",
                                        productID: "",
                                        onetime: onetime,
                                        twotime: twotime)
                }
            }
        }
        
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
                }else if partner == "-2" {
                    ToastManager.showMessage(success.reason ?? "")
                    UserSessionManager.shared.clearLoginInfo()
                    Task {
                        try? await Task.sleep(nanoseconds: 500_000_000)
                        NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil)
                    }
                }
            case .failure(_):
                LoadingView.shared.hide()
            }
        }
    }
}

extension HomeViewController {
    
    private func getAdcInfo() async {
        NetworkManager.get(url: "/patkan/meaningful/unadulterated/relax", responseType: BaseModel.self) { result in
            switch result {
            case .success(let success):
                let partner = success.partner ?? ""
                if ["0", "00"].contains(partner) {
                    AdcManager.shared.modelArray = success.logic?.see ?? []
                }
            case .failure(_):
                break
            }
        }
    }
    
    private func lycCocelleInfo(type: String,
                                orderID: String,
                                productID: String,
                                onetime: String,
                                twotime: String) {
        let reminder = LocationInfoStorage.storedLongitude
        let order = LocationInfoStorage.storedLatitude
        let params = ["food": type,
                      "good": orderID,
                      "possessions": productID,
                      "entire": AppIdentifierManager.getIDFV(),
                      "foundation": AppIdentifierManager.getIDFA() ?? "",
                      "plant": onetime,
                      "sustains": twotime,
                      "reminder": reminder,
                      "order": order]
        NetworkManager.post(url: "/patkan/overwhelming/nostalgia/signs",
                            params: params,
                            responseType: BaseModel.self) { result in
            switch result {
            case .success(let success):
                let partner = success.partner ?? ""
                if ["0","00"].contains(partner) {
                    UserDefaults.standard.removeObject(forKey: "start_time")
                    UserDefaults.standard.removeObject(forKey: "end_time")
                }
                
            case .failure(_):
                break
            }
        }
    }
    
}

class AppAlertCofigManager {
    
    static func showAuthAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: AppLanguageCodeManager.getLanguageCode() == "1100" ? "Batalkan" : "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: AppLanguageCodeManager.getLanguageCode() == "1100" ? "Masuk ke Pengaturan" : "Go to Settings", style: .default) { _ in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            })
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let keyWindow = windowScene.windows.first(where: \.isKeyWindow) else {
                return
            }
            keyWindow.rootViewController?.present(alert, animated: true)
            
        }
    }
    
}
