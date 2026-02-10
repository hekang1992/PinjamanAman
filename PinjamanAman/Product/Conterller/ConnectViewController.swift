//
//  ConnectViewController 2.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/10.
//

import UIKit
import SnapKit
import TYAlertController

class ConnectViewController: BaseViewController {
    
    var cardModel: smallerModel?
    var stepModel: strikeModel?
    
    var modelArray: [evolveModel] = []
    
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
            self.toTargetVc()
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        personalInfo()
    }
    
}

extension ConnectViewController {
    
    @objc func nextBtnClick() {
        var params = ["transform": self.cardModel?.opening ?? ""]
        for model in modelArray {
            let key = model.partner ?? ""
            let value = model.acceptance ?? ""
            params[key] = value
        }
        LoadingView.shared.show()
        NetworkManager.post(url: "/patkan/behaviors/during/emotional", params: params, responseType: BaseModel.self) { result in
            switch result {
            case .success(let success):
                LoadingView.shared.hide()
                let partner = success.partner ?? ""
                if ["0", "00"].contains(partner) {
                    self.clickDescInfo()
                }else {
                    ToastManager.showMessage(success.reason ?? "")
                }
            case .failure(_):
                LoadingView.shared.hide()
            }
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
        return cell
        
    }
}



extension ConnectViewController {
    
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
                    let cardModel = success.logic?.smaller ?? smallerModel()
                    self?.judgeKeysToPageVc(cardModel: cardModel, stepModel: stepModel)
                }
                
            case .failure(_):
                LoadingView.shared.hide()
            }
        }
    }
}
