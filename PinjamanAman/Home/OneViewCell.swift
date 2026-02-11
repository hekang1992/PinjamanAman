//
//  OneViewCell.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/11.
//

import UIKit
import SnapKit
import Kingfisher

class OneViewCell: UITableViewCell {
    
    var model: forgivenessModel? {
        didSet {
            guard let model = model else { return }
            productImageView.kf.setImage(with: URL(string: model.conflicts ?? ""))
            nameLabel.text = model.soften ?? ""
            moneyLabel.text = model.effectively ?? ""
            uptoLabel.text = model.communicate ?? ""
            let day = model.few ?? ""
            let aday = model.misunderstandings ?? ""
            let spacing = "    "
            rateLabel.text = String(format: "%@%@|%@%@", day, spacing, spacing, aday)
            applyBtn.setTitle(model.resolve ?? "", for: .normal)
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "tc_bgt_image")
        bgImageView.contentMode = .scaleAspectFit
        return bgImageView
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
    
    lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.textAlignment = .left
        moneyLabel.textColor = UIColor.init(hexString: "#203D31")
        moneyLabel.font = UIFont.systemFont(ofSize: 46, weight: .bold)
        return moneyLabel
    }()
    
    lazy var uptoLabel: UILabel = {
        let uptoLabel = UILabel()
        uptoLabel.textAlignment = .left
        uptoLabel.textColor = UIColor.init(hexString: "#B0B4B3")
        uptoLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return uptoLabel
    }()
    
    lazy var rateLabel: UILabel = {
        let rateLabel = UILabel()
        rateLabel.textAlignment = .left
        rateLabel.textColor = UIColor.init(hexString: "#267B3F")
        rateLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return rateLabel
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setTitleColor(.white, for: .normal)
        applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(700))
        applyBtn.setBackgroundImage(UIImage(named: "cen_log_image"), for: .normal)
//        applyBtn.addTarget(self, action: #selector(applyBtnClick), for: .touchUpInside)
        applyBtn.isUserInteractionEnabled = true
        return applyBtn
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375.pix(), height: 304.pix()))
            make.bottom.equalToSuperview()
        }
        
        bgImageView.addSubview(productImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(moneyLabel)
        bgImageView.addSubview(uptoLabel)
        bgImageView.addSubview(rateLabel)
        bgImageView.addSubview(applyBtn)
        
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
        moneyLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.top.equalTo(productImageView.snp.bottom).offset(15.pix())
            make.height.equalTo(50)
        }
        uptoLabel.snp.makeConstraints { make in
            make.left.equalTo(moneyLabel)
            make.top.equalTo(moneyLabel.snp.bottom).offset(2.pix())
            make.height.equalTo(15)
        }
        rateLabel.snp.makeConstraints { make in
            make.top.equalTo(uptoLabel.snp.bottom).offset(20.pix())
            make.left.equalTo(uptoLabel)
            make.height.equalTo(16)
        }
        applyBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-28.pix())
            make.size.equalTo(CGSize(width: 280.pix(), height: 46.pix()))
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
