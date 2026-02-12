//
//  OrderListViewController.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/11.
//

import UIKit
import SnapKit
import TYAlertController
import MJRefresh

class OrderListViewController: BaseViewController {
    
    var type: String = ""
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "center_bg_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    private var modelArray: [seeModel] = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(OrderViewCell.self, forCellReuseIdentifier: "OrderViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    lazy var emptyView: OrderEmptyView = {
        let emptyView = OrderEmptyView()
        emptyView.isHidden = true
        return emptyView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.leading.right.equalToSuperview()
            make.height.equalTo(450.pix())
        }
        
        view.addSubview(headView)
        switch type {
        case "4":
            headView.nameLabel.text = languageCode == "1100" ? "Semua" : "All"
            
        case "7":
            headView.nameLabel.text = languageCode == "1100" ? "Dalam proses" : "In progress"
            
        case "6":
            headView.nameLabel.text = languageCode == "1100" ? "Belum lunas" : "Repayment"
            
        case "5":
            headView.nameLabel.text = languageCode == "1100" ? "Lunas" : "Finished"
            
        default:
            break
        }
        
        headView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
        
        view.addSubview(footView)
        footView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(15)
        }
        
        footView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        footView.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        emptyView.applyBtnBlock = {
            NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil)
        }
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            self.orderListInfo()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.orderListInfo()
    }
}

extension OrderListViewController {
    
    private func orderListInfo() {
        LoadingView.shared.show()
        let params = ["overshadowed": type,
                      "around": "1",
                      "millions": "55"]
        NetworkManager.post(url: "/patkan/greenery/while/lives",
                            params: params,
                            responseType: BaseModel.self) { [weak self] result in
            switch result {
            case .success(let success):
                LoadingView.shared.hide()
                let partner = success.partner ?? ""
                if ["0", "00"].contains(partner) {
                    let modelArray = success.logic?.see ?? []
                    self?.modelArray = modelArray
                    self?.tableView.reloadData()
                    if modelArray.isEmpty {
                        self?.tableView.isHidden = true
                        self?.emptyView.isHidden = false
                    }else {
                        self?.tableView.isHidden = false
                        self?.emptyView.isHidden = true
                    }
                }else {
                    self?.tableView.isHidden = true
                    self?.emptyView.isHidden = false
                }
                self?.tableView.mj_header?.endRefreshing()
            case .failure(_):
                LoadingView.shared.hide()
                self?.tableView.mj_header?.endRefreshing()
                self?.tableView.isHidden = true
                self?.emptyView.isHidden = false
            }
        }
    }
    
}

extension OrderListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderViewCell", for: indexPath) as! OrderViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        let model = self.modelArray[indexPath.row]
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.modelArray[indexPath.row]
        let pageUrl = model.chaos ?? ""
        if pageUrl.contains(scheme_url) {
            DeepLinkNavigator.navigate(to: pageUrl, from: self)
        }else if pageUrl.contains("http") {
            self.goH5WebVc(pageUrl: pageUrl)
        }
    }
}
