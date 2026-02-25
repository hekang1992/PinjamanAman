//
//  OrderViewCell.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/11.
//

import UIKit
import SnapKit
import Kingfisher

class OrderViewCell: UITableViewCell {
    
    var model: seeModel? {
        didSet {
            guard let model = model else { return }
            let boyose = model.views?.boyose ?? ""
            
            typeLabel.text = model.views?.showWord ?? ""
            
            logoImageView.kf.setImage(with: URL(string: model.conflicts ?? ""))
            nameLabel.text = model.soften ?? ""
            
            let applyStr = model.views?.fhaeprov ?? ""
            applyBtn.setTitle(applyStr, for: .normal)
            applyBtn.isHidden = applyStr.isEmpty
            
            oneLabel.text = model.economy ?? ""
            twoLabel.text = model.materials ?? ""
            
            threeLabel.text = model.views?.provimories ?? ""
            fourLabel.text = model.views?.rejuvenation ?? ""
            
            let tips = model.views?.tip ?? ""
            tipsLabel.text = tips
            tipsView.isHidden = tips.isEmpty ? true : false
            if tips.isEmpty {
                bgView.snp.updateConstraints { make in
                    make.height.equalTo(137)
                }
            }else {
                bgView.snp.updateConstraints { make in
                    make.height.equalTo(184)
                }
            }
            
            switch boyose {
            case "yeahot":
                bgImageView.image = UIImage(named: "oc_delay_bg")
                typeImageView.image = UIImage(named: "dd_delay_ic")
                typeLabel.textColor = UIColor.init(hexString: "#F6524D")
                
            case "etymmake":
                bgImageView.image = UIImage(named: "oc_replay_bg")
                typeImageView.image = UIImage(named: "dd_replay_ic")
                typeLabel.textColor = UIColor.init(hexString: "#F67F07")
                
            case "oramesque":
                bgImageView.image = UIImage(named: "oc_apply_bg")
                typeImageView.image = UIImage(named: "dd_apply_ic")
                typeLabel.textColor = UIColor.init(hexString: "#267B3F")
                
            case "pecc":
                bgImageView.image = UIImage(named: "oc_review_bg")
                typeImageView.image = UIImage(named: "dd_review_ic")
                typeLabel.textColor = UIColor.init(hexString: "#3C90FF")
                
            case "hitose":
                bgImageView.image = UIImage(named: "oc_finish_bg")
                typeImageView.image = UIImage(named: "dd_finish_ic")
                typeLabel.textColor = UIColor.init(hexString: "#B0B4B3")
                
            default:
                break
            }
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "oc_delay_bg")
        return bgImageView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 18
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return bgView
    }()
    
