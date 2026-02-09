//
//  LoginViewController.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/9.
//

import UIKit
import SnapKit

class LoginViewController: BaseViewController {
    
    lazy var loginView: LoginView = {
        let loginView = LoginView()
        return loginView
    }()
    
    private var timer: Timer?
    private var countDown = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loginView.codeListView.codeBtn.addTarget(self, action: #selector(codeBtnClick), for: .touchUpInside)
        
        loginView.sureAgreementBtn.addTarget(self, action: #selector(sureBtnClick), for: .touchUpInside)
        
        loginView.loginBtn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loginView.phoneListView.phoneFiled.becomeFirstResponder()
    }
    
    @MainActor
    deinit {
        timer?.invalidate()
    }
    
}

extension LoginViewController {
    
    @objc func codeBtnClick() {
        let phone = self.loginView.phoneListView.phoneFiled.text ?? ""
        if phone.isEmpty {
            ToastManager.showMessage(languageCode == "1100" ? "Silakan masukkan nomor telepon" : "Please enter your phone number")
            return
        }
        
        codeInfo(phone: phone)
    }
    
    private func startCountDown() {
        countDown = 60
        loginView.codeListView.codeBtn.isEnabled = false
        
        loginView.codeListView.codeBtn.setTitle("\(countDown)s", for: .disabled)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(countDownAction),
                                     userInfo: nil,
                                     repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    @objc private func countDownAction() {
        countDown -= 1
        
        if countDown <= 0 {
            endCountDown()
        } else {
            loginView.codeListView.codeBtn.setTitle("\(countDown)s", for: .disabled)
        }
    }
    
    private func endCountDown() {
        timer?.invalidate()
        timer = nil
        
        loginView.codeListView.codeBtn.isEnabled = true
        loginView.codeListView.codeBtn.setTitle(languageCode == "1100" ? "Dapatkan kode" : "Send code", for: .normal)
    }
    
    @objc func sureBtnClick() {
        loginView.sureAgreementBtn.isSelected.toggle()
    }
    
    @objc func loginBtnClick() {
        let phone = self.loginView.phoneListView.phoneFiled.text ?? ""
        if phone.isEmpty {
            ToastManager.showMessage(languageCode == "1100" ? "Silakan masukkan nomor telepon" : "Please enter your phone number")
            return
        }
        
        let code = self.loginView.codeListView.codeFiled.text ?? ""
        if code.isEmpty {
            ToastManager.showMessage(languageCode == "1100" ? "Silakan masukkan kode verifikasi" : "Please enter the verification code")
            return
        }
        
        if loginView.sureAgreementBtn.isSelected == false {
            ToastManager.showMessage(languageCode == "1100" ? "Silakan baca dan konfirmasi Kebijakan Privasi" : "Please read and confirm the Privacy Policy")
            return
        }
        
        loginInfo(phone: phone, code: code)
    }
    
    private func codeInfo(phone: String) {
        let params = ["closer": phone]
        LoadingView.shared.show()
        NetworkManager.post(url: "/patkan/still/without/calming",
                            params: params, responseType:
                                BaseModel.self) { [weak self] result in
            switch result {
            case .success(let success):
                LoadingView.shared.hide()
                let partner = success.partner ?? ""
                if ["0", "00"].contains(partner) {
                    self?.startCountDown()
                    self?.loginView.codeListView.codeFiled.becomeFirstResponder()
                }
                ToastManager.showMessage(success.reason ?? "")
                
            case .failure(_):
                LoadingView.shared.hide()
            }
        }
    }
    
    private func loginInfo(phone: String, code: String) {
        self.loginView.phoneListView.phoneFiled.resignFirstResponder()
        self.loginView.codeListView.codeFiled.resignFirstResponder()
        LoadingView.shared.show()
        let params = ["explained": phone, "contained": code]
        NetworkManager.post(url: "/patkan/natural/punctuated/surface",
                            params: params,
                            responseType: BaseModel.self) { result in
            switch result {
            case .success(let success):
                LoadingView.shared.hide()
                ToastManager.showMessage(success.reason ?? "")
                let partner = success.partner ?? ""
                if ["0", "00"].contains(partner) {
                    let phone = success.logic?.explained ?? ""
                    let token = success.logic?.complements ?? ""
                    UserSessionManager.shared.saveLoginInfo(phone: phone, token: token)
                    
                    Task {
                        try? await Task.sleep(nanoseconds: 250_000_000)
                        NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil)
                    }
                }
                
            case .failure(_):
                LoadingView.shared.hide()
            }
        }
    }
}
