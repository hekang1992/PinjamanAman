//
//  AppCancelView.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/9.
//


import UIKit
import SnapKit

class AppCancelView: BaseView {
    
    var cancelBlock: (() -> Void)?
    var confirmBlock: (() -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = languageCode == "1100" ? UIImage(named: "id_detc_bg") : UIImage(named: "en_detc_bg")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var confirmBtn: UIButton = {
        let confirmBtn = UIButton(type: .custom)
        confirmBtn.addTarget(self, action: #selector(confirmBtnClick), for: .touchUpInside)
        return confirmBtn
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        return cancelBtn
    }()
    
    lazy var sureAgreementBtn: UIButton = {
        let sureAgreementBtn = UIButton(type: .custom)
        sureAgreementBtn.setImage(UIImage(named: "in_tc_xz"), for: .normal)
        sureAgreementBtn.setImage(UIImage(named: "sel_tc_xz"), for: .selected)
        sureAgreementBtn.addTarget(self, action: #selector(sureAgreementBtnClick), for: .touchUpInside)
        return sureAgreementBtn
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 0
        nameLabel.text = languageCode == "1100" ? "Saya telah membaca dan menyetujui hal-hal di atas." : "I have read and agree to the above"
        nameLabel.textColor = UIColor.init(hexString: "#B0B4B3")
        nameLabel.font = UIFont.systemFont(ofSize: 11, weight: UIFont.Weight(300))
        return nameLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(confirmBtn)
        bgImageView.addSubview(cancelBtn)
        bgImageView.addSubview(sureAgreementBtn)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(sureAgreementBtn)
        bgImageView.addSubview(nameLabel)
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 317.pix(), height: 395.pix()))
        }
        
        confirmBtn.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(68.pix())
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(confirmBtn.snp.top)
            make.height.equalTo(46.pix())
        }
        
        sureAgreementBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(45)
            make.width.height.equalTo(14)
            make.bottom.equalTo(cancelBtn.snp.top).offset(-16)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(sureAgreementBtn)
            make.left.equalTo(sureAgreementBtn.snp.right).offset(5)
            make.right.equalToSuperview().offset(-46)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AppCancelView {
    
    @objc func confirmBtnClick() {
        self.confirmBlock?()
    }
    
    @objc func cancelBtnClick() {
        self.cancelBlock?()
    }
    
    @objc func sureAgreementBtnClick() {
        self.sureAgreementBtn.isSelected.toggle()
    }
}
