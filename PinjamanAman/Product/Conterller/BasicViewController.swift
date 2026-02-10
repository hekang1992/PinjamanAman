//
//  BasicViewController.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/10.
//

import UIKit
import SnapKit
import TYAlertController

class BasicViewController: BaseViewController {
    
    var cardModel: smallerModel?
    var stepModel: strikeModel?
    
    var model: BaseModel?
    private var cameraPicker: SystemCameraPicker?
    
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
            self.navigationController?.popViewController(animated: true)
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
            if card == 1 {
                ToastManager.showMessage(languageCode == "1100" ? "Sertifikasi selesai" : "Certification completed")
            }else {
                self.popCardView()
            }
            //            let face = self.model?.logic?.involves?.laugh ?? 0
        }
        
        twoListView.tapBlock = { [weak self] in
            guard let self = self else { return }
            let card = self.model?.logic?.go?.laugh ?? 0
            
            if card == 1 {
                ToastManager.showMessage(languageCode == "1100" ? "Sertifikasi selesai" : "Certification completed")
            }else {
                self.popCardView()
                return
            }
            
            let face = self.model?.logic?.involves?.laugh ?? 0
            if face == 1 {
                ToastManager.showMessage(languageCode == "1100" ? "Sertifikasi selesai" : "Certification completed")
            }else {
                self.popFaceView()
                return
            }
            
        }
        
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
                self.cameraPicker = SystemCameraPicker(
                    position: .front,
                    presentVC: self
                ) { [weak self] imageData in
                    self?.uploadImage(type: "10", imageData: imageData)
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
        NetworkManager.get(url: "/patkan/brings/there/often", params: params, responseType: BaseModel.self) { result in
            switch result {
            case .success(let success):
                LoadingView.shared.hide()
                let partner = success.partner ?? ""
                if ["0", "00"].contains(partner) {
                    self.model = success
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
        let popView = PopSaveInfoView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: popView, preferredStyle: .actionSheet)
        self.present(alertVc!, animated: true)
    }
    
}

extension BasicViewController {
    
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
                    let cardModel = success.logic?.smaller ?? smallerModel()
                    self?.judgeKeysToPageVc(cardModel: cardModel, stepModel: stepModel)
                }
                
            case .failure(_):
                LoadingView.shared.hide()
            }
        }
    }
    
}
