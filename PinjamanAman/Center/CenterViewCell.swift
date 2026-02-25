//
//  CenterViewCell.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/9.
//

import UIKit
import SnapKit
import Kingfisher

class CenterViewCell: UITableViewCell {
    
    var model: confideModel? {
        didSet {
            guard let model = model else { return }
            bgImageView.kf.setImage(with: URL(string: model.gaining ?? ""))
            nameLabel.text = model.strain ?? ""
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.layer.cornerRadius = 8
        bgImageView.layer.masksToBounds = true
//        bgImageView.backgroundColor = .systemGreen
        return bgImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#203D31")
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        return nameLabel
    }()
    
    lazy var arrowImageView: UIImageView = {
        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage(named: "right_ac_liamge")
        return arrowImageView
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.layer.cornerRadius = 2
        lineView.layer.masksToBounds = true
        lineView.backgroundColor = UIColor.init(hexString: "#F1F1F1")
        return lineView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(arrowImageView)
        contentView.addSubview(lineView)
        
        bgImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-17)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(bgImageView.snp.right).offset(10)
            make.height.equalTo(20)
        }
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 14, height: 14))
        }
        lineView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
