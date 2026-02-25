//
//  BasicViewController.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/10.
//

import UIKit
import SnapKit
import TYAlertController

class BasicViewController: BaseViewController {
    
    var cardModel: smallerModel?
    var stepModel: strikeModel?
    
    var model: BaseModel?
    private var cameraPicker: SystemCameraPicker?
    private let singleLocationManager = SingleLocationService()
    
    var card_start_time: String = ""
    var card_end_time: String = ""
    
    var face_start_time: String = ""
    var face_end_time: String = ""
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.setTitle(languageCode == "1100" ? "Berikutnya" : "Next", for: .normal)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(700))
        nextBtn.setBackgroundImage(UIImage(named: "login_btn_bg_image"), for: .normal)
        nextBtn.addTarget(self, action: #selector(nextBtnClick), for: .touchUpInside)
        return nextBtn
    }()
    
    lazy var descImageView: UIImageView = {
        let descImageView = UIImageView()
        descImageView.image = languageCode == "1100" ? UIImage(named: "stip_id_one_image") : UIImage(named: "stip_en_one_image")
        return descImageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var oneListView: BasicListView = {
        let oneListView = BasicListView()
        oneListView.logoImageView.image = UIImage(named: "cad_af_ic")
        oneListView.bgImageView.image = UIImage(named: "card_list_yn")
        oneListView.nameLabel.text = languageCode == "1100" ? "Tampak depan ktp" : "ID Card"
        oneListView.descLabel.text = languageCode == "1100" ? "Harap kirimkan foto Anda sesuai dengan contoh untuk menghindari gambar buram, halangan, dan pantulan." : "Please submit your photos according to the example to avoid blurriness, obstructions, and reflections."
        return oneListView
    }()
    
    lazy var twoListView: BasicListView = {
        let twoListView = BasicListView()
        twoListView.logoImageView.image = UIImage(named: "face_f_ic")
        twoListView.bgImageView.image = UIImage(named: "id_card_list_yn")
        twoListView.nameLabel.text = languageCode == "1100" ? "Foto depan" : "Face"
        twoListView.descLabel.text = languageCode == "1100" ? "Harap kirimkan foto Anda sesuai dengan contoh untuk menghindari gambar buram, halangan, dan pantulan." : "Please submit your photos according to the example to avoid blurriness, obstructions, and reflections."
        return twoListView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(450.pix())
        }
        
        
        view.addSubview(headView)
        headView.nameLabel.text = stepModel?.strain ?? ""
        headView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.popWlView()
        }
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 295.pix(), height: 50.pix()))
        }
        
        view.addSubview(descImageView)
        descImageView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(15)
            make.left.right.equalToSuperview()
            make.height.equalTo(85.pix())
        }
        
        view.addSubview(footView)
        footView.snp.makeConstraints { make in
            make.bottom.equalTo(nextBtn.snp.top)
            make.left.right.equalToSuperview()
            make.top.equalTo(descImageView.snp.bottom).offset(-15)
        }
        
        footView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(oneListView)
        scrollView.addSubview(twoListView)
        
        oneListView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 258.pix()))
        }
        
        twoListView.snp.makeConstraints { make in
            make.top.equalTo(oneListView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 258.pix()))
            make.bottom.equalToSuperview().offset(-20.pix())
        }
        
        oneListView.tapBlock = { [weak self] in
            guard let self = self else { return }
            let card = self.model?.logic?.go?.laugh ?? 0
            let face = self.model?.logic?.involves?.laugh ?? 0
            if card == 1 && face == 0 {
                self.popFaceView()
//                ToastManager.showMessage(languageCode == "1100" ? "Sertifikasi selesai" : "Certification completed")
            }else if card == 0 {
                self.popCardView()
            }
            //            let face = self.model?.logic?.involves?.laugh ?? 0
        }
        
        twoListView.tapBlock = { [weak self] in
            guard let self = self else { return }
            let card = self.model?.logic?.go?.laugh ?? 0
            
            if card == 1 {
//                ToastManager.showMessage(languageCode == "1100" ? "Sertifikasi selesai" : "Certification completed")
            }else {
                self.popCardView()
                return
            }
            
            let face = self.model?.logic?.involves?.laugh ?? 0
            if face == 1 {
//                ToastManager.showMessage(languageCode == "1100" ? "Sertifikasi selesai" : "Certification completed")
            }else {
                self.popFaceView()
                return
            }
            
        }
        
        singleLocationManager.requestCurrentLocation { result in
            
        }
        
        card_start_time = String(Int(Date().timeIntervalSince1970))
        
        getBasicInfo()
    }
    
}

