//
//  AppLogoutView.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/9.
//

import UIKit
import SnapKit

class AppLogoutView: BaseView {
    
    var cancelBlock: (() -> Void)?
    var confirmBlock: (() -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = languageCode == "1100" ? UIImage(named: "id_tctc_bg") : UIImage(named: "en_tctc_bg")
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(confirmBtn)
        bgImageView.addSubview(cancelBtn)
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 317.pix(), height: 304.pix()))
        }
        
        confirmBtn.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(68.pix())
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(confirmBtn.snp.top)
            make.height.equalTo(60.pix())
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AppLogoutView {
    
    @objc func confirmBtnClick() {
        self.confirmBlock?()
    }
    
    @objc func cancelBtnClick() {
        self.cancelBlock?()
    }
    
}
