//
//  OrderViewController 2.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/10.
//

import UIKit
import SnapKit
import MJRefresh

class OrderViewController: BaseViewController {
    
    private let buttonenTitles = ["All", "In progress", "Repayment", "Finished"]
    private let buttonidTitles = ["Semua", "Dalam proses", "Belum lunas", "Lunas"]
    private var currentSelectedIndex = 0
    private var type: String = "4"
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "center_bg_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = languageCode == "1100" ? "Pesanan" : "Bills"
        nameLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return nameLabel
    }()
    
    lazy var coverView: UIView = {
        let coverView = UIView()
        return coverView
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var indicatorContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var indicatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "oc_d_fo_im_age")
        return imageView
    }()
    
    private var buttons: [UIButton] = []
    
    private var modelArray: [seeModel] = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(OrderViewCell.self, forCellReuseIdentifier: "OrderViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    lazy var emptyView: OrderEmptyView = {
        let emptyView = OrderEmptyView()
        emptyView.isHidden = true
        return emptyView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDefaultSelection()
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            self.orderListInfo()
        })
    }
    
    private func setupUI() {
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(450.pix())
        }
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(13)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(18)
        }
        
        view.addSubview(coverView)
        coverView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(13)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        coverView.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        if languageCode == "1100" {
            for (index, title) in buttonidTitles.enumerated() {
                let button = createButton(title: title, tag: index)
                buttons.append(button)
                buttonStackView.addArrangedSubview(button)
            }
        }else {
            for (index, title) in buttonenTitles.enumerated() {
                let button = createButton(title: title, tag: index)
                buttons.append(button)
                buttonStackView.addArrangedSubview(button)
            }
        }
        
        coverView.addSubview(indicatorContainerView)
        indicatorContainerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(2)
        }
        
        indicatorContainerView.addSubview(indicatorImageView)
        updateIndicatorPosition()
        
        view.addSubview(footView)
        footView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.top.equalTo(coverView.snp.bottom).offset(1)
        }
        
        footView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        footView.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        emptyView.applyBtnBlock = {
            NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil)
        }
    }
    
    private func createButton(title: String, tag: Int) -> UIButton {
        let button = UIButton(type: .custom)
        button.tag = tag
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.init(hexString: "#B2EAC5"), for: .normal)
        button.setTitleColor(UIColor.init(hexString: "#FFFFFF"), for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    private func setupDefaultSelection() {
        guard let firstButton = buttons.first else { return }
        selectButton(firstButton)
        currentSelectedIndex = 0
    }
    
    private func selectButton(_ button: UIButton) {
        buttons.forEach { $0.isSelected = false }
        button.isSelected = true
        currentSelectedIndex = button.tag
        updateIndicatorPosition()
    }
    
    private func updateIndicatorPosition() {
        guard buttons.count > currentSelectedIndex else { return }
        let buttonWidth = coverView.frame.width / CGFloat(buttons.count)
        let indicatorX = (CGFloat(currentSelectedIndex) * buttonWidth) + (buttonWidth / 2)
        UIView.animate(withDuration: 0.25) {
            self.indicatorImageView.snp.remakeConstraints { make in
                make.centerX.equalToSuperview().offset(indicatorX - (self.indicatorContainerView.frame.width / 2))
                make.centerY.equalToSuperview()
                make.width.equalTo(12)
                make.height.equalTo(6)
            }
            self.indicatorContainerView.layoutIfNeeded()
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard sender.tag != currentSelectedIndex else { return }
        selectButton(sender)
        switch sender.tag {
        case 0:
            self.type = "4"
            
        case 1:
            self.type = "7"
            
        case 2:
            self.type = "6"
            
        case 3:
            self.type = "5"
            
        default:
            break
        }
        orderListInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        orderListInfo()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        DispatchQueue.main.async {
            self.updateIndicatorPosition()
        }
    }
}

extension OrderViewController {
    
    private func orderListInfo() {
        LoadingView.shared.show()
        let params = ["overshadowed": type,
                      "around": "1",
                      "millions": "55"]
        NetworkManager.post(url: "/patkan/greenery/while/lives",
                            params: params,
                            responseType: BaseModel.self) { [weak self] result in
            switch result {
            case .success(let success):
                LoadingView.shared.hide()
                let partner = success.partner ?? ""
                if ["0", "00"].contains(partner) {
                    let modelArray = success.logic?.see ?? []
                    self?.modelArray = modelArray
                    self?.tableView.reloadData()
                    if modelArray.isEmpty {
                        self?.tableView.isHidden = true
                        self?.emptyView.isHidden = false
                    }else {
                        self?.tableView.isHidden = false
                        self?.emptyView.isHidden = true
                    }
                }else {
                    self?.tableView.isHidden = true
                    self?.emptyView.isHidden = false
                }
                self?.tableView.mj_header?.endRefreshing()
            case .failure(_):
                LoadingView.shared.hide()
                self?.tableView.mj_header?.endRefreshing()
                self?.tableView.isHidden = true
                self?.emptyView.isHidden = false
            }
        }
    }
    
}

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderViewCell", for: indexPath) as! OrderViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        let model = self.modelArray[indexPath.row]
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.modelArray[indexPath.row]
        let pageUrl = model.chaos ?? ""
        if pageUrl.contains(scheme_url) {
            DeepLinkNavigator.navigate(to: pageUrl, from: self)
        }else if pageUrl.contains("http") {
            self.goH5WebVc(pageUrl: pageUrl)
        }
    }
}
