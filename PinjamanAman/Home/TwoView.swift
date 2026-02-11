//
//  TwoView.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/11.
//

import UIKit
import SnapKit
import Kingfisher

class TwoView: BaseView {
    
    var modelArray: [seeModel]? {
        didSet {
            guard let modelArray = modelArray else { return }
            if let _ = modelArray.first(where: { $0.acceptance == "appreciate4" }) {
                footView.snp.makeConstraints { make in
                    make.top.equalTo(bgImageView.snp.bottom).offset(80.pix())
                    make.left.right.equalToSuperview()
                    make.bottom.equalToSuperview()
                }
            }else {
                footView.snp.makeConstraints { make in
                    make.top.equalTo(bgImageView.snp.bottom).offset(-25.pix())
                    make.left.right.equalToSuperview()
                    make.bottom.equalToSuperview()
                }
            }
            
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "center_bg_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "logo_ho_image")
        return logoImageView
    }()
    
    lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.text = UserSessionManager.shared.phone ?? ""
        phoneLabel.textAlignment = .left
        phoneLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        phoneLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(500))
        return phoneLabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        return bgView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 86.pix()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(OneViewCell.self, forCellReuseIdentifier: "OneViewCell")
        tableView.register(TwoViewCell.self, forCellReuseIdentifier: "TwoViewCell")
        tableView.register(ThreeViewCell.self, forCellReuseIdentifier: "ThreeViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .init(hexString: "#33954F")
        addSubview(bgImageView)
        addSubview(bgView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(phoneLabel)
        addSubview(footView)
        addSubview(tableView)
        
        bgImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(450.pix())
        }
        bgView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(38)
            make.left.equalToSuperview().offset(20)
        }
        phoneLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(logoImageView.snp.right).offset(15)
            make.height.equalTo(30)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(bgView.snp.bottom).offset(-15)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TwoView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let model = modelArray?[section]
        let type = model?.acceptance ?? ""
        switch type {
        case "appreciate1", "appreciate3", "appreciate4":
            return 0
            
        case "appreciate5":
            return 40.pix()
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let model = modelArray?[section]
        let type = model?.acceptance ?? ""
        switch type {
        case "appreciate1", "appreciate3", "appreciate4":
            return nil
            
        case "appreciate5":
            let headView = UIView()
            let nameLabel = UILabel()
            nameLabel.textAlignment = .left
            nameLabel.text = "Featured products"
            nameLabel.textColor = UIColor.init(hexString: "#22372E")
            nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            headView.addSubview(nameLabel)
            nameLabel.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(20)
                make.top.left.bottom.equalToSuperview()
            }
            return headView
            
        default:
            return nil
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return modelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = modelArray?[section]
        let type = model?.acceptance ?? ""
        switch type {
        case "appreciate1":
            return 0
            
        case "appreciate3":
            return 1
            
        case "appreciate4":
            return 1
            
        case "appreciate5":
            return model?.forgiveness?.count ?? 0
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = modelArray?[indexPath.section]
        let type = model?.acceptance ?? ""
        switch type {
        case "appreciate1":
            return UITableViewCell()
        case "appreciate3":
            let cell = tableView.dequeueReusableCell(withIdentifier: "OneViewCell", for: indexPath) as! OneViewCell
            cell.model = model?.forgiveness?[indexPath.row]
            return cell
            
        case "appreciate4":
            let cell = tableView.dequeueReusableCell(withIdentifier: "TwoViewCell", for: indexPath) as! TwoViewCell
            return cell
            
        case "appreciate5":
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThreeViewCell", for: indexPath) as! ThreeViewCell
            cell.model = model?.forgiveness?[indexPath.row]
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    
}
