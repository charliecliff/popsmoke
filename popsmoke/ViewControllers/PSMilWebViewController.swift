//
//  PSWebFormViewController.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/28/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

fileprivate let container_segue = "container_segue"

class PSMilWebViewController: UIViewController, UIWebViewDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
	
	private var authenticated = false
	
	weak var document: PSDocument?
	@IBOutlet weak var webView: UIWebView?

    override func viewDidLoad() {
        super.viewDidLoad()
		
		guard let address = document?.webAddress else {
			//TODO: Handle the errors in a global error alert
			return
		}
		let url = URL.init(string: address)
		let request = URLRequest.init(url: url!)
		self.webView?.loadRequest(request)
		// TODO: Start the Spinner
    }

	// MARK: - URLSessionDelegate
	
	func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?){
		
	}
	
	func urlSession(_ session: URLSession,
	                didReceive challenge: URLAuthenticationChallenge,
	                completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void){
		
		let credential = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
		challenge.sender!.use(credential, for: challenge)
	}
	
	func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
		
	}
	
	// MARK: - NSURLConnectionDelegate
	
	func connectionShouldUseCredentialStorage(_ connection: NSURLConnection) -> Bool {
		
		// TODO: Some Logic
		return false
	}

	func connection(_ connection: NSURLConnection, willSendRequestFor challenge: URLAuthenticationChallenge){
		
		// TODO: Some Logic
		let credential = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
		challenge.sender!.use(credential, for: challenge)
	}
	
	func connection(_ connection: NSURLConnection, didFailWithError error: Error){
		// TODO: Stop the Spinner
		//TODO: Handle the errors in a global error alert
		
	}
	
	// MARK: - URLSessionDataDelegate

	func urlSession(_ session: URLSession,
	                dataTask: URLSessionDataTask,
	                didReceive response: URLResponse,
	                completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
		
		authenticated = true
		session.invalidateAndCancel()
		guard let address = document?.webAddress else {
			//TODO: Handle the errors in a global error alert
			return
		}
		let url = URL.init(string: address)
		let request = URLRequest.init(url: url!)
		self.webView?.loadRequest(request)
	}
	
	// MARK: - NSURLConnectionDataDelegate

	
	func connectionDidFinishLoading(_ connection: NSURLConnection) {
		
		guard let address = document?.webAddress else {
			//TODO: Handle the errors in a global error alert
			return
		}
		let url = URL.init(string: address)
		let request = URLRequest.init(url: url!)
		self.webView?.loadRequest(request)
	}
	
	func connection(_ connection: NSURLConnection, didReceive response: URLResponse){
		
		authenticated = true
		connection.cancel()
		guard let address = document?.webAddress else {
			//TODO: Handle the errors in a global error alert
			return
		}
		let url = URL.init(string: address)
		let request = URLRequest.init(url: url!)
		self.webView?.loadRequest(request)
	}
	
	func connection(_ connection: NSURLConnection, didReceive data: Data) {
		
		
	}
	
	// MARK: - UIWebViewDelegate
	
	func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool{
		
		if !authenticated {
			let connection = NSURLConnection.init()
			
			_ = NSURLConnection(request: request, delegate: self, startImmediately: true)
			return false
		}
		return true
	}
	
	func webViewDidStartLoad(_ webView: UIWebView) {
		// TODO: Stop the Spinner

	}
	
	func webViewDidFinishLoad(_ webView: UIWebView) {
		// TODO: Stop the Spinner

	}
	
	func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
		// TODO: Stop the Spinner

	}
}
