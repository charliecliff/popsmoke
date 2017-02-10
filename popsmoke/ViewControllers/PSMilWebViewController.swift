//
//  PSWebFormViewController.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/28/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//
// We are implementing our own HTTPS Certificate Evaluation according to Apple Technical Note - 2232:
// https://developer.apple.com/library/content/technotes/tn2232/_index.html#//apple_ref/doc/uid/DTS40012884-CH1-SECCUSTOMCERT
// This is because the .mil Security Certificate is not available to the list of commercially available
// security certificates.
//

import UIKit
import SVProgressHUD

fileprivate let container_segue = "container_segue"

class PSMilWebViewController: UIViewController, UIWebViewDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
	
	private var authenticated = false
	weak var document: PSDocument?
	@IBOutlet weak var webView: UIWebView?

    override func viewDidLoad() {
        super.viewDidLoad()
		SVProgressHUD.show(withStatus: "Connecting...")
		loadWebAddress()
    }
	
	private func loadWebAddress() {
		guard let address = document?.webAddress else {
			PSErrorHandler.presentErrorWith(title: "Whoops!", message: "Trying to oad a Document in a Web View Without a valid URL.")
			return
		}
		let url = URL.init(string: address)
		let request = URLRequest.init(url: url!)
		self.webView?.loadRequest(request)
	}
	
	// MARK: - NSURLConnectionDelegate
	
	func connectionShouldUseCredentialStorage(_ connection: NSURLConnection) -> Bool {
		if (connection.currentRequest.url?.absoluteString.range(of:"https://trips.safety.army.mil/") != nil) {
			return false
		}
		return true
	}

	func connection(_ connection: NSURLConnection, willSendRequestFor challenge: URLAuthenticationChallenge){
		if (connection.currentRequest.url?.absoluteString.range(of:"https://trips.safety.army.mil/") != nil) {
			let credential = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
			challenge.sender!.use(credential, for: challenge)
		} else {
			challenge.sender!.performDefaultHandling!(for: challenge)
		}
	}
	
	func connection(_ connection: NSURLConnection, didFailWithError error: Error){
		SVProgressHUD.dismiss()
		PSErrorHandler.presentError(error: error as NSError?)
	}
	
	// MARK: - NSURLConnectionDataDelegate
	
	func connectionDidFinishLoading(_ connection: NSURLConnection) {
		authenticated = true
		connection.cancel()
		loadWebAddress()
	}
	
	func connection(_ connection: NSURLConnection, didReceive response: URLResponse){
		authenticated = true
		connection.cancel()
		loadWebAddress()
	}
	
	// MARK: - UIWebViewDelegate
	
	@available(iOS, deprecated: 9.0)
	func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool{
		if !authenticated {
			_ = NSURLConnection(request: request, delegate: self, startImmediately: true)
			return false
		}
		return true
	}
	
	func webViewDidFinishLoad(_ webView: UIWebView) {
		SVProgressHUD.dismiss()
	}
	
	func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
		SVProgressHUD.dismiss()
		PSErrorHandler.presentError(error: error as NSError?)
	}
}
