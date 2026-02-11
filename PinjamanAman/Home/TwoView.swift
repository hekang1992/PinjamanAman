//
//  TwoView.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/11.
//

import UIKit
import SnapKit
import Kingfisher

class TwoView: BaseView {
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "center_bg_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "logo_ho_image")
        return logoImageView
    }()
    
    lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.text = UserSessionManager.shared.phone ?? ""
        phoneLabel.textAlignment = .left
        phoneLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        phoneLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(500))
        return phoneLabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        return bgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(bgView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(phoneLabel)
        addSubview(footView)
        
        bgImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(450.pix())
        }
        bgView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(38)
            make.left.equalToSuperview().offset(20)
        }
        phoneLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(logoImageView.snp.right).offset(15)
            make.height.equalTo(30)
        }
        footView.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.bottom).offset(-25.pix())
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

