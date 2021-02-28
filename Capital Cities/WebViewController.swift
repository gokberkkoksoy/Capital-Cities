//
//  WebViewController.swift
//  Capital Cities
//
//  Created by Gökberk Köksoy on 28.02.2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var webPage = "https://en.wikipedia.org/wiki/"
    var city: String?
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let selectedCity = city {
            webPage += selectedCity
            let url = URL(string: webPage)!
            webView.load(URLRequest(url: url))
        }
        webView.allowsBackForwardNavigationGestures = true
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let back = UIBarButtonItem(title: "Back", style: .plain, target: webView, action: #selector(webView.goBack))
        let forward = UIBarButtonItem(title: "Forward", style: .plain, target: webView, action: #selector(webView.goForward))
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [back,forward,spacer,refresh]
        navigationController?.isToolbarHidden = false

    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

}
