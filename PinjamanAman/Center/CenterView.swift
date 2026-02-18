//
//  CenterView.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/9.
//

import UIKit
import SnapKit

class CenterView: BaseView {
    
    var modelArray: [confideModel] = []
    
    var cellBlock: ((confideModel) -> Void)?
    
    var tapBlock: ((String) -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "center_bg_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 20
        bgView.layer.masksToBounds = true
        bgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bgView.backgroundColor = UIColor.init(hexString: "#F6F6F4")
        return bgView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = languageCode == "1100" ? "Akun" : "Account"
        nameLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(600))
        return nameLabel
    }()
    
    lazy var settingBtn: UIButton = {
        let settingBtn = UIButton(type: .custom)
        settingBtn.setBackgroundImage(UIImage(named: "cn_set_image"), for: .normal)
        return settingBtn
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "cnlogo_bg_image")
        return logoImageView
    }()
    
    lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.textAlignment = .left
        let phone = UserSessionManager.shared.phone ?? ""
        phoneLabel.text = PhoneNumberManager.formatPhoneNumber(phone)
        phoneLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        phoneLabel.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight(500))
        return phoneLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textAlignment = .left
        descLabel.numberOfLines = 0
        descLabel.text = languageCode == "1100" ? "Selamat bergabung di Pinjaman Aman" : "Welcome to join Pinjaman Aman"
        descLabel.textColor = UIColor.init(hexString: "#B2EAC5")
        descLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(500))
        return descLabel
    }()
    
    lazy var odcImageView: UIImageView = {
        let odcImageView = UIImageView()
        odcImageView.image = languageCode == "1100" ? UIImage(named: "id_oc_l_image") : UIImage(named: "en_oc_l_image")
        odcImageView.isUserInteractionEnabled = true
        return odcImageView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CenterViewCell.self, forCellReuseIdentifier: "CenterViewCell")
        tableView.layer.cornerRadius = 18
        tableView.layer.masksToBounds = true
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        oneBtn.addTarget(self, action: #selector(oneBtnClick), for: .touchUpInside)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.addTarget(self, action: #selector(twoBtnClick), for: .touchUpInside)
        return twoBtn
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton(type: .custom)
        threeBtn.addTarget(self, action: #selector(threeBtnClick), for: .touchUpInside)
        return threeBtn
    }()
    
    lazy var fourBtn: UIButton = {
        let fourBtn = UIButton(type: .custom)
        fourBtn.addTarget(self, action: #selector(fourBtnClick), for: .touchUpInside)
        return fourBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(nameLabel)
        addSubview(settingBtn)
        addSubview(logoImageView)
        addSubview(phoneLabel)
        addSubview(descLabel)
        addSubview(odcImageView)
        addSubview(bgView)
        odcImageView.addSubview(oneBtn)
        odcImageView.addSubview(twoBtn)
        odcImageView.addSubview(threeBtn)
        odcImageView.addSubview(fourBtn)
        bgView.addSubview(tableView)
        bgImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(450.pix())
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
        settingBtn.snp.makeConstraints { make in
            make.width.height.equalTo(19)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalTo(nameLabel)
        }
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(88)
            make.top.equalTo(nameLabel.snp.bottom).offset(40)
            make.left.equalTo(28)
        }
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView).offset(6)
            make.left.equalTo(logoImageView.snp.right).offset(20)
            make.height.equalTo(25)
        }
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(15)
            make.left.equalTo(phoneLabel)
            make.width.equalTo(170.pix())
        }
        odcImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375.pix(), height: 136.pix()))
            make.top.equalTo(logoImageView.snp.bottom).offset(30)
        }
        bgView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(odcImageView.snp.bottom).offset(-22)
        }
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        oneBtn.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 375.pix() * 0.25, height: 100.pix()))
        }
        twoBtn.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(oneBtn.snp.right)
            make.size.equalTo(CGSize(width: 375.pix() * 0.25, height: 100.pix()))
        }
        threeBtn.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(twoBtn.snp.right)
            make.size.equalTo(CGSize(width: 375.pix() * 0.25, height: 100.pix()))
        }
        fourBtn.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 375.pix() * 0.25, height: 100.pix()))
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CenterView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 138.pix()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        let bgImageView = UIImageView()
        bgImageView.image = languageCode == "1100" ? UIImage(named: "id_c_de_image") : UIImage(named: "id_c_de_image")
        headView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 375.pix(), height: 120.pix()))
        }
        return headView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CenterViewCell", for: indexPath) as! CenterViewCell
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        let model = modelArray[indexPath.row]
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = modelArray[indexPath.row]
        self.cellBlock?(model)
    }
    
}

extension CenterView {
    
    @objc func oneBtnClick() {
        self.tapBlock?("4")
    }
    
    @objc func twoBtnClick() {
        self.tapBlock?("7")
    }
    
    @objc func threeBtnClick() {
        self.tapBlock?("6")
    }
    
    @objc func fourBtnClick() {
        self.tapBlock?("5")
    }
    
}
