//
//  PSWebFormViewController.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/28/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

fileprivate let container_segue = "container_segue"

class PSWebFormViewController: UIViewController, UIWebViewDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
	
	
	
	var fuckOff = false
	
	weak var document: PSDocument?
	@IBOutlet weak var webView: UIWebView?

    override func viewDidLoad() {
        super.viewDidLoad()
		
		
		if let address = document?.webAddress {
			let url = URL.init(string: "https://trips.safety.army.mil/army/TRiPSAssessment")
			let request = URLRequest.init(url: url!)
			self.webView?.loadRequest(request)
		}
		

    }
	
	// MARK: - UIWebViewDelegate
	
	func connectionShouldUseCredentialStorage(_ connection: NSURLConnection) -> Bool {
		
		return false
	}

	func connection(_ connection: NSURLConnection, willSendRequestFor challenge: URLAuthenticationChallenge){
	
		
		let credential = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
		challenge.sender!.use(credential, for: challenge)

//		challenge.sender?.continueWithoutCredential(for: challenge)
		
	}
	
	func connection(_ connection: NSURLConnection, didFailWithError error: Error){
		
		
		
		
	}
	
	
	
	func connectionDidFinishLoading(_ connection: NSURLConnection) {
		
		let url = URL.init(string: "https://trips.safety.army.mil/army/TRiPSAssessment")
		let request = URLRequest.init(url: url!)
		self.webView?.loadRequest(request)
		
		
	}
	
	func connection(_ connection: NSURLConnection,
	                didReceive response: URLResponse){
		
		fuckOff = true
		connection.cancel()

		let url = URL.init(string: "https://trips.safety.army.mil/army/TRiPSAssessment")
		let request = URLRequest.init(url: url!)
		self.webView?.loadRequest(request)
	}
	func connection(_ connection: NSURLConnection, didReceive data: Data) {
		
		
		
		
	}
	
		
	
	// MARK: - UIWebViewDelegate
	
	func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool{
		
		
//		let conn = NSURLConnection.init()
//		conn.currentRequest = request
		
		if !fuckOff {
			var conn = NSURLConnection(request: request, delegate: self, startImmediately: true)
			return false
		}
		return true
	}
	
	func webViewDidStartLoad(_ webView: UIWebView) {
		
	}
	
	func webViewDidFinishLoad(_ webView: UIWebView) {
		
	}
	
	func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
		
	}
}
