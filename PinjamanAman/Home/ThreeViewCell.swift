//
//  ThreeViewCell.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/11.
//

import UIKit
import SnapKit
import Kingfisher

class ThreeViewCell: UITableViewCell {
    
    var model: forgivenessModel? {
        didSet {
            guard let model = model else { return }
            productImageView.kf.setImage(with: URL(string: model.conflicts ?? ""))
            nameLabel.text = model.soften ?? ""
            moneyLabel.text = model.effectively ?? ""
            uptoLabel.text = model.communicate ?? ""
            let day = model.tested ?? ""
            let aday = model.divide ?? ""
            let spacing = "   "
            rateLabel.text = String(format: "%@%@|%@%@", day, spacing, spacing, aday)
            applyBtn.setTitle(model.resolve ?? "", for: .normal)
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.white
        return bgView
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
        moneyLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        return moneyLabel
    }()
    
    lazy var uptoLabel: UILabel = {
        let uptoLabel = UILabel()
        uptoLabel.textAlignment = .left
        uptoLabel.textColor = UIColor.init(hexString: "#B0B4B3")
        uptoLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return uptoLabel
    }()
    
    lazy var rateLabel: UILabel = {
        let rateLabel = UILabel()
        rateLabel.textAlignment = .right
        rateLabel.textColor = UIColor.init(hexString: "#267B3F")
        rateLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return rateLabel
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setTitleColor(.white, for: .normal)
        applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(500))
        if AppLanguageCodeManager.getLanguageCode() == "1100" {
            applyBtn.setBackgroundImage(UIImage(named: "od_td_ap_im_ac"), for: .normal)
        }else {
            applyBtn.setBackgroundImage(UIImage(named: "od_t_ap_im_ac"), for: .normal)
        }
        applyBtn.isUserInteractionEnabled = false
        return applyBtn
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.layer.cornerRadius = 1
        lineView.layer.masksToBounds = true
        lineView.backgroundColor = UIColor.init(hexString: "#F6F6F4")
        return lineView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(115.pix())
            make.bottom.equalToSuperview()
        }
        
        bgView.addSubview(productImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(moneyLabel)
        bgView.addSubview(uptoLabel)
        bgView.addSubview(rateLabel)
        bgView.addSubview(applyBtn)
        bgView.addSubview(lineView)
        
        productImageView.snp.makeConstraints { make in
            make.width.height.equalTo(26)
            make.left.equalToSuperview().offset(15.pix())
            make.top.equalToSuperview().offset(15.pix())
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(productImageView)
            make.left.equalTo(productImageView.snp.right).offset(5)
            make.height.equalTo(30)
        }
        moneyLabel.snp.makeConstraints { make in
            make.left.equalTo(productImageView)
            make.top.equalTo(productImageView.snp.bottom).offset(15.pix())
            make.height.equalTo(22)
        }
        uptoLabel.snp.makeConstraints { make in
            make.left.equalTo(moneyLabel)
            make.top.equalTo(moneyLabel.snp.bottom).offset(2.pix())
            make.height.equalTo(14)
        }
        rateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(16)
        }
        applyBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.right.equalToSuperview().offset(-15.pix())
            if AppLanguageCodeManager.getLanguageCode() == "1100" {
                make.size.equalTo(CGSize(width: 140.pix(), height: 36.pix()))
            }else {
                make.size.equalTo(CGSize(width: 106.pix(), height: 36.pix()))
            }
        }
        lineView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
            make.left.equalToSuperview().offset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
