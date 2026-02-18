//
//  TwoViewCell.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/11.
//

import UIKit
import SnapKit
import FSPagerView

class TwoViewCell: UITableViewCell {

    var tapBlock: ((forgivenessModel) -> Void)?

    var modelArray: [forgivenessModel]? {
        didSet {
            pagerView.reloadData()
        }
    }

    private lazy var bgView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(hexString: "#2D8847")
        return view
    }()

    private lazy var ringImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "h_ring_a_image")
        return imageView
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Memeriksa"
        label.textColor = UIColor(hexString: "#267B3F")
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.backgroundColor = .white
        label.layer.cornerRadius = 13
        label.layer.masksToBounds = true
        return label
    }()

    private lazy var pagerView: FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(CustomPagerCell.self, forCellWithReuseIdentifier: "CustomPagerCell")
        pagerView.interitemSpacing = 5
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.isInfinite = true
        pagerView.automaticSlidingInterval = 3.0
        pagerView.backgroundColor = .clear
        pagerView.layer.borderWidth = 0
        return pagerView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        pagerView.scrollToItem(at: 0, animated: false)
    }

    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none

        contentView.addSubview(bgView)
        bgView.addSubview(ringImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(pagerView)
    }

    private func setupConstraints() {

        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(86.pix())
        }

        ringImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(5)
            make.width.height.equalTo(30)
        }

        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-12)
            make.size.equalTo(CGSize(width: 80, height: 26))
        }

        pagerView.snp.makeConstraints { make in
            make.left.equalTo(ringImageView.snp.right).offset(8)
            make.centerY.equalToSuperview()
            make.height.equalTo(60)
            make.right.equalTo(nameLabel.snp.left).offset(-5)
        }
    }
}

extension TwoViewCell: FSPagerViewDelegate, FSPagerViewDataSource {

    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return modelArray?.count ?? 0
    }

    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {

        let cell = pagerView.dequeueReusableCell(
            withReuseIdentifier: "CustomPagerCell",
            at: index
        ) as! CustomPagerCell

        if let model = modelArray?[index] {
            cell.titleLabel.text = model.reason ?? ""
        }

        return cell
    }

    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        guard let model = modelArray?[index] else { return }
        tapBlock?(model)
    }
}

class CustomPagerCell: FSPagerViewCell {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }

    private func setupUI() {

        contentView.backgroundColor = .clear
        backgroundColor = .clear

        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
