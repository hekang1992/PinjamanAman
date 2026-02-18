//
//  H5WebViewController.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/9.
//

import UIKit
import WebKit
import SnapKit
import StoreKit

class H5WebViewController: BaseViewController {
    
    var pageUrl: String = ""
    
    private var webView: WKWebView!
    private let progressView = UIProgressView(progressViewStyle: .default)
    private let singleLocationManager = SingleLocationService()
    
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
        singleLocationManager.requestCurrentLocation { result in }
        let body = body as? [String] ?? []
        let productID = body.first ?? ""
        let orderID = body.last ?? ""
        
        Task {
            try? await Task.sleep(nanoseconds: 3_000_000_000)
            await self.lycOtherCocelleInfo(type: "9",
                                           orderID: orderID,
                                           productID: productID,
                                           onetime: String(Int(Date().timeIntervalSince1970)),
                                           twotime: String(Int(Date().timeIntervalSince1970)))
        }
        
    }
    
    private func handleConfide(_ body: Any) {
        guard let pageUrl = body as? String, !pageUrl.isEmpty else {
            return
        }
        
        if pageUrl.hasPrefix(scheme_url) {
            DeepLinkNavigator.navigate(to: pageUrl, from: self)
        } else if pageUrl.hasPrefix("http") {
            self.pageUrl = pageUrl
            self.loadPage()
        }
    }
    
    private func handleSymbol(_ body: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func handleAutumn(_ body: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil)
    }
    
    private func handlePossible(_ body: Any) {
        
        guard let email = body as? String, !email.isEmpty else {
            return
        }
        
        let phone = UserSessionManager.shared.phone ?? ""
        let body = "Pinjaman Aman: \(phone)"
        
        guard let encodedBody = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let emailURL = URL(string: "mailto:\(email)?body=\(encodedBody)"),
              UIApplication.shared.canOpenURL(emailURL) else {
            return
        }
        
        UIApplication.shared.open(emailURL)
    }
    
    private func handleLeaves(_ body: Any) {
        guard #available(iOS 14.0, *),
              let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        SKStoreReviewController.requestReview(in: windowScene)
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
