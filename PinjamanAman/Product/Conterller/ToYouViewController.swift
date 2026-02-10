//
//  ToYouViewController 2.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/10.
//

import UIKit
import SnapKit
import TYAlertController

class ToYouViewController: BaseViewController {
    
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
        descImageView.image = languageCode == "1100" ? UIImage(named: "lisst_rzx_0image") : UIImage(named: "ad_rzx_13d_y")
        return descImageView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TapCell.self, forCellReuseIdentifier: "TapCell")
        tableView.register(EnterTextCell.self, forCellReuseIdentifier: "EnterTextCell")
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

extension ToYouViewController {
    
    @objc func nextBtnClick() {
        var params = ["transform": self.cardModel?.opening ?? ""]
        for model in modelArray {
            let key = model.partner ?? ""
            let value = model.acceptance ?? ""
            params[key] = value
        }
        LoadingView.shared.show()
        NetworkManager.post(url: "/patkan/whispering/stories/swimming", params: params, responseType: BaseModel.self) { result in
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
        NetworkManager.post(url: "/patkan/silience/furthermore", params: params, responseType: BaseModel.self) { result in
            switch result {
            case .success(let success):
                LoadingView.shared.hide()
                let partner = success.partner ?? ""
                if ["0", "00"].contains(partner) {
                    self.modelArray = success.logic?.evolve ?? []
                    self.tableView.reloadData()
                }
                
            case .failure(_):
                LoadingView.shared.hide()
            }
        }
    }
}

extension ToYouViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.modelArray[indexPath.row]
        let type = model.social ?? ""
        if type == "ability2" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EnterTextCell", for: indexPath) as! EnterTextCell
            cell.model = model
            cell.enterFiledBlock = { text in
                model.worlds = text
                model.acceptance = text
            }
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TapCell", for: indexPath) as! TapCell
            cell.model = model
            cell.tapBlock = { [weak self] in
                guard let self = self else { return }
                self.view.endEditing(true)
                self.tapCell(cell: cell, listModel: model)
            }
            return cell
        }
    }
}

extension ToYouViewController {
    
    private func tapCell(cell: TapCell, listModel: evolveModel) {
        let popView = PopEnmuView(frame: self.view.bounds)
        popView.nameLabel.text = listModel.strain ?? ""
        
        let modelArray = listModel.lay ?? []
        
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
            listModel.worlds = text
            listModel.acceptance = value
        }
    }
    
}

extension ToYouViewController {
    
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