extension BasicViewController {
    
    @objc func nextBtnClick() {
        let card = self.model?.logic?.go?.laugh ?? 0
        if card == 1 {
        }else {
            self.popCardView()
            return
        }
        
        let face = self.model?.logic?.involves?.laugh ?? 0
        if face == 1 {
        }else {
            self.popFaceView()
            return
        }
        
        self.clickDescInfo()
    }
}

extension BasicViewController {
    
    private func popCardView() {
        let popView = PopAlertFaceView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        popView.cancelBlock = { [weak self] in
            self?.dismiss(animated: true)
        }
        popView.sureBlock = { [weak self] in
            self?.dismiss(animated: true) { [weak self] in
                guard let self = self else { return }
                self.cameraPicker = SystemCameraPicker(
                    position: .back,
                    presentVC: self
                ) { [weak self] imageData in
                    self?.uploadImage(type: "11", imageData: imageData)
                }
                cameraPicker?.presentCamera()
            }
        }
    }
    
    private func popFaceView() {
        face_start_time = String(Int(Date().timeIntervalSince1970))
        let popView = PopAlertFaceView(frame: self.view.bounds)
        popView.bgImageView.image = languageCode == "1100" ? UIImage(named: "fac_id_a_c_image") : UIImage(named: "fac_en_a_c_image")
        let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        
        popView.cancelBlock = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        popView.sureBlock = { [weak self] in
            self?.dismiss(animated: true) { [weak self] in
                guard let self = self else { return }
                face_end_time = String(Int(Date().timeIntervalSince1970))
                self.cameraPicker = SystemCameraPicker(
                    position: .front,
                    presentVC: self
                ) { [weak self] imageData in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        self?.uploadImage(type: "10", imageData: imageData)
                    }
                }
                cameraPicker?.presentCamera()
            }
        }
    }
    
}

extension BasicViewController {
    
    private func getBasicInfo() {
        LoadingView.shared.show()
        let params = ["transform": self.cardModel?.opening ?? ""]
        NetworkManager.get(url: "/patkan/brings/there/often", params: params, responseType: BaseModel.self) { [weak self] result in
            switch result {
            case .success(let success):
                LoadingView.shared.hide()
                let partner = success.partner ?? ""
                if ["0", "00"].contains(partner) {
                    self?.model = success
                    
                    let card = success.logic?.go?.laugh ?? 0
                    if card == 1 {
                        self?.oneListView.cameraImageView.image = UIImage(named: "cpxq_dh_ic")
                    }
                    
                    let face = success.logic?.involves?.laugh ?? 0
                    if face == 1 {
                        self?.twoListView.cameraImageView.image = UIImage(named: "cpxq_dh_ic")
                    }
                    
                }
            case .failure(_):
                LoadingView.shared.hide()
            }
        }
    }
    
    private func uploadImage(type: String, imageData: Data) {
        let paras = ["acceptance": type,
                     "unsettling": "2",
                     "exciting": "",
                     "adapting": "1"]
        LoadingView.shared.show()
        NetworkManager.post(url: "/patkan/greatest/chaos/confide",
                            params: paras,
                            imageData: imageData,
                            responseType: BaseModel.self) { [weak self] result in
            switch result {
            case .success(let success):
                LoadingView.shared.hide()
                let partner = success.partner ?? ""
                if ["0", "00"].contains(partner) {
                    if type == "11" {
                        self?.saveNameInfo(model: success)
                    }else {
                        self?.clickDescInfo()
                        Task {
                            try? await Task.sleep(nanoseconds: 3_000_000_000)
                            await self?.lycOtherCocelleInfo(type: "3",
                                                            orderID: self?.cardModel?.good ?? "",
                                                            productID: self?.cardModel?.opening ?? "",
                                                            onetime: self?.face_start_time ?? "",
                                                            twotime: self?.face_end_time ?? "")
                        }
                    }
                }else {
                    ToastManager.showMessage(success.reason ?? "")
                }
            case .failure(_):
                LoadingView.shared.hide()
            }
        }
    }
    
