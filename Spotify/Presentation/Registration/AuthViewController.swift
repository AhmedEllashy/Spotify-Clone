//
//  AuthViewController.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 27/03/2024.
//

import UIKit
import WebKit
class AuthViewController: UIViewController ,WKNavigationDelegate {
    private let webView : WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .background
        self.view.addSubview(webView)
        webView.navigationDelegate = self
        guard let url = AuthManager.shared.signInUrl else{return}
        webView.load(URLRequest(url: url))
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else{return}
        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: { $0.name == "code" })?.value else{
            print("error getting code ")
            return
        }
        webView.isHidden = true
        AuthManager.shared.getToken(code: code) { [weak self] success in
            if success{
                DispatchQueue.main.async {
                    self?.navigationController?.popToRootViewController(animated: true)
                }
            }else{
                //SHow Error Alert()
                let alert = UIAlertController(title: "ooops", message: "something went wrong!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self?.present(alert,animated: true)
            }
            
            
        }
    }
    
    
}
