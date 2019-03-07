//
//  ViewController.swift
//  WriteReviewOnGoogle
//
//  Created by Kondya on 07/03/19.
//  Copyright © 2019 Kondya. All rights reserved.
//

import UIKit
import WebKit

protocol ViewControllerDelegate {
    func getViewControllerResultSuccess()
}

class ViewController: UIViewController {

    
    
    var delegate: ViewControllerDelegate?
    var count = 0
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WebCacheCleaner.clean()
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = false
        let url = URL(string: "https:www.gmail.com")!
        webView.load(URLRequest(url: url))
   
    }

}



extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            print("link")
            
            decisionHandler(WKNavigationActionPolicy.cancel)
            return
        }
        print("no link")
        print(webView.url ?? nil ?? "kkk")
        let uuu = "\(String(describing: webView.url ?? nil))"
        if uuu.contains("https://www.google.com/search?hl="){
            self.count = count+1
            if self.count >= 11 {
//                self.navigationController?.popViewController(animated: true)
//                self.delegate?.getViewControllerResultSuccess()
            }
           
        }
        print(count)
        
        decisionHandler(WKNavigationActionPolicy.allow)
    }
   
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let host = webView.url?.host {
            self.navigationItem.title = host
            if host == "mail.google.com"{
                if  let url1 = URL(string:"https://search.google.com/local/writereview?placeid=ChIJrTLr-GyuEmsRBfy61i59si0"){
                    self.webView.load(URLRequest(url: url1))
                }
            }
            
            
        }
    }
}



final class WebCacheCleaner {
    
    class func clean() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        print("[WebCacheCleaner] All cookies deleted")
        
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
                print("[WebCacheCleaner] Record \(record) deleted")
            }
        }
    }
    
}
