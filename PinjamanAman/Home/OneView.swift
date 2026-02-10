//
//  OneView.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/9.
//

import UIKit
import SnapKit
import Kingfisher

class OneView: BaseView {
    
    var tapBlock: ((forgivenessModel) -> Void)?
    
    var model: forgivenessModel? {
        didSet {
            guard let model = model else { return }
            let pageUrl = model.conflicts ?? ""
            productImageView.kf.setImage(with: URL(string: pageUrl))
            nameLabel.text = model.soften ?? ""
            moneyLabel.text = model.effectively ?? ""
            uptoLabel.text = model.communicate ?? ""
            
            oneListView.oneLabel.text = model.few ?? ""
            oneListView.twoLabel.text = model.demands ?? ""
            
            twoListView.oneLabel.text = model.misunderstandings ?? ""
            twoListView.twoLabel.text = model.opinion ?? ""
            
            applyBtn.setTitle(model.resolve ?? "", for: .normal)
        }
    }
    
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
        cardImageView.isUserInteractionEnabled = true
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
    
    lazy var idFootImageView: UIImageView = {
        let idFootImageView = UIImageView()
        idFootImageView.image = UIImage(named: "foa_idimage_ync")
        return idFootImageView
    }()
    
    lazy var productImageView: UIImageView = {
        let productImageView = UIImageView()
        productImageView.layer.cornerRadius = 8
        productImageView.layer.masksToBounds = true
        productImageView.backgroundColor = .systemGreen
        return productImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#203D31")
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        return nameLabel
    }()
    
    lazy var descImageView: UIImageView = {
        let descImageView = UIImageView()
        descImageView.image = languageCode == "1100" ? UIImage(named: "id_ho_a_yn") : UIImage(named: "home_cdesc_image")
        return descImageView
    }()
    
    lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.textAlignment = .center
        moneyLabel.textColor = UIColor.init(hexString: "#203D31")
        moneyLabel.font = UIFont.systemFont(ofSize: 46, weight: UIFont.Weight(600))
        return moneyLabel
    }()
    
    lazy var uptoLabel: UILabel = {
        let uptoLabel = UILabel()
        uptoLabel.textAlignment = .center
        uptoLabel.textColor = UIColor.init(hexString: "#B0B4B3")
        uptoLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(500))
        return uptoLabel
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setTitleColor(.white, for: .normal)
        applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(700))
        applyBtn.setBackgroundImage(UIImage(named: "cen_log_image"), for: .normal)
        applyBtn.addTarget(self, action: #selector(applyBtnClick), for: .touchUpInside)
        return applyBtn
    }()
    
    lazy var oneListView: CardListView = {
        let oneListView = CardListView()
        return oneListView
    }()
    
    lazy var twoListView: CardListView = {
        let twoListView = CardListView()
        return twoListView
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.layer.cornerRadius = 1
        lineView.layer.masksToBounds = true
        lineView.backgroundColor = UIColor.init(hexString: "#F6F6F4")
        return lineView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(bgView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(phoneLabel)
        addSubview(scrollView)
        scrollView.addSubview(cardImageView)
        
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
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(bgView.snp.bottom).offset(-20)
            make.left.right.bottom.equalToSuperview()
        }
        cardImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375.pix(), height: 340.pix()))
        }
        
        cardImageView.addSubview(productImageView)
        cardImageView.addSubview(nameLabel)
        cardImageView.addSubview(descImageView)
        cardImageView.addSubview(moneyLabel)
        cardImageView.addSubview(uptoLabel)
        cardImageView.addSubview(applyBtn)
        cardImageView.addSubview(lineView)
        cardImageView.addSubview(oneListView)
        cardImageView.addSubview(twoListView)
        
        productImageView.snp.makeConstraints { make in
            make.width.height.equalTo(26)
            make.left.equalToSuperview().offset(40.pix())
            make.top.equalToSuperview().offset(60.pix())
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(productImageView)
            make.left.equalTo(productImageView.snp.right).offset(5)
            make.height.equalTo(30)
        }
        descImageView.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(5)
            make.left.equalTo(productImageView)
            make.size.equalTo(CGSize(width: 220.pix(), height: 20.pix()))
        }
        moneyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descImageView.snp.bottom).offset(15)
            make.height.equalTo(50)
        }
        uptoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(moneyLabel.snp.bottom).offset(2)
            make.height.equalTo(15)
        }
        applyBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(uptoLabel.snp.bottom).offset(19)
            make.size.equalTo(CGSize(width: 280.pix(), height: 46.pix()))
        }
        lineView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-35)
            make.size.equalTo(CGSize(width: 1, height: 25.pix()))
        }
        
        oneListView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.pix())
            make.centerY.equalTo(lineView)
            make.right.equalTo(lineView)
            make.height.equalTo(38)
        }
        
        twoListView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20.pix())
            make.centerY.equalTo(lineView)
            make.left.equalTo(lineView)
            make.height.equalTo(38)
        }
        
        if languageCode == "1100" {
            scrollView.addSubview(footView)
            footView.addSubview(idFootImageView)
            
            footView.snp.makeConstraints { make in
                make.top.equalTo(cardImageView.snp.bottom).offset(15)
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize(width: 375.pix(), height: 327.pix()))
                make.bottom.equalToSuperview()
            }
            idFootImageView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(20)
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize(width: 335.pix(), height: 192.pix()))
            }
        }else {
            scrollView.addSubview(mentImageView)
            scrollView.addSubview(footView)
            footView.addSubview(oneImageView)
            footView.addSubview(twoImageView)
            
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
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OneView {
    
    @objc func applyBtnClick() {
        if let model = model {
            self.tapBlock?(model)
        }
    }
}
