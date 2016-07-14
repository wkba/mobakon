//
//  DetailViewController.swift
//  mobakon
//
//  Created by wakabashi on 2016/07/15.
//  Copyright © 2016年 wakabayashi. All rights reserved.
//

import UIKit
import SwiftyJSON
import TOWebViewController

class DetailViewController: TOWebViewController {
    
    var webview: UIWebView = UIWebView()
    var entry:Entry?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.webview.frame = self.view.bounds
        self.webview.delegate = self;
        self.view.addSubview(self.webview)
        
        let url = NSURL(string: self.entry!.link)
        let request = NSURLRequest(URL: url!)
        
        self.webview.loadRequest(request)
        
    }
    override func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    override func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}
