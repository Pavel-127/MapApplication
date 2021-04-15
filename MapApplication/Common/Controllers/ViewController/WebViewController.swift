//
//  WebViewController.swift
//  MapApplication
//
//  Created by macbook on 4/15/21.
//

import WebKit

class WebViewController: ViewController {

    private var stringUrl: String?
    private var url: URL?

    private lazy var webView: WKWebView = {
        let view = WKWebView()
        view.navigationDelegate = self

        return view
    }()

    init(stringUrl: String, title: String? = nil) {
        self.stringUrl = stringUrl
        super.init()

        self.controllerTitle = title
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func initController() {
        super .initController()

        self.view.addSubview(self.view)

        self.webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        self.loadUrl()
    }

    private func loadUrl() {
        if let stringUrl = self.stringUrl, let url = URL(string: stringUrl) {
            self.webView.load(URLRequest(url: url))
        } else if let url = self.url {
            if url.isFileURL {
                self.webView.loadFileURL(url, allowingReadAccessTo: url)
            } else {
                self.webView.load(URLRequest(url: url))
            }
        }
    }
}

extension WebViewController: WKNavigationDelegate {

}
