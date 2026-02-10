//
//  TapCell.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/10.
//

import UIKit
import SnapKit

class TapCell: UITableViewCell {
    
    var tapBlock: (() -> Void)?
    
    var model: evolveModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.strain ?? ""
            enterFiled.placeholder = model.cultivated ?? ""
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 18.pix()
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return bgView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "in_p_gr_image")
        return bgImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#267B3F")
        nameLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return nameLabel
    }()
    
    lazy var enterFiled: UITextField = {
        let enterFiled = UITextField()
        enterFiled.isEnabled = false
        enterFiled.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        enterFiled.textColor = UIColor.init(hexString: "#203D31")
        enterFiled.leftView = UIView(frame: CGRectMake(0, 0, 15, 15))
        enterFiled.leftViewMode = .always
        return enterFiled
    }()
    
    lazy var arrowImageView: UIImageView = {
        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage(named: "right_ac_liamge")
        return arrowImageView
    }()
    
    lazy var tapBtn: UIButton = {
        let tapBtn = UIButton(type: .custom)
        tapBtn.addTarget(self, action: #selector(tapBtnClick), for: .touchUpInside)
        return tapBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgView)
        bgView.addSubview(bgImageView)
        bgImageView.addSubview(nameLabel)
        bgView.addSubview(enterFiled)
        bgView.addSubview(arrowImageView)
        bgView.addSubview(tapBtn)
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 88.pix()))
            make.bottom.equalToSuperview().offset(-15)
        }
        
        bgImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(42.pix())
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(16)
        }
        
        enterFiled.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalTo(enterFiled)
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 14, height: 12))
        }
        tapBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TapCell {
    
    @objc func tapBtnClick() {
        self.tapBlock?()
    }
    
}
