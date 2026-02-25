//
//  ProductStepViewCell.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/9.
//

import UIKit
import SnapKit
import Kingfisher

class ProductStepViewCell: UITableViewCell {
    
    var model: strikeModel? {
        didSet {
            guard let model = model else { return }
            logoImageView.kf.setImage(with: URL(string: model.spirit ?? ""))
            nameLabel.text = model.strain ?? ""
            descLabel.text = model.cultivated ?? ""
            let laugh = model.laugh ?? 0
            
            stepLabel.textColor = laugh == 1 ? UIColor.init(hexString: "#267B3F") : UIColor.init(hexString: "#B0B4B3")
            
            bgImageView.image = laugh == 1 ? UIImage(named: "comp_step_image") : UIImage(named: "nor_step_image")
            
            compImageView.image = laugh == 1 ? UIImage(named: "cpxq_dh_ic") : UIImage(named: "cpxq_jt_ic")
            
            nameLabel.textColor = laugh == 1 ? UIColor.init(hexString: "#267B3F") : UIColor.init(hexString: "#B0B4B3")
            
            cycleImageView.image = laugh == 1 ? UIImage(named: "cpxq_ic") : UIImage(named: "nor_cpxq_icimage")
            
            typeImageView.image = laugh == 1 ? UIImage(named: "sel_li_i_image") : UIImage(named: "nor_li_i_image")
            
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .clear
        return bgView
    }()
    
    lazy var cycleImageView: UIImageView = {
        let cycleImageView = UIImageView()
        cycleImageView.image = UIImage(named: "nor_cpxq_icimage")
        return cycleImageView
    }()
    
    lazy var typeImageView: UIImageView = {
        let typeImageView = UIImageView()
        typeImageView.image = UIImage(named: "nor_li_i_image")
        return typeImageView
    }()
    
    lazy var stepLabel: UILabel = {
        let stepLabel = UILabel()
        stepLabel.textAlignment = .left
        stepLabel.textColor = UIColor.init(hexString: "#B0B4B3")
        stepLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(500))
        return stepLabel
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "nor_step_image")
        return bgImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 8
        logoImageView.layer.masksToBounds = true
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#B0B4B3")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return nameLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textAlignment = .left
        descLabel.numberOfLines = 0
        descLabel.textColor = UIColor.init(hexString: "#B0B4B3")
        descLabel.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        return descLabel
    }()
    
    lazy var compImageView: UIImageView = {
        let compImageView = UIImageView()
        compImageView.image = UIImage(named: "cpxq_jt_ic")
        return compImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        bgView.addSubview(cycleImageView)
        bgView.addSubview(typeImageView)
        bgView.addSubview(stepLabel)
        bgView.addSubview(bgImageView)
        bgImageView.addSubview(logoImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(descLabel)
        bgImageView.addSubview(compImageView)
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(110)
            make.bottom.equalToSuperview()
        }
        cycleImageView.snp.makeConstraints { make in
            make.width.height.equalTo(16.pix())
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(15)
        }
        typeImageView.snp.makeConstraints { make in
            make.centerX.equalTo(cycleImageView)
            make.top.equalTo(cycleImageView.snp.bottom).offset(2)
            make.size.equalTo(CGSize(width: 3, height: 85))
        }
        stepLabel.snp.makeConstraints { make in
            make.centerY.equalTo(cycleImageView)
            make.left.equalTo(cycleImageView.snp.right).offset(8)
            make.height.equalTo(15)
        }
        bgImageView.snp.makeConstraints { make in
            make.top.equalTo(stepLabel.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 281, height: 69))
            make.right.equalToSuperview().offset(-15)
        }
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.width.height.equalTo(40)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalTo(logoImageView.snp.right).offset(8)
            make.height.equalTo(14)
        }
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.equalTo(logoImageView.snp.right).offset(8)
            make.right.equalToSuperview().offset(-40)
        }
        compImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 20, height: 20))
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
