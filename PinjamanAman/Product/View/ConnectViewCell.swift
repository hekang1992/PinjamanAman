//
//  ConnectViewCell.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/10.
//

import UIKit
import SnapKit

class ConnectViewCell: UITableViewCell {
    
    var tapRelationBlock: (() -> Void)?
    
    var tapNameBlock: (() -> Void)?
    
    var model: evolveModel? {
        didSet {
            guard let model = model else { return }
            descLabel.text = model.remain ?? ""
            
            relationLabel.text = model.ahistories ?? ""
            enterFiled.placeholder = model.dhistories ?? ""
            
            nameLabel.text = model.chistories ?? ""
            nameFiled.placeholder = model.fhistories ?? ""
            
            let name =  model.blend ?? ""
            let phone = model.beliefs ?? ""
            nameFiled.text = (name.isEmpty || phone.isEmpty) ? "" : String(format: "%@-%@", name, phone)
            
            let value = model.forValue ?? ""
            let modelArray = model.gives ?? []
            for (_, model) in modelArray.enumerated() {
                let target = model.acceptance ?? ""
                if target == value {
                    enterFiled.text = model.blend ?? ""
                }
            }
            
        }
    }
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textAlignment = .left
        descLabel.textColor = UIColor.init(hexString: "#22372E")
        descLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(500))
        return descLabel
    }()
    
    lazy var relationView: UIView = {
        let relationView = UIView()
        relationView.layer.cornerRadius = 18.pix()
        relationView.layer.masksToBounds = true
        relationView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return relationView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "in_p_gr_image")
        return bgImageView
    }()
    
    lazy var relationLabel: UILabel = {
        let relationLabel = UILabel()
        relationLabel.textAlignment = .left
        relationLabel.textColor = UIColor.init(hexString: "#267B3F")
        relationLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return relationLabel
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
    
    lazy var nameView: UIView = {
        let nameView = UIView()
        nameView.layer.cornerRadius = 18.pix()
        nameView.layer.masksToBounds = true
        nameView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return nameView
    }()
    
    lazy var nameImageView: UIImageView = {
        let nameImageView = UIImageView()
        nameImageView.image = UIImage(named: "in_p_gr_image")
        return nameImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#267B3F")
        nameLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return nameLabel
    }()
    
    lazy var nameFiled: UITextField = {
        let nameFiled = UITextField()
        nameFiled.isEnabled = false
        nameFiled.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        nameFiled.textColor = UIColor.init(hexString: "#203D31")
        nameFiled.leftView = UIView(frame: CGRectMake(0, 0, 15, 15))
        nameFiled.leftViewMode = .always
        return nameFiled
    }()
    
    lazy var arrowNameImageView: UIImageView = {
        let arrowNameImageView = UIImageView()
        arrowNameImageView.image = UIImage(named: "right_ac_liamge")
        return arrowNameImageView
    }()
    
    lazy var tapNameBtn: UIButton = {
        let tapNameBtn = UIButton(type: .custom)
        tapNameBtn.addTarget(self, action: #selector(tapNameBtnClick), for: .touchUpInside)
        return tapNameBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(descLabel)
        
        contentView.addSubview(relationView)
        relationView.addSubview(bgImageView)
        bgImageView.addSubview(relationLabel)
        relationView.addSubview(enterFiled)
        relationView.addSubview(arrowImageView)
        relationView.addSubview(tapBtn)
        
        contentView.addSubview(nameView)
        nameView.addSubview(nameImageView)
        nameImageView.addSubview(nameLabel)
        nameView.addSubview(nameFiled)
        nameView.addSubview(arrowNameImageView)
        nameView.addSubview(tapNameBtn)
        
        descLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(15)
        }
        
        relationView.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 88.pix()))
        }
        
        bgImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(42.pix())
        }
        relationLabel.snp.makeConstraints { make in
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
        
        nameView.snp.makeConstraints { make in
            make.top.equalTo(relationView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 88.pix()))
            make.bottom.equalToSuperview().offset(-15)
        }
        
        nameImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(42.pix())
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(16)
        }
        
        nameFiled.snp.makeConstraints { make in
            make.top.equalTo(nameImageView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        arrowNameImageView.snp.makeConstraints { make in
            make.centerY.equalTo(nameFiled)
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 14, height: 12))
        }
        tapNameBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ConnectViewCell {
    
    @objc func tapBtnClick() {
        self.tapRelationBlock?()
    }
    
    @objc func tapNameBtnClick() {
        self.tapNameBlock?()
    }
    
}
