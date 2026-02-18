//
//  LoadingView.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/9.
//

import UIKit
import SnapKit

final class LoadingView {
    
    static let shared = LoadingView()
    
    private let maskView = UIView()
    private let containerView = UIView()
    private let indicator = UIActivityIndicatorView(style: .large)
    
    private init() {
        setupUI()
    }
    
    private func setupUI() {
        maskView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        maskView.isUserInteractionEnabled = true
        
        containerView.backgroundColor = .black
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true
        
        indicator.color = .white
        
        containerView.addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
    }
    
}

extension LoadingView {
    
    func show() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared
                .connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .flatMap({ $0.windows })
                .first(where: { $0.isKeyWindow }) else { return }
            
            if self.maskView.superview == nil {
                window.addSubview(self.maskView)
                self.maskView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
                
                self.maskView.addSubview(self.containerView)
                self.containerView.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                    make.size.equalTo(100)
                }
            }
            
            self.indicator.startAnimating()
            self.maskView.isHidden = false
        }
    }
    
    func hide() {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.maskView.removeFromSuperview()
        }
    }
    
    
}
