//
//  OneView.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/9.
//

import UIKit
import SnapKit

class OneView: BaseView {
    
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
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = UserSessionManager.shared.phone ?? ""
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(500))
        return nameLabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        return bgView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var cardImageView: UIImageView = {
        let cardImageView = UIImageView()
        cardImageView.image = UIImage(named: "home_card_image")
        return cardImageView
    }()
    
    lazy var mentImageView: UIImageView = {
        let mentImageView = UIImageView()
        mentImageView.image = UIImage(named: "home_pri_image")
        return mentImageView
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "home_one_image")
        return oneImageView
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "home_two_image")
        return twoImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(bgView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(nameLabel)
        addSubview(scrollView)
        scrollView.addSubview(cardImageView)
        scrollView.addSubview(mentImageView)
        scrollView.addSubview(footView)
        footView.addSubview(oneImageView)
        footView.addSubview(twoImageView)
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
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(logoImageView.snp.right).offset(15)
            make.height.equalTo(30)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(bgView.snp.bottom).offset(-20)
            make.left.right.bottom.equalToSuperview()
        }
        cardImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375.pix(), height: 340.pix()))
        }
        mentImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375.pix(), height: 86.pix()))
            make.top.equalTo(cardImageView.snp.bottom).offset(16)
        }
        footView.snp.makeConstraints { make in
            make.top.equalTo(mentImageView.snp.bottom).offset(-30)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(703.pix())
            make.bottom.equalToSuperview()
        }
        oneImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 192.pix()))
        }
        twoImageView.snp.makeConstraints { make in
            make.top.equalTo(oneImageView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 441.pix()))
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
