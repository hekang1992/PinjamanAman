//
//  EnterTextCell.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/10.
//

import UIKit
import SnapKit

class EnterTextCell: UITableViewCell {
    
    var enterFiledBlock: ((String) -> Void)?
    
    var model: evolveModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.strain ?? ""
            enterFiled.placeholder = model.cultivated ?? ""
            
            let bonds = model.bonds ?? ""
            enterFiled.keyboardType = bonds == "1" ? .numberPad : .default
            
            enterFiled.text = model.worlds ?? ""
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
        enterFiled.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        enterFiled.textColor = UIColor.init(hexString: "#203D31")
        enterFiled.leftView = UIView(frame: CGRectMake(0, 0, 15, 15))
        enterFiled.leftViewMode = .always
        enterFiled.addTarget(self, action: #selector(enterFiledChange(_:)), for: .editingChanged)
        return enterFiled
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgView)
        bgView.addSubview(bgImageView)
        bgImageView.addSubview(nameLabel)
        bgView.addSubview(enterFiled)
        
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EnterTextCell {
    
    @objc private func enterFiledChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        self.enterFiledBlock?(text)
    }
    
}
