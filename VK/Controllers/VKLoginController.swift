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

    @IBOutlet weak var webView: WKWebView! {
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
    
}
