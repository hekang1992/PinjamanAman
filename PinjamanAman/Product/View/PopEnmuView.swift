//
//  PopEnmuView.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/10.
//

import UIKit
import SnapKit

class PopEnmuView: BaseView {

    var cancelBlock: (() -> Void)?
    var sureBlock: ((layModel) -> Void)?

    var modelArray: [layModel]? {
        didSet {
            tableView.reloadData()
        }
    }

    var selectedIndex: Int? {
        didSet {
//            guard let index = selectedIndex else { return }
//            DispatchQueue.main.async {
//                let indexPath = IndexPath(row: index, section: 0)
//                if self.tableView.numberOfRows(inSection: 0) > index {
//                    self.tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
//                }
//            }
        }
    }

    lazy var bgImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "enum_a_li_image")
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        return view
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()

    lazy var cancelBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(UIImage(named: "ale_can_ic_bg"), for: .normal)
        btn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        return btn
    }()

    lazy var sureBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle(languageCode == "1100" ? "Mengonfirmasi" : "Confirm", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        btn.setBackgroundImage(UIImage(named: "cen_log_image"), for: .normal)
        btn.addTarget(self, action: #selector(sureBtnClick), for: .touchUpInside)
        return btn
    }()

    lazy var bgView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 18
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()

    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.separatorStyle = .none
        table.backgroundColor = .white
        table.delegate = self
        table.dataSource = self
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 60
        table.showsVerticalScrollIndicator = false
        table.contentInsetAdjustmentBehavior = .never
        table.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        if #available(iOS 15.0, *) {
            table.sectionHeaderTopPadding = 0
        }
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }

    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI
extension PopEnmuView {
    private func setupUI() {
        addSubview(bgImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(bgView)
        bgView.addSubview(tableView)
        bgView.addSubview(sureBtn)
        addSubview(cancelBtn)
    }

    private func setupLayout() {
        bgImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 337.pix(), height: 458.pix()))
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }

        bgView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().offset(-12)
        }

        sureBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 280.pix(), height: 46.pix()))
        }

        cancelBtn.snp.makeConstraints {
            $0.bottom.equalTo(bgImageView.snp.top).offset(-15)
            $0.right.equalTo(bgImageView)
            $0.size.equalTo(CGSize(width: 22, height: 22))
        }

        tableView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(sureBtn.snp.top).offset(-5)
        }
    }
}

// MARK: - UITableView
extension PopEnmuView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        modelArray?.count ?? 0
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let model = modelArray?[indexPath.row]

        cell.selectionStyle = .none
        cell.textLabel?.text = model?.blend ?? ""
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = .systemFont(ofSize: 16, weight: .medium)

        let isSelected = indexPath.row == selectedIndex

        cell.textLabel?.textColor = UIColor(
            hexString: isSelected ? "#267B3F" : "#203D31"
        )

        cell.contentView.backgroundColor = isSelected ? UIColor.init(hexString: "#E6FFF5").withAlphaComponent(0.7) : .clear

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tableView.reloadData()
    }
}

// MARK: - Action
extension PopEnmuView {
    @objc func cancelBtnClick() {
        cancelBlock?()
    }

    @objc func sureBtnClick() {
        if let selectedIndex = selectedIndex, let model = self.modelArray?[selectedIndex] {
            sureBlock?(model)
        }else {
            ToastManager.showMessage(languageCode == "1100" ? "Silakan pilih salah satu opsi" : "Please select an option")
        }
    }
}
