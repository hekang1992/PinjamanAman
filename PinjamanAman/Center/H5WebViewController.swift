//
//  H5WebViewController.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/9.
//

import UIKit
import WebKit
import SnapKit

class H5WebViewController: BaseViewController {
    
    var pageUrl: String = ""
    
    private var webView: WKWebView!
    private let progressView = UIProgressView(progressViewStyle: .default)
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupWebView()
        setupProgressView()
        loadPage()
    }
    
    @MainActor
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.removeObserver(self, forKeyPath: "title")
    }
}

// MARK: - UI
extension H5WebViewController {
    
    private func setupUI() {
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.leading.right.equalToSuperview()
            make.height.equalTo(400)
        }
        
        view.addSubview(headView)
        headView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            if self.webView.canGoBack {
                self.webView.goBack()
            }else {
                self.toOrderLisrTargetVc()
            }
        }
        
        view.addSubview(footView)
        footView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(15)
        }
    }
    
    private func setupProgressView() {
        view.addSubview(progressView)
        progressView.tintColor = .systemBlue
        progressView.trackTintColor = .clear
        progressView.progress = 0
        progressView.isHidden = true
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(2)
        }
    }
}

// MARK: - WebView
extension H5WebViewController {
    
    private func setupWebView() {
        let config = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        
        let jsMethods = [
            "emotion",
            "confide",
            "symbol",
            "autumn",
            "possible",
            "Leaves"
        ]
        
        jsMethods.forEach {
            userContentController.add(self, name: $0)
        }
        
        config.userContentController = userContentController
        
        webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        footView.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
    }
    
    private func loadPage() {
        guard let url = URL(string: pageUrl.appendingQueryParams(DeviceInfoManager.getDeviceInfoDictionary())) else { return }
        webView.load(URLRequest(url: url))
    }
}

extension H5WebViewController {
    
    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?
    ) {
        if keyPath == "estimatedProgress" {
            progressView.isHidden = false
            progressView.progress = Float(webView.estimatedProgress)
            if progressView.progress >= 1.0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.progressView.isHidden = true
                    self.progressView.progress = 0
                }
            }
        } else if keyPath == "title" {
            headView.nameLabel.text = webView.title
        }
    }
}

// MARK: - JS -> Native
extension H5WebViewController: WKScriptMessageHandler {
    
    func userContentController(
        _ userContentController: WKUserContentController,
        didReceive message: WKScriptMessage
    ) {
        print("JS 方法：\(message.name)")
        print("参数：\(message.body)")
        
        switch message.name {
        case "emotion":
            handleEmotion(message.body)
        case "confide":
            handleConfide(message.body)
        case "symbol":
            handleSymbol(message.body)
        case "autumn":
            handleAutumn(message.body)
        case "possible":
            handlePossible(message.body)
        case "Leaves":
            handleLeaves(message.body)
        default:
            break
        }
    }
}

// MARK: - JS 方法处理
extension H5WebViewController {
    
    private func handleEmotion(_ body: Any) {
        print("emotion:", body)
    }
    
    private func handleConfide(_ body: Any) {
        print("confide:", body)
    }
    
    private func handleSymbol(_ body: Any) {
        print("symbol:", body)
    }
    
    private func handleAutumn(_ body: Any) {
        print("autumn:", body)
    }
    
    private func handlePossible(_ body: Any) {
        print("possible:", body)
    }
    
    private func handleLeaves(_ body: Any) {
        print("Leaves:", body)
    }
}

// MARK: - WKNavigationDelegate / WKUIDelegate
extension H5WebViewController: WKNavigationDelegate, WKUIDelegate {
    
    func webView(
        _ webView: WKWebView,
        didStartProvisionalNavigation navigation: WKNavigation!
    ) {
        progressView.isHidden = false
    }
    
    func webView(
        _ webView: WKWebView,
        didFinish navigation: WKNavigation!
    ) {
        progressView.isHidden = true
    }
}
