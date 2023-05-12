//
//  AuthViewController.swift
//  Spotify
//
//  Created by Alex Ochigov on 5/10/23.
//

import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate {
    
    private let webView: WKWebView = {
        let config = WKWebViewConfiguration()
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: config)
        
        return webView
    }()
    
    public var completionHandler: ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "Sign in"
        view.backgroundColor = .systemBackground
        webView.navigationDelegate = self
        view.addSubview(webView)
        guard let url = AuthManager.shared.authURL else {
            return
        }
        
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        webView.frame = view.bounds
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let url = navigationAction.request.url,
           let scheme = url.scheme?.lowercased(),
           scheme == "spotify" {
            
            guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
                  let params = components.queryItems,
                  let code = params.first(where: { $0.name == "code" })?.value else {
                // handle error
                return decisionHandler(.cancel)
            }
            
            
            print(code)
            
            
            return decisionHandler(.cancel)
            
        }
        decisionHandler(.allow)
    }
    
}
