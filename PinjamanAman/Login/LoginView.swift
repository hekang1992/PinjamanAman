//
//  LoginView.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/9.
//

import UIKit
import SnapKit

class LoginView: BaseView {
    
    var ablock: (() -> Void)?
    
    var backblock: (() -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "login_head_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = languageCode == "1100" ? UIImage(named: "id_login_desc_image") : UIImage(named: "en_login_desc_image")
        return oneImageView
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "login_desc_image")
        return twoImageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var threeImageView: UIImageView = {
        let threeImageView = UIImageView()
        threeImageView.image = UIImage(named: "login_list_image")
        threeImageView.isUserInteractionEnabled = true
        return threeImageView
    }()
    
    lazy var phoneListView: LoginListView = {
        let phoneListView = LoginListView()
        return phoneListView
    }()
    
    lazy var codeListView: CodeListView = {
        let codeListView = CodeListView()
        return codeListView
    }()
    
    lazy var sureAgreementBtn: UIButton = {
        let sureAgreementBtn = UIButton(type: .custom)
        sureAgreementBtn.isSelected = true
        sureAgreementBtn.setImage(UIImage(named: "in_tc_xz"), for: .normal)
        sureAgreementBtn.setImage(UIImage(named: "sel_tc_xz"), for: .selected)
        return sureAgreementBtn
    }()
    
    lazy var entBtn: UIButton = {
        let entBtn = UIButton(type: .custom)
        entBtn.setImage(languageCode == "1100" ? UIImage(named: "prc_id_a_imagre") : UIImage(named: "prc_en_a_imagre"), for: .normal)
        entBtn.addTarget(self, action: #selector(entBtnClick), for: .touchUpInside)
        return entBtn
    }()
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.setTitle(languageCode == "1100" ? "Masuk" : "Login", for: .normal)
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(700))
        loginBtn.setBackgroundImage(UIImage(named: "login_btn_bg_image"), for: .normal)
        return loginBtn
    }()
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setBackgroundImage(UIImage(named: "back_li_image"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        return backBtn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(hexString: "#F6F6F4")
        addSubview(bgImageView)
        addSubview(oneImageView)
        addSubview(twoImageView)
        addSubview(backBtn)
        addSubview(scrollView)
        scrollView.addSubview(threeImageView)
        threeImageView.addSubview(phoneListView)
        threeImageView.addSubview(codeListView)
        threeImageView.addSubview(sureAgreementBtn)
        threeImageView.addSubview(entBtn)
        threeImageView.addSubview(loginBtn)
        
        bgImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(244.pix())
        }
        oneImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(93)
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 270, height: 59))
        }
        twoImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 134, height: 125))
        }
        
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(18)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        threeImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 339.pix(), height: 348.pix()))
            make.bottom.equalToSuperview().offset(-20.pix())
        }
        phoneListView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(91)
        }
        codeListView.snp.makeConstraints { make in
            make.top.equalTo(phoneListView.snp.bottom)
            make.left.right.equalTo(phoneListView)
            make.height.equalTo(91)
        }
        sureAgreementBtn.snp.makeConstraints { make in
            make.width.height.equalTo(14)
            make.top.equalTo(codeListView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        entBtn.snp.makeConstraints { make in
            make.centerY.equalTo(sureAgreementBtn)
            make.left.equalTo(sureAgreementBtn.snp.right).offset(5)
            if languageCode == "1100" {
                make.size.equalTo(CGSize(width: 214.pix(), height: 13.pix()))
            }else {
                make.size.equalTo(CGSize(width: 264.pix(), height: 13.pix()))
            }
        }
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-38)
            make.size.equalTo(CGSize(width: 295.pix(), height: 50.pix()))
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LoginView {
    
    @objc func entBtnClick() {
        self.ablock?()
    }
    
    @objc func backBtnClick() {
        self.backblock?()
    }

}
