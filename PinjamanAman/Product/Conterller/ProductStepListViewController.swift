//
//  ProductStepListViewController.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/9.
//

import UIKit
import SnapKit
import TYAlertController
import MJRefresh
import Kingfisher

class ProductStepListViewController: BaseViewController {
    
    var productID: String = ""
    
    var model: BaseModel?
    
    private let singleLocationManager = SingleLocationService()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "center_bg_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "pc_d_h_image")
        return headImageView
    }()
    
    lazy var stepImageView: UIImageView = {
        let stepImageView = UIImageView()
        return stepImageView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 88
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ProductStepViewCell.self, forCellReuseIdentifier: "ProductStepViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(700))
        nextBtn.setBackgroundImage(UIImage(named: "login_btn_bg_image"), for: .normal)
        nextBtn.addTarget(self, action: #selector(nextBtnClick), for: .touchUpInside)
        return nextBtn
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.layer.cornerRadius = 20
        whiteView.layer.masksToBounds = true
        whiteView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        whiteView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return whiteView
    }()
    
    lazy var productImageView: UIImageView = {
        let productImageView = UIImageView()
        productImageView.layer.cornerRadius = 8
        productImageView.layer.masksToBounds = true
        productImageView.backgroundColor = .systemGreen
        return productImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#203D31")
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        return nameLabel
    }()
    
    lazy var descImageView: UIImageView = {
        let descImageView = UIImageView()
        descImageView.image = languageCode == "1100" ? UIImage(named: "id_ho_a_yn") : UIImage(named: "home_cdesc_image")
        return descImageView
    }()
    
    lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.textAlignment = .center
        moneyLabel.textColor = UIColor.init(hexString: "#203D31")
        moneyLabel.font = UIFont.systemFont(ofSize: 46, weight: UIFont.Weight(600))
        return moneyLabel
    }()
    
    lazy var uptoLabel: UILabel = {
        let uptoLabel = UILabel()
        uptoLabel.textAlignment = .center
        uptoLabel.textColor = UIColor.init(hexString: "#B0B4B3")
        uptoLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(500))
        return uptoLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.leading.right.equalToSuperview()
            make.height.equalTo(450.pix())
        }
        
        view.addSubview(headView)
        headView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 295.pix(), height: 50.pix()))
        }
        
        view.addSubview(footView)
        footView.snp.makeConstraints { make in
            make.bottom.equalTo(nextBtn.snp.top)
            make.left.right.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(212.pix())
        }
        
        footView.addSubview(whiteView)
        whiteView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(-15)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(nextBtn.snp.top)
        }
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            clickDescInfo()
        })
        
        singleLocationManager.requestCurrentLocation { result in
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clickDescInfo()
    }
    
}

extension ProductStepListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300.pix()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        headView.addSubview(headImageView)
        headImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375.pix(), height: 221.pix()))
        }
        
        headView.addSubview(stepImageView)
        stepImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-13.pix())
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(26)
        }
        
        let modelArray = self.model?.logic?.strike ?? []
        stepImageView.image = modelArray.count == 4 ? UIImage(named: "id_t_for_image") : UIImage(named: "en_t_st_image")
        
        headView.addSubview(productImageView)
        headView.addSubview(nameLabel)
        headView.addSubview(descImageView)
        headView.addSubview(moneyLabel)
        headView.addSubview(uptoLabel)
        
        productImageView.snp.makeConstraints { make in
            make.width.height.equalTo(26)
            make.left.equalToSuperview().offset(40.pix())
            make.top.equalToSuperview().offset(60.pix())
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(productImageView)
            make.left.equalTo(productImageView.snp.right).offset(5)
            make.height.equalTo(30)
        }
        descImageView.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(5)
            make.left.equalTo(productImageView)
            make.size.equalTo(CGSize(width: 220.pix(), height: 20.pix()))
        }
        moneyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descImageView.snp.bottom).offset(15)
            make.height.equalTo(50)
        }
        uptoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(moneyLabel.snp.bottom).offset(2)
            make.height.equalTo(15)
        }
        
        let cardModel = self.model?.logic?.smaller
        productImageView.kf.setImage(with: URL(string: cardModel?.conflicts ?? ""))
        nameLabel.text = cardModel?.soften ?? ""
        moneyLabel.text = cardModel?.positivity ?? ""
        uptoLabel.text = cardModel?.mindset ?? ""
        
        return headView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.logic?.strike?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let modelArray = self.model?.logic?.strike ?? []
        let model = modelArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductStepViewCell", for: indexPath) as! ProductStepViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        let step = languageCode ==  "1100" ? "Langkah" : "Step"
        cell.stepLabel.text = "\(step) \(indexPath.row + 1)"
        let isLastCell = indexPath.row == modelArray.count - 1
        cell.typeImageView.isHidden = isLastCell
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modelArray = self.model?.logic?.strike ?? []
        let model = modelArray[indexPath.row]
        let cardModel = self.model?.logic?.smaller
        let typeIndex = model.laugh ?? 0
        if typeIndex == 1 {
            if let cardModel = cardModel {
                self.judgeKeysToPageVc(cardModel: cardModel, stepModel: model)
            }
        }else {
            self.nextBtnClick()
        }
    }
    
}

extension ProductStepListViewController {
    
    private func clickDescInfo() {
        LoadingView.shared.show()
        let params = ["transform": productID, "revel": "1"]
        NetworkManager.post(url: "/patkan/growth/achieve", params: params, responseType: BaseModel.self) { [weak self] result in
            switch result {
            case .success(let success):
                LoadingView.shared.hide()
                self?.tableView.mj_header?.endRefreshing()
                let partner = success.partner ?? ""
                if ["0", "00"].contains(partner) {
                    self?.model = success
                    self?.tableView.reloadData()
                    self?.headView.nameLabel.text = success.logic?.smaller?.soften ?? ""
                    self?.nextBtn.setTitle(success.logic?.smaller?.resolve ?? "", for: .normal)
                }
                
            case .failure(_):
                LoadingView.shared.hide()
                self?.tableView.mj_header?.endRefreshing()
            }
        }
    }
}

extension ProductStepListViewController {
    
    @objc func nextBtnClick() {
        let stepModel = self.model?.logic?.achievements ?? strikeModel()
        let cardModel = self.model?.logic?.smaller
        if let cardModel = cardModel {
            self.judgeKeysToPageVc(cardModel: cardModel, stepModel: stepModel)
        }
    }
    
}
