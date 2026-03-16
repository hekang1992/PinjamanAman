//
//  LoginViewController.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/9.
//

import UIKit
import SnapKit
import FBSDKCoreKit
import AppTrackingTransparency

class LoginViewController: BaseViewController {
    
    lazy var loginView: LoginView = {
        let loginView = LoginView()
        return loginView
    }()
    
    private var timer: Timer?
    
    private var countDown = 60
    
    private let singleLocationManager = SingleLocationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loginView.codeListView.codeBtn.addTarget(self, action: #selector(codeBtnClick), for: .touchUpInside)
        
        loginView.sureAgreementBtn.addTarget(self, action: #selector(sureBtnClick), for: .touchUpInside)
        
        loginView.loginBtn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
        
        UserDefaults.standard.set(String(Int(Date().timeIntervalSince1970)), forKey: "start_time")
        UserDefaults.standard.synchronize()
        
        loginView.ablock = { [weak self] in
            guard let self = self else { return }
            let pageUrl = h5_url + "/resonatesDeep"
            self.goH5WebVc(pageUrl: pageUrl)
        }
        
        loginView.backblock = { [weak self] in
            self?.dismiss(animated: true)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loginView.phoneListView.phoneFiled.becomeFirstResponder()
        
        Task{
            try? await Task.sleep(nanoseconds: 800_000_000)
            singleLocationManager.requestCurrentLocation { _ in }
        }
        
//        let phone = self.loginView.phoneListView.phoneFiled.text ?? ""
//        
//        if phone.isEmpty {
//            
//            Task{
//                try? await Task.sleep(nanoseconds: 1_000_000_000)
//                await self.requestIDFAPermission()
//            }
//            
//        }
        
    }
    
    @MainActor
    deinit {
        timer?.invalidate()
    }
    
}

extension LoginViewController {
    
//    private func requestIDFAPermission() async {
//        
//        guard #available(iOS 14, *) else { return }
//        
//        let status = await ATTrackingManager.requestTrackingAuthorization()
//        
//        switch status {
//        case .authorized, .denied, .notDetermined:
//            await uploadIDFAInfo()
//            
//        case .restricted:
//            break
//            
//        @unknown default:
//            break
//        }
//        
//    }
//    
//    private func uploadIDFAInfo() async {
//        let params = ["shade": AppIdentifierManager.getIDFV(),
//                      "respiration": AppIdentifierManager.getIDFA() ?? ""]
//        NetworkManager.post(url: "/patkan/sophistication/especially/dream",
//                            params: params,
//                            responseType: BaseModel.self) { [weak self] result in
//            switch result {
//            case .success(let success):
//                let partner = success.partner ?? ""
//                if ["0", "00"].contains(partner) {
//                    self?.configureFacebookSDK(with: success.logic?.analysisability ?? analysisabilityModel())
//                }
//            case .failure(_):
//                break
//            }
//        }
//    }
    
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
        
        UserDefaults.standard.set(String(Int(Date().timeIntervalSince1970)), forKey: "end_time")
        UserDefaults.standard.synchronize()
        
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
                    
                    let onetime = UserDefaults.standard.object(forKey: "start_time") as? String ?? ""
                    let twotime = UserDefaults.standard.object(forKey: "end_time") as? String ?? ""
                    
                    if !onetime.isEmpty && !twotime.isEmpty {
                        Task {
                            self.lycCocelleInfo(type: "1",
                                                orderID: "",
                                                productID: "",
                                                onetime: onetime,
                                                twotime: twotime)
                        }
                    }
                    
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

extension LoginViewController {
    
    private func lycCocelleInfo(type: String,
                                orderID: String,
                                productID: String,
                                onetime: String,
                                twotime: String) {
        let reminder = LocationInfoStorage.storedLongitude
        let order = LocationInfoStorage.storedLatitude
        let params = ["food": type,
                      "good": orderID,
                      "possessions": productID,
                      "entire": AppIdentifierManager.getIDFV(),
                      "foundation": AppIdentifierManager.getIDFA() ?? "",
                      "plant": onetime,
                      "sustains": twotime,
                      "reminder": reminder,
                      "order": order]
        NetworkManager.post(url: "/patkan/overwhelming/nostalgia/signs",
                            params: params,
                            responseType: BaseModel.self) { result in
            switch result {
            case .success(let success):
                let partner = success.partner ?? ""
                if ["0","00"].contains(partner) {
                    UserDefaults.standard.removeObject(forKey: "start_time")
                    UserDefaults.standard.removeObject(forKey: "end_time")
                }
                
            case .failure(_):
                break
            }
        }
    }
    
//    func configureFacebookSDK(with model: analysisabilityModel) {
//        Settings.shared.displayName = model.cur ?? ""
//        Settings.shared.appURLSchemeSuffix = model.walkety ?? ""
//        Settings.shared.appID = model.shortster ?? ""
//        Settings.shared.clientToken = model.middleee ?? ""
//        
//        ApplicationDelegate.shared.application(
//            UIApplication.shared,
//            didFinishLaunchingWithOptions: nil
//        )
//    }
    
}
