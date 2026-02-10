//
//  PopSaveInfoView.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/10.
//

import UIKit
import SnapKit

class PopSaveInfoView: BaseView {
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "comsa_ve_image")
        bgImageView.contentMode = .scaleAspectFit
        return bgImageView
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setBackgroundImage(UIImage(named: "ale_can_ic_bg"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        return cancelBtn
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setTitleColor(.white, for: .normal)
        applyBtn.setTitle(languageCode == "1100" ? "Mengonfirmasi" : "Confirm", for: .normal)
        applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(700))
        applyBtn.setBackgroundImage(UIImage(named: "cen_log_image"), for: .normal)
        applyBtn.addTarget(self, action: #selector(applyBtnClick), for: .touchUpInside)
        return applyBtn
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 18
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return bgView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.text = languageCode == "1100" ? "Verifikasi informasi identitas" : "Verify identity information"
        nameLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(700))
        return nameLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.numberOfLines = 0
        descLabel.textAlignment = .center
        descLabel.text = languageCode == "1100" ? "*Mohon periksa kembali informasi lD Anda dengan benar, jika sudah terkirim tidak akan diubah lagi" : "*Please check your lD information correctly, oncesubmitted it is not changed again"
        descLabel.textColor = UIColor.init(hexString: "#F6524D")
        descLabel.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        return descLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bgImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(bgView)
        bgView.addSubview(descLabel)
        bgView.addSubview(applyBtn)
        addSubview(cancelBtn)
        
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 337.pix(), height: 458.pix()))
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.bottom.equalTo(bgImageView.snp.top).offset(-15)
            make.right.equalTo(bgImageView)
            make.width.height.equalTo(22)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        
        bgView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 311.pix(), height: 394.pix()))
        }
        
        descLabel.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 270.pix(), height: 30.pix()))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
        }
        
        applyBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(descLabel.snp.top).offset(-12)
            make.size.equalTo(CGSize(width: 280.pix(), height: 46.pix()))
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PopSaveInfoView {
    
    @objc func cancelBtnClick() {
        
    }
    
    @objc func applyBtnClick() {
        
    }
}
