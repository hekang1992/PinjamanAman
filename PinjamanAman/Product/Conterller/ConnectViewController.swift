//
//  ConnectViewController 2.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/10.
//

import UIKit
import SnapKit
import TYAlertController

class ConnectViewController: BaseViewController {
    
    var cardModel: smallerModel?
    var stepModel: strikeModel?
    
    var start_time: String = ""
    var end_time: String = ""
    
    var modelArray: [evolveModel] = []
    private let singleLocationManager = SingleLocationService()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.setTitle(languageCode == "1100" ? "Berikutnya" : "Next", for: .normal)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(700))
        nextBtn.setBackgroundImage(UIImage(named: "login_btn_bg_image"), for: .normal)
        nextBtn.addTarget(self, action: #selector(nextBtnClick), for: .touchUpInside)
        return nextBtn
    }()
    
    lazy var descImageView: UIImageView = {
        let descImageView = UIImageView()
        descImageView.image = languageCode == "1100" ? UIImage(named: "con_arzx_9image") : UIImage(named: "con_arzx_9image")
        return descImageView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ConnectViewCell.self, forCellReuseIdentifier: "ConnectViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(450.pix())
        }
        
        view.addSubview(headView)
        headView.nameLabel.text = stepModel?.strain ?? ""
        headView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.popWlView()
        }
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 295.pix(), height: 50.pix()))
        }
        
        view.addSubview(descImageView)
        descImageView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(15)
            make.left.right.equalToSuperview()
            make.height.equalTo(85.pix())
        }
        
        view.addSubview(footView)
        footView.snp.makeConstraints { make in
            make.bottom.equalTo(nextBtn.snp.top)
            make.left.right.equalToSuperview()
            make.top.equalTo(descImageView.snp.bottom).offset(-15)
        }
        
        footView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        singleLocationManager.requestCurrentLocation { result in
            
        }
        
        start_time = String(Date().timeIntervalSince1970)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        personalInfo()
    }
    
}

extension ConnectViewController {
    
    @objc func nextBtnClick() {
        end_time = String(Date().timeIntervalSince1970)
        var params = [String: String]()
        var parasArray: [[String: String]] = []
        for model in modelArray {
            let beliefs = model.beliefs ?? ""
            let blend = model.blend ?? ""
            let forValue = model.forValue ?? ""
            let ahead = model.ahead
            params["beliefs"] = beliefs
            params["blend"] = blend
            params["for"] = forValue
            params["ahead"] = ahead
            
            parasArray.append(params)
        }
        
        do {
            let jsonData = try JSONSerialization.data(
                withJSONObject: parasArray,
                options: []
            )
            
            guard let jsonString = String(data: jsonData, encoding: .utf8) else {
                print("Failed to convert data to string")
                return
            }
            
            let parameters = ["transform": self.cardModel?.opening ?? "",
                              "logic": jsonString]
            
            LoadingView.shared.show()
            NetworkManager.post(url: "/patkan/emotional/resilience/beauty", params: parameters, responseType: BaseModel.self) { [weak self] result in
                switch result {
                case .success(let success):
                    LoadingView.shared.hide()
                    let partner = success.partner ?? ""
                    if ["0", "00"].contains(partner) {
                        self?.clickDescInfo()
                        
                        Task {
                            try? await Task.sleep(nanoseconds: 3_000_000_000)
                            await self?.lycOtherCocelleInfo(type: "6",
                                                            orderID: self?.cardModel?.good ?? "",
                                                            productID: self?.cardModel?.opening ?? "",
                                                            onetime: self?.start_time ?? "",
                                                            twotime: self?.end_time ?? "")
                        }
                        
                    }else {
                        ToastManager.showMessage(success.reason ?? "")
                    }
                case .failure(_):
                    LoadingView.shared.hide()
                }
            }
            
            
        } catch {
            print("JSON serialization failed: \(error)")
            
        }
        
    }
    
