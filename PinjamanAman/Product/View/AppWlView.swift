//
//  AppWlView.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/18.
//

import UIKit
import SnapKit

class AppWlView: BaseView {
    
    var cancelBlock: (() -> Void)?
    var confirmBlock: (() -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = languageCode == "1100" ? UIImage(named: "wl_end_bg") : UIImage(named: "wl_en_bg")
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

extension AppWlView {
    
    @objc func confirmBtnClick() {
        self.confirmBlock?()
    }
    
    @objc func cancelBtnClick() {
        self.cancelBlock?()
    }
    
}
