//
//  LoginListView.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/9.
//

import UIKit
import SnapKit

class LoginListView: BaseView {
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "dl_cp_ic")
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = languageCode == "1100" ? "Nomor ponsel login" : "Login mobile number"
        nameLabel.textColor = UIColor.init(hexString: "#203D31")
        nameLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight(500))
        return nameLabel
    }()
    
    lazy var numLabel: UILabel = {
        let numLabel = UILabel()
        numLabel.textAlignment = .left
        numLabel.text = languageCode == "1100" ? "+91" : "+62"
        numLabel.textColor = UIColor.init(hexString: "#203D31")
        numLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(500))
        return numLabel
    }()
    
    lazy var phoneFiled: UITextField = {
        let phoneFiled = UITextField()
        phoneFiled.keyboardType = .numberPad
        phoneFiled.placeholder = languageCode == "1100" ? "Nomor telepon" : "Phone number"
        phoneFiled.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(300))
        phoneFiled.textColor = UIColor.init(hexString: "#203D31")
        return phoneFiled
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.layer.cornerRadius = 2
        lineView.layer.masksToBounds = true
        lineView.backgroundColor = UIColor.init(hexString: "#F1F1F1")
        return lineView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(logoImageView)
        addSubview(nameLabel)
        addSubview(numLabel)
        addSubview(phoneFiled)
        addSubview(lineView)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.left.equalToSuperview().offset(22)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)
            make.left.equalTo(logoImageView.snp.right).offset(18)
            make.height.equalTo(16)
        }
        numLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 28, height: 18))
        }
        phoneFiled.snp.makeConstraints { make in
            make.centerY.equalTo(numLabel)
            make.left.equalTo(numLabel.snp.right).offset(8)
            make.height.equalTo(30)
            make.right.equalToSuperview().offset(-24)
        }
        lineView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(1)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
