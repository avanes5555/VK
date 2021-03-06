//
//  VKLoginController.swift
//  VK
//
//  Created by Иван Пуриков on 30/05/2019.
//  Copyright © 2019 Иван Пуриков. All rights reserved.
//

import UIKit
import WebKit

class VKLoginController: UIViewController {
    
    
    @IBOutlet var webView: WKWebView!
        
        {
        didSet {
            webView.navigationDelegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

       var components = URLComponents()
        
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
        URLQueryItem(name: "client_id", value: "6784883"),
        URLQueryItem(name: "scope", value: "262150"),
        URLQueryItem(name: "dispalay", value: "mobile"),
        URLQueryItem(name: "redirect_uri", value: "https://outh.vk.com/blank.html"),
        URLQueryItem(name: "response_type", value: "token"),
        URLQueryItem(name: "v", value: "5.92")
        ]
        let request = URLRequest(url: components.url!)
        webView.load(request)
    }
    
}


extension VKLoginController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
        url.path == "/blank.html",
            let fragment = url.fragment else {decisionHandler(.allow); return}
        let params = fragment.commonPrefix(with: "&")
        .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        print (params)
        
        guard let token = params["access_token"],
            let userIdString = params["user_id"],
            let userId = Int(userIdString) else {
                decisionHandler(.allow)
                return
        }
        decisionHandler(.cancel)
        
        NetworkingService().loadGroups(token: token)
    }
}