    lazy var typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.textAlignment = .left
        typeLabel.textColor = UIColor.init(hexString: "#333333")
        typeLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(500))
        return typeLabel
    }()
    
    lazy var typeImageView: UIImageView = {
        let typeImageView = UIImageView()
        return typeImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 8
        logoImageView.layer.masksToBounds = true
        logoImageView.backgroundColor = .systemPink
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#333333")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(600))
        return nameLabel
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setTitleColor(.white, for: .normal)
        applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(500))
        if AppLanguageCodeManager.getLanguageCode() == "1100" {
            applyBtn.setBackgroundImage(UIImage(named: "od_td_ap_im_ac"), for: .normal)
        }else {
            applyBtn.setBackgroundImage(UIImage(named: "od_t_ap_im_ac"), for: .normal)
        }
        applyBtn.isUserInteractionEnabled = false
        return applyBtn
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.layer.cornerRadius = 2
        lineView.layer.masksToBounds = true
        lineView.backgroundColor = UIColor.init(hexString: "#F6F6F4")
        return lineView
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.textColor = UIColor.init(hexString: "#B0B4B3")
        oneLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return oneLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .right
        twoLabel.textColor = UIColor.init(hexString: "#267B3F")
        twoLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return twoLabel
    }()
    
    lazy var threeLabel: UILabel = {
        let threeLabel = UILabel()
        threeLabel.textAlignment = .left
        threeLabel.textColor = UIColor.init(hexString: "#B0B4B3")
        threeLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return threeLabel
    }()
    
    lazy var fourLabel: UILabel = {
        let fourLabel = UILabel()
        fourLabel.textAlignment = .right
        fourLabel.textColor = UIColor.init(hexString: "#203D31")
        fourLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return fourLabel
    }()
    
    lazy var tipsView: UIView = {
        let tipsView = UIView()
        tipsView.layer.cornerRadius = 16
        tipsView.layer.masksToBounds = true
        tipsView.backgroundColor = UIColor.init(hexString: "#F6F6F4")
        return tipsView
    }()
    
    lazy var tipsImageView: UIImageView = {
        let tipsImageView = UIImageView()
        tipsImageView.image = UIImage(named: "tiup_ring_image")
        return tipsImageView
    }()
    
    lazy var tipsLabel: UILabel = {
        let tipsLabel = UILabel()
        tipsLabel.textAlignment = .left
        tipsLabel.numberOfLines = 0
        tipsLabel.textColor = UIColor.init(hexString: "#F6524D")
        tipsLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return tipsLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgImageView)
        contentView.addSubview(bgView)
        
        bgImageView.addSubview(typeLabel)
        bgImageView.addSubview(typeImageView)
        
        bgView.addSubview(logoImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(applyBtn)
        bgView.addSubview(lineView)
        bgView.addSubview(oneLabel)
        bgView.addSubview(twoLabel)
        bgView.addSubview(threeLabel)
        bgView.addSubview(fourLabel)
        bgView.addSubview(tipsView)
        tipsView.addSubview(tipsImageView)
        tipsView.addSubview(tipsLabel)
        
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 64.pix()))
            make.centerX.equalToSuperview()
        }
        
        bgView.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.bottom).offset(-22)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(184)
            make.bottom.equalToSuperview().offset(-15.pix())
        }
        
        typeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15.pix())
            make.left.equalToSuperview().offset(13.pix())
            make.height.equalTo(16)
        }
        
        typeImageView.snp.makeConstraints { make in
            make.centerY.equalTo(typeLabel)
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(22)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(26)
            make.top.equalToSuperview().offset(17)
            make.left.equalToSuperview().offset(20)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(5)
            make.height.equalTo(20)
        }
        
        applyBtn.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.right.equalToSuperview().offset(-20)
            if AppLanguageCodeManager.getLanguageCode() == "1100" {
                make.size.equalTo(CGSize(width: 140.pix(), height: 36.pix()))
            }else {
                make.size.equalTo(CGSize(width: 106.pix(), height: 36.pix()))
            }
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(applyBtn.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
            make.left.equalToSuperview().offset(20)
        }
        
        oneLabel.snp.makeConstraints { make in
            make.left.equalTo(lineView)
            make.top.equalTo(lineView.snp.bottom).offset(14)
            make.height.equalTo(14)
        }
        
        twoLabel.snp.makeConstraints { make in
            make.centerY.equalTo(oneLabel)
            make.right.equalTo(lineView)
            make.height.equalTo(18)
        }
        
        threeLabel.snp.makeConstraints { make in
            make.left.equalTo(lineView)
            make.top.equalTo(oneLabel.snp.bottom).offset(14)
            make.height.equalTo(14)
        }
        
        fourLabel.snp.makeConstraints { make in
            make.centerY.equalTo(threeLabel)
            make.right.equalTo(lineView)
            make.height.equalTo(18)
        }
        tipsView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-15)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 295.pix(), height: 34))
        }
        tipsImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.left.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 10, height: 10))
        }
        tipsLabel.snp.makeConstraints { make in
            make.left.equalTo(tipsImageView.snp.right).offset(5)
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
