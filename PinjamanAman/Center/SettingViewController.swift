//
//  SettingViewController.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/9.
//

import UIKit
import SnapKit
import TYAlertController

class SettingViewController: BaseViewController {
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "cen_logo_image")
        return logoImageView
    }()
    
    lazy var logoutBtn: UIButton = {
        let logoutBtn = UIButton(type: .custom)
        logoutBtn.setTitle(languageCode == "1100" ? "Keluar" : "Log out", for: .normal)
        logoutBtn.setTitleColor(.white, for: .normal)
        logoutBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(600))
        logoutBtn.setBackgroundImage(UIImage(named: "cen_log_image"), for: .normal)
        logoutBtn.addTarget(self, action: #selector(logoutBtnClick), for: .touchUpInside)
        return logoutBtn
    }()
    
    lazy var deleteBtn: UIButton = {
        let deleteBtn = UIButton(type: .custom)
        deleteBtn.setTitle("Delete account", for: .normal)
        deleteBtn.setTitleColor(UIColor.init(hexString: "#B0B4B3"), for: .normal)
        deleteBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(600))
        deleteBtn.setBackgroundImage(UIImage(named: "del_log_image"), for: .normal)
        deleteBtn.addTarget(self, action: #selector(deleteBtnClick), for: .touchUpInside)
        deleteBtn.isHidden = languageCode == "1100" ? true : false
        return deleteBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.leading.right.equalToSuperview()
            make.height.equalTo(400)
        }
        
        view.addSubview(headView)
        headView.nameLabel.text = languageCode == "1100" ? "Pengaturan" : "Set up"
        headView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
        
        view.addSubview(footView)
        footView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(15)
        }
        
        footView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(84)
            make.top.equalToSuperview().offset(40)
        }
        
        let listView = UIView()
        listView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        listView.layer.cornerRadius = 18
        listView.layer.masksToBounds = true
        footView.addSubview(listView)
        listView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).offset(30)
            make.size.equalTo(CGSize(width: 335.pix(), height: 55.pix()))
        }
        
        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage(named: "cen_cc_image")
        
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = languageCode == "1100" ? "Versi" : "Version"
        nameLabel.textColor = UIColor.init(hexString: "#203D31")
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        
        let versionLabel = UILabel()
        versionLabel.textAlignment = .right
        versionLabel.text = "1.0.0"
        versionLabel.textColor = UIColor.init(hexString: "#B0B4B3")
        versionLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(500))
        
        
        listView.addSubview(arrowImageView)
        listView.addSubview(nameLabel)
        listView.addSubview(versionLabel)
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 18, height: 19))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(arrowImageView.snp.right).offset(8)
            make.centerY.equalToSuperview()
        }
        
        versionLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
        
        footView.addSubview(logoutBtn)
        footView.addSubview(deleteBtn)
        
        logoutBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(listView.snp.bottom).offset(29)
            make.size.equalTo(CGSize(width: 280.pix(), height: 46.pix()))
        }
        
        deleteBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoutBtn.snp.bottom).offset(24)
            make.size.equalTo(CGSize(width: 280.pix(), height: 46.pix()))
        }
        
    }
    
}

extension SettingViewController {
    
    @objc func logoutBtnClick() {
        let popView = AppLogoutView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        
        popView.cancelBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        popView.confirmBlock = { [weak self] in
            guard let self = self else { return }
            LoadingView.shared.show()
            NetworkManager.get(url: "/patkan/enriching/responses/views", responseType: BaseModel.self) { [weak self] result in
                switch result {
                case .success(let success):
                    LoadingView.shared.hide()
                    ToastManager.showMessage(success.reason ?? "")
                    let partner = success.partner ?? ""
                    if ["0", "00"].contains(partner) {
                        self?.dismiss(animated: true)
                        UserSessionManager.shared.clearLoginInfo()
                        Task {
                            try? await Task.sleep(nanoseconds: 500_000_000)
                            NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil)
                        }
                    }
                case .failure(_):
                    LoadingView.shared.hide()
                }
            }
        }
    }
    
    @objc func deleteBtnClick() {
        let popView = AppCancelView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        
        popView.cancelBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        popView.confirmBlock = { [weak self] in
            guard let self = self else { return }
            if popView.sureAgreementBtn.isSelected == false {
                ToastManager.showMessage("Please read and agree to the above")
                return
            }
            
            LoadingView.shared.show()
            NetworkManager.get(url: "/patkan/learn/bonds/allow", responseType: BaseModel.self) { [weak self] result in
                switch result {
                case .success(let success):
                    LoadingView.shared.hide()
                    ToastManager.showMessage(success.reason ?? "")
                    let partner = success.partner ?? ""
                    if ["0", "00"].contains(partner) {
                        self?.dismiss(animated: true)
                        UserSessionManager.shared.clearLoginInfo()
                        Task {
                            try? await Task.sleep(nanoseconds: 500_000_000)
                            NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil)
                        }
                    }
                case .failure(_):
                    LoadingView.shared.hide()
                }
            }
        }
    }
    
}
