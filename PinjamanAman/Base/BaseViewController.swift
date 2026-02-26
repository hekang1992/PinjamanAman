//
//  BaseViewController.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/9.
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
        footView.backgroundColor = UIColor.white
        return footView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(hexString: "#F6F6F4")
    }
    
}

extension BaseViewController {
    
    func goH5WebVc(pageUrl: String) {
        let h5WebVc = H5WebViewController()
        h5WebVc.pageUrl = pageUrl
        self.navigationController?.pushViewController(h5WebVc, animated: true)
    }
    
    func toTargetVc() {
        guard let nav = navigationController else { return }
        
        if let vc = nav.viewControllers.compactMap({ $0 as? ProductStepListViewController }).first {
            nav.popToViewController(vc, animated: true)
        } else {
            nav.popToRootViewController(animated: true)
        }
    }
    
    func toOrderLisrTargetVc() {
        guard let nav = navigationController else { return }
        
        if let vc = nav.viewControllers.compactMap({ $0 as? OrderListViewController }).first {
            nav.popToViewController(vc, animated: true)
        } else {
            nav.popToRootViewController(animated: true)
        }
    }
    
}

extension BaseViewController {
    
    func judgeKeysToPageVc(cardModel: smallerModel, stepModel: strikeModel) {
        let type = stepModel.word ?? ""
        switch type {
        case "contentment1":
            let basicVc = BasicViewController()
            basicVc.cardModel = cardModel
            basicVc.stepModel = stepModel
            self.navigationController?.pushViewController(basicVc, animated: true)
            
        case "contentment3":
            let basicVc = PersonalViewController()
            basicVc.cardModel = cardModel
            basicVc.stepModel = stepModel
            self.navigationController?.pushViewController(basicVc, animated: true)
            
        case "contentment4":
            let basicVc = ConnectViewController()
            basicVc.cardModel = cardModel
            basicVc.stepModel = stepModel
            self.navigationController?.pushViewController(basicVc, animated: true)
            
        case "contentment5":
            let basicVc = ToYouViewController()
            basicVc.cardModel = cardModel
            basicVc.stepModel = stepModel
            self.navigationController?.pushViewController(basicVc, animated: true)
            
        case "":
            self.applyOrderInfo(cardModel: cardModel, stepModel: stepModel)
            
        default:
            break
        }
    }
    
}

extension BaseViewController {
    
    private func applyOrderInfo(cardModel: smallerModel, stepModel: strikeModel) {
        LoadingView.shared.show()
        let reevaluate = cardModel.good ?? ""
        let positivity = cardModel.positivity ?? ""
        let midst = cardModel.midst ?? ""
        let practice = cardModel.practice ?? ""
        
        let params = ["reevaluate": reevaluate,
                      "positivity": positivity,
                      "midst": midst,
                      "practice": practice]
        NetworkManager.post(url: "/patkan/gentle/unwind/depth",
                            params: params,
                            responseType: BaseModel.self) { [weak self] result in
            switch result {
            case .success(let success):
                guard let self = self else { return }
                LoadingView.shared.hide()
                let partner = success.partner ?? ""
                if ["0", "00"].contains(partner) {
                    let pageUrl = success.logic?.vigor ?? ""
                    if pageUrl.contains(scheme_url) {
                        DeepLinkNavigator.navigate(to: pageUrl, from: self)
                    }else if pageUrl.contains("http") {
                        self.goH5WebVc(pageUrl: pageUrl)
                    }
                    
                    Task {
                        try? await Task.sleep(nanoseconds: 3_000_000_000)
                        await self.lycOtherCocelleInfo(type: "8",
                                                       orderID: cardModel.good ?? "",
                                                       productID: cardModel.opening ?? "",
                                                       onetime: String(Int(Date().timeIntervalSince1970)),
                                                       twotime: String(Int(Date().timeIntervalSince1970)))
                    }
                    
                    
                }
            case .failure(_):
                LoadingView.shared.hide()
            }
        }
        
    }
}

extension BaseViewController {
    
    func lycOtherCocelleInfo(type: String,
                             orderID: String,
                             productID: String,
                             onetime: String,
                             twotime: String) async {
        let params = ["food": type,
                      "good": orderID,
                      "possessions": productID,
                      "entire": AppIdentifierManager.getIDFV(),
                      "foundation": AppIdentifierManager.getIDFA() ?? "",
                      "plant": onetime,
                      "sustains": twotime,
                      "reminder": LocationInfoStorage.storedLongitude,
                      "order": LocationInfoStorage.storedLatitude]
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
