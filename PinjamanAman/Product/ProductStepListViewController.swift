//
//  ProductStepListViewController.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/9.
//

import UIKit
import SnapKit
import TYAlertController
import MJRefresh

class ProductStepListViewController: BaseViewController {
    
    var productID: String = ""
    
    var model: BaseModel?
    
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
