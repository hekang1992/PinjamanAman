//
//  PopSaveInfoView.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/10.
//

import UIKit
import SnapKit
import BRPickerView

class PopSaveInfoView: BaseView {
    
    var model: BaseModel? {
        didSet {
            guard let model = model else { return }
            oneFiled.text = model.logic?.blend ?? ""
            twoFiled.text = model.logic?.thinking ?? ""
            threeFiled.text = model.logic?.old ?? ""
        }
    }
    
    var cancelBlock: (() -> Void)?
    
    var saveBlock: (() -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "comsa_ve_image")
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
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setTitleColor(.white, for: .normal)
        applyBtn.setTitle(languageCode == "1100" ? "Mengonfirmasi" : "Confirm", for: .normal)
        applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(700))
        applyBtn.setBackgroundImage(UIImage(named: "cen_log_image"), for: .normal)
        applyBtn.addTarget(self, action: #selector(applyBtnClick), for: .touchUpInside)
        return applyBtn
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 18
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return bgView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.text = languageCode == "1100" ? "Verifikasi informasi identitas" : "Verify identity information"
        nameLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(700))
        return nameLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.numberOfLines = 0
        descLabel.textAlignment = .center
        descLabel.text = languageCode == "1100" ? "*Mohon periksa kembali informasi lD Anda dengan benar, jika sudah terkirim tidak akan diubah lagi" : "*Please check your lD information correctly, oncesubmitted it is not changed again"
        descLabel.textColor = UIColor.init(hexString: "#F6524D")
        descLabel.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        return descLabel
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        oneBtn.setTitle(languageCode == "1100" ? "Nama sesuai KTP" : "Real name", for: .normal)
        oneBtn.setTitleColor(UIColor.init(hexString: "#B0B4B3"), for: .normal)
        oneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        oneBtn.setImage(UIImage(named: "cc_one_image"), for: .normal)
        oneBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        oneBtn.titleLabel?.textAlignment = .left
        return oneBtn
    }()
    
    lazy var oneFiled: UITextField = {
        let oneFiled = UITextField()
        oneFiled.placeholder = languageCode == "1100" ? "Nama sesuai KTP" : "Real name"
        oneFiled.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(600))
        oneFiled.textColor = UIColor.init(hexString: "#203D31")
        return oneFiled
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.layer.cornerRadius = 2
        lineView.layer.masksToBounds = true
        lineView.backgroundColor = UIColor.init(hexString: "#B0B4B3")
        return lineView
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.setTitle(languageCode == "1100" ? "Nomor KTP" : "ID number", for: .normal)
        twoBtn.setTitleColor(UIColor.init(hexString: "#B0B4B3"), for: .normal)
        twoBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        twoBtn.setImage(UIImage(named: "cc_two_image"), for: .normal)
        twoBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        twoBtn.titleLabel?.textAlignment = .left
        return twoBtn
    }()
    
    lazy var twoFiled: UITextField = {
        let twoFiled = UITextField()
        twoFiled.placeholder = languageCode == "1100" ? "Nomor KTP" : "ID number"
        twoFiled.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(600))
        twoFiled.textColor = UIColor.init(hexString: "#203D31")
        return twoFiled
    }()
    
    lazy var tlineView: UIView = {
        let tlineView = UIView()
        tlineView.layer.cornerRadius = 2
        tlineView.layer.masksToBounds = true
        tlineView.backgroundColor = UIColor.init(hexString: "#B0B4B3")
        return tlineView
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton(type: .custom)
        threeBtn.setTitle(languageCode == "1100" ? "Ulang tahun" : "Birthday", for: .normal)
        threeBtn.setTitleColor(UIColor.init(hexString: "#B0B4B3"), for: .normal)
        threeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        threeBtn.setImage(UIImage(named: "cc_three_image"), for: .normal)
        threeBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        threeBtn.titleLabel?.textAlignment = .left
        return threeBtn
    }()
    
    lazy var threeFiled: UITextField = {
        let threeFiled = UITextField()
        threeFiled.isEnabled = false
        threeFiled.placeholder = languageCode == "1100" ? "Ulang tahun" : "Birthday"
        threeFiled.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(600))
        threeFiled.textColor = UIColor.init(hexString: "#203D31")
        return threeFiled
    }()
    
    lazy var tclineView: UIView = {
        let tclineView = UIView()
        tclineView.layer.cornerRadius = 2
        tclineView.layer.masksToBounds = true
        tclineView.backgroundColor = UIColor.init(hexString: "#B0B4B3")
        return tclineView
    }()
    
    lazy var arrowImageView: UIImageView = {
        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage(named: "right_ac_liamge")
        return arrowImageView
    }()
    
    lazy var tapTimeBtn: UIButton = {
        let tapTimeBtn = UIButton(type: .custom)
        tapTimeBtn.addTarget(self, action: #selector(tapTimeBtnClick), for: .touchUpInside)
        return tapTimeBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bgImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(bgView)
        bgView.addSubview(descLabel)
        bgView.addSubview(applyBtn)
        
        bgView.addSubview(oneBtn)
        bgView.addSubview(oneFiled)
        bgView.addSubview(lineView)
        
        bgView.addSubview(twoBtn)
        bgView.addSubview(twoFiled)
        bgView.addSubview(tlineView)
        
        bgView.addSubview(threeBtn)
        bgView.addSubview(threeFiled)
        bgView.addSubview(tclineView)
        
        bgView.addSubview(arrowImageView)
        bgView.addSubview(tapTimeBtn)
        
        addSubview(cancelBtn)
        
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 337.pix(), height: 458.pix()))
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.bottom.equalTo(bgImageView.snp.top).offset(-15)
            make.right.equalTo(bgImageView)
            make.width.height.equalTo(22)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        
        bgView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 311.pix(), height: 394.pix()))
        }
        
        descLabel.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 270.pix(), height: 30.pix()))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
        }
        
        applyBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(descLabel.snp.top).offset(-12)
            make.size.equalTo(CGSize(width: 280.pix(), height: 46.pix()))
        }
        
        oneBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(23)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(14)
            make.width.equalTo(130)
        }
        
        oneFiled.snp.makeConstraints { make in
            make.top.equalTo(oneBtn.snp.bottom)
            make.left.equalTo(oneBtn)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        lineView.snp.makeConstraints { make in
            make.left.bottom.right.equalTo(oneFiled)
            make.height.equalTo(1)
        }
        
        twoBtn.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(14)
            make.width.equalTo(100)
        }
        
        twoFiled.snp.makeConstraints { make in
            make.top.equalTo(twoBtn.snp.bottom)
            make.left.equalTo(oneBtn)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tlineView.snp.makeConstraints { make in
            make.left.bottom.right.equalTo(twoFiled)
            make.height.equalTo(1)
        }
        
        threeBtn.snp.makeConstraints { make in
            make.top.equalTo(tlineView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(14)
            make.width.equalTo(100)
        }
        
        threeFiled.snp.makeConstraints { make in
            make.top.equalTo(threeBtn.snp.bottom)
            make.left.equalTo(oneBtn)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tclineView.snp.makeConstraints { make in
            make.left.bottom.right.equalTo(threeFiled)
            make.height.equalTo(1)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalTo(threeFiled)
            make.right.equalToSuperview().offset(-32)
            make.size.equalTo(CGSize(width: 14, height: 12))
        }
        
        tapTimeBtn.snp.makeConstraints { make in
            make.top.equalTo(threeBtn.snp.bottom)
            make.left.equalTo(oneBtn)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PopSaveInfoView {
    
    @objc func cancelBtnClick() {
        self.cancelBlock?()
    }
    
    @objc func applyBtnClick() {
        self.saveBlock?()
    }
    
    @objc func tapTimeBtnClick() {
        tapTimeClick(dateTx: threeFiled)
    }
    
    private func tapTimeClick(dateTx: UITextField) {
        let selectedDate = parseDate(from: dateTx.text)
        showDatePicker(for: dateTx, with: selectedDate)
    }
    
    private func showDatePicker(for dateTx: UITextField, with selectedDate: Date) {
        let datePickerView = BRDatePickerView()
        datePickerView.pickerMode = .YMD
        datePickerView.title = languageCode == "1100" ? "Pemilihan tanggal" : "Date selection"
        datePickerView.selectDate = selectedDate
        datePickerView.pickerStyle = createPickerStyle()
        
        datePickerView.resultBlock = { [weak self] selectedDate, _ in
            self?.updateTime(dateTx: dateTx, with: selectedDate)
        }
        
        datePickerView.show()
    }
    
    private func parseDate(from timeString: String?) -> Date {
        guard let timeString = timeString, !timeString.isEmpty else {
            return defaultDate()
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: timeString) ?? defaultDate()
    }
    
    private func defaultDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: "01/01/1990") ?? Date()
    }
    
    private func createPickerStyle() -> BRPickerStyle {
        let style = BRPickerStyle()
        style.rowHeight = 46
        style.language = "en"
        style.doneBtnTitle = languageCode == "1100" ? "OKE" : "OK"
        style.cancelBtnTitle = languageCode == "1100" ? "Batal" : "Cancel"
        style.doneTextColor = UIColor(hexString: "#203D31")
        style.selectRowTextColor = UIColor(hexString: "#203D31")
        style.pickerTextFont = UIFont.systemFont(ofSize: 16.pix(), weight: .bold)
        style.selectRowTextFont = UIFont.systemFont(ofSize: 16.pix(), weight: .bold)
        return style
    }
    
    private func updateTime(dateTx: UITextField, with date: Date?) {
        guard let date = date else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateTx.text = dateFormatter.string(from: date)
    }
    
    
}