    private func saveNameInfo(model: BaseModel) {
        card_end_time = String(Int(Date().timeIntervalSince1970))
        let popView = PopSaveInfoView(frame: self.view.bounds)
        popView.model = model
        let alertVc = TYAlertController(alert: popView, preferredStyle: .actionSheet)
        self.present(alertVc!, animated: true)
        
        popView.cancelBlock = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        popView.saveBlock = { [weak self] in
            let name = popView.oneFiled.text ?? ""
            let idNum = popView.twoFiled.text ?? ""
            let time = popView.threeFiled.text ?? ""
            
            if name.isEmpty || time == "//" {
                ToastManager.showMessage(AppLanguageCodeManager.getLanguageCode() == "1100" ? "Nama tidak boleh kosong" : "Name cannot be empty")
                return
            }
            
            if idNum.isEmpty || time == "//" {
                ToastManager.showMessage(AppLanguageCodeManager.getLanguageCode() == "1100" ? "Nomor KTP tidak boleh kosong" : "ID number cannot be empty")
                return
            }
            
            if time.isEmpty || time == "//" {
                ToastManager.showMessage(AppLanguageCodeManager.getLanguageCode() == "1100" ? "Tanggal lahir tidak boleh kosong" : "Birthday cannot be empty")
                return
            }
            
            let orderID = self?.cardModel?.good ?? ""
            var paras = ["blend": name,
                         "thinking": idNum,
                         "old": time,
                         "reevaluate": orderID,
                         "beliefs": UserSessionManager.shared.phone ?? "",
                         "transform": self?.cardModel?.opening ?? ""]
            
            if self?.languageCode == "1105" {
                paras["acceptance"] = "11"
            }
            
            self?.saveName(paras: paras)
        }
    }
    
}

extension BasicViewController {
    
    private func saveName(paras: [String: String]) {
        LoadingView.shared.show()
        
        var pageUrl = ""
        if languageCode == "1100" {
            pageUrl = "/patkan/doing/deeply/force"
        }else {
            pageUrl = "/patkan/fleeing/discussing/where"
        }
        
        NetworkManager.post(url: pageUrl, params: paras, responseType: BaseModel.self) { [weak self] result in
            switch result {
            case .success(let success):
                LoadingView.shared.hide()
                let partner = success.partner ?? ""
                if ["0", "00"].contains(partner) {
                    self?.dismiss(animated: true)
                    self?.getBasicInfo()
                    
                    Task {
                        try? await Task.sleep(nanoseconds: 3_000_000_000)
                        await self?.lycOtherCocelleInfo(type: "2",
                                                        orderID: self?.cardModel?.good ?? "",
                                                        productID: self?.cardModel?.opening ?? "",
                                                        onetime: self?.card_start_time ?? "",
                                                        twotime: self?.card_end_time ?? "")
                    }
                    
                    
                }else {
                    ToastManager.showMessage(success.reason ?? "")
                }
            case .failure(_):
                LoadingView.shared.hide()
            }
        }
    }
    
    private func clickDescInfo() {
        LoadingView.shared.show()
        let productID = cardModel?.opening ?? ""
        let params = ["transform": productID, "revel": "1"]
        NetworkManager.post(url: "/patkan/growth/achieve", params: params, responseType: BaseModel.self) { [weak self] result in
            switch result {
            case .success(let success):
                LoadingView.shared.hide()
                let partner = success.partner ?? ""
                if ["0", "00"].contains(partner) {
                    let stepModel = success.logic?.achievements ?? strikeModel()
                    if let cardModel = success.logic?.smaller {
                        self?.judgeKeysToPageVc(cardModel: cardModel, stepModel: stepModel)
                    }
                }
                
            case .failure(_):
                LoadingView.shared.hide()
            }
        }
    }
    
}

extension BasicViewController {
    
    private func popWlView() {
        let popView = AppWlView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        
        popView.cancelBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        popView.confirmBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
            self.toTargetVc()
        }
    }
    
}
