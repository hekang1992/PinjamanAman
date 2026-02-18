//
//  CodeListView 2.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/9.
//


import UIKit
import SnapKit

class CodeListView: BaseView {
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "dl_vc_ic")
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = languageCode == "1100" ? "Kode verifikasi" : "Verification code"
        nameLabel.textColor = UIColor.init(hexString: "#203D31")
        nameLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight(500))
        return nameLabel
    }()
    
    lazy var codeFiled: UITextField = {
        let codeFiled = UITextField()
        codeFiled.keyboardType = .numberPad
        codeFiled.placeholder = languageCode == "1100" ? "Kode verifikasi" : "Verification code"
        codeFiled.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(300))
        codeFiled.textColor = UIColor.init(hexString: "#203D31")
        return codeFiled
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.layer.cornerRadius = 2
        lineView.layer.masksToBounds = true
        lineView.backgroundColor = UIColor.init(hexString: "#F1F1F1")
        return lineView
    }()
    
    lazy var codeBtn: UIButton = {
        let codeBtn = UIButton(type: .custom)
        codeBtn.setTitle(languageCode == "1100" ? "Dapatkan kode" : "Send code", for: .normal)
        codeBtn.setTitleColor(UIColor.init(hexString: "#267B3F"), for: .normal)
        codeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(400))
        return codeBtn
    }()
    
    lazy var btnLineView: UIView = {
        let btnLineView = UIView()
        btnLineView.backgroundColor = UIColor.init(hexString: "#267B3F")
        btnLineView.isHidden = true
        return btnLineView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(logoImageView)
        addSubview(nameLabel)
        addSubview(codeFiled)
        addSubview(lineView)
        addSubview(codeBtn)
        codeBtn.addSubview(btnLineView)
        
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
        codeFiled.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.left.equalTo(nameLabel)
            make.height.equalTo(30)
            make.right.equalToSuperview().offset(-110)
        }
        lineView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(1)
        }
        
        codeBtn.snp.makeConstraints { make in
            make.centerY.equalTo(codeFiled)
            make.right.equalToSuperview().offset(-20)
            if languageCode == "1100" {
                make.size.equalTo(CGSize(width: 118, height: 16))
            }else {
                make.size.equalTo(CGSize(width: 85, height: 16))
            }
        }
        btnLineView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
