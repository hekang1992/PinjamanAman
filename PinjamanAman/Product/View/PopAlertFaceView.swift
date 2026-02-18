//
//  PopAlertFaceView.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/10.
//

import UIKit
import SnapKit

class PopAlertFaceView: BaseView {
    
    var cancelBlock: (() -> Void)?
    var sureBlock: (() -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = languageCode == "1100" ? UIImage(named: "ale_id_cad_bg") : UIImage(named: "ale_en_cad_bg")
        bgImageView.contentMode = .scaleAspectFit
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setBackgroundImage(UIImage(named: "ale_can_ic_bg"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        return cancelBtn
    }()
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        sureBtn.addTarget(self, action: #selector(sureBtnClick), for: .touchUpInside)
        return sureBtn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(sureBtn)
        addSubview(cancelBtn)
        
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 337.pix(), height: 458.pix()))
        }
        sureBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-33)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 280.pix(), height: 46.pix()))
        }
        cancelBtn.snp.makeConstraints { make in
            make.bottom.equalTo(bgImageView.snp.top).offset(-15)
            make.right.equalTo(bgImageView)
            make.width.height.equalTo(22)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PopAlertFaceView {
    
    @objc func cancelBtnClick() {
        self.cancelBlock?()
    }
    
    @objc func sureBtnClick() {
        self.sureBlock?()
    }
    
}
