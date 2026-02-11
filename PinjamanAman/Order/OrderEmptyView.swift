//
//  OrderEmptyView.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/11.
//

import UIKit
import SnapKit

class OrderEmptyView: BaseView {
    
    var applyBtnBlock: (() -> Void)?
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setBackgroundImage(languageCode == "1100" ? UIImage(named: "id_kon_ic_image") : UIImage(named: "en_kon_ic_image"), for: .normal)
        applyBtn.adjustsImageWhenHighlighted = false
        applyBtn.addTarget(self, action: #selector(applyBtnClick), for: .touchUpInside)
        return applyBtn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(applyBtn)
        applyBtn.snp.makeConstraints { make in
            make.center.equalToSuperview()
            if languageCode == "1100" {
                make.size.equalTo(CGSize(width: 198.pix(), height: 182.pix()))
            }else {
                make.size.equalTo(CGSize(width: 139.pix(), height: 182.pix()))
            }
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OrderEmptyView {
    
    @objc func applyBtnClick() {
        self.applyBtnBlock?()
    }
}