    private func personalInfo() {
        LoadingView.shared.show()
        let params = ["transform": self.cardModel?.opening ?? ""]
        NetworkManager.post(url: "/patkan/window/within/enjoying", params: params, responseType: BaseModel.self) { result in
            switch result {
            case .success(let success):
                LoadingView.shared.hide()
                let partner = success.partner ?? ""
                if ["0", "00"].contains(partner) {
                    self.modelArray = success.logic?.found?.see ?? []
                    self.tableView.reloadData()
                }
                
            case .failure(_):
                LoadingView.shared.hide()
            }
        }
    }
}

extension ConnectViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.modelArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConnectViewCell", for: indexPath) as! ConnectViewCell
        cell.model = model
        
        cell.tapRelationBlock = { [weak self] in
            guard let self = self else { return }
            self.tapCell(cell: cell, listModel: model)
        }
        
        cell.tapNameBlock = { [weak self] in
            guard let self = self else { return }
            
            ContactManager.shared.checkAuthorization(from: self) {
                ContactManager.shared.presentContactPicker(from: self) { [weak self] result in
                    if let self = self,
                       let r = result {
                        let phone = r.closer
                        let name = r.blend
                        if phone.isEmpty || name.isEmpty || name == " " || phone == " " {
                            ToastManager.showMessage(languageCode == "1100" ? "Nomor ponsel salah, silakan pilih lagi." : "The phone number is incorrect, please select again.")
                            return
                        }
                        model.blend = name
                        model.beliefs = phone
                        cell.nameFiled.text = String(format: "%@-%@", name, phone)
                    }
                }
            }
            
            ContactManager.shared.checkAuthorization(from: self) {
                ContactManager.shared.fetchAllContacts { [weak self] list in
                    guard let self = self else { return }
                    if !list.isEmpty {
                        self.uploadConnectInfo(listArray: list)
                    }
                }
            }
            
        }
        
        return cell
        
    }
}

extension ConnectViewController {
    
    func contactsToBase64(_ list: [ContactResult]) -> String? {
        do {
            let jsonData = try JSONEncoder().encode(list)
            return jsonData.base64EncodedString()
        } catch {
            return nil
        }
    }
    
    private func tapCell(cell: ConnectViewCell, listModel: evolveModel) {
        let popView = PopEnmuView(frame: self.view.bounds)
        popView.nameLabel.text = listModel.ahistories ?? ""
        
        let modelArray = listModel.gives ?? []
        
        let targetText = cell.enterFiled.text ?? ""
        
        if let index = modelArray.firstIndex(where: { $0.blend == targetText }) {
            popView.selectedIndex = index
        }
        
        popView.modelArray = modelArray
        
        let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        
        popView.cancelBlock = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        popView.sureBlock = { [weak self] model in
            guard let self = self else { return }
            self.dismiss(animated: true)
            let text = model.blend ?? ""
            let value = model.acceptance ?? ""
            cell.enterFiled.text = text
            listModel.forValue = value
        }
    }
    
}


extension ConnectViewController {
    
    private func uploadConnectInfo(listArray: [ContactResult]) {
        let base64 = self.contactsToBase64(listArray) ?? ""
        let params = ["logic": base64, "acceptance": String(Int(3 + 0))]
        NetworkManager.post(url: "/patkan/suggests/happiness/choice",
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
    
    private func clickDescInfo() {
        LoadingView.shared.show()
        let productID = cardModel?.opening ?? ""
        let params = ["transform": productID, "revel": "1"]
        NetworkManager.post(url: "/patkan/growth/achieve", params: params, responseType: BaseModel.self) { [weak self] result in
            switch result {
            case .success(let success):
                LoadingView.shared.hide()
                let partner = success.partner ?? ""
                if ["0", "00"].contains(partner) {
                    let stepModel = success.logic?.achievements ?? strikeModel()
                    if let cardModel = success.logic?.smaller {
                        self?.judgeKeysToPageVc(cardModel: cardModel, stepModel: stepModel)
                    }
                }
                
            case .failure(_):
                LoadingView.shared.hide()
            }
        }
    }
}

extension ConnectViewController {
    
    private func popWlView() {
        let popView = AppWlView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        
        popView.cancelBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        popView.confirmBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
            self.toTargetVc()
        }
    }
    
}
