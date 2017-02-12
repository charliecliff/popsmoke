//
//  PSDownloadUtility.swift
//  popsmoke
//
//  Created by Charles Cliff on 2/11/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import CoreFoundation

class PSMilDownloadUtility: NSObject, NSURLConnectionDelegate, NSURLConnectionDataDelegate {

	private static let sharedInstance = PSMilDownloadUtility()

	private var downloadedData: Data?
	private var url: URL?
	private var completion: ((_ filePath: String?, _ error: NSError?) -> Void)?
	
	@available(iOS, deprecated: 9.0)
	class func download(url: URL, completion: ((_ filePath: String?, _ error: NSError?) -> Void)?) {
		PSMilDownloadUtility.sharedInstance.completion = completion
		PSMilDownloadUtility.sharedInstance.url = url
		let request = URLRequest.init(url: PSMilDownloadUtility.sharedInstance.url!)
		_ = NSURLConnection(request: request, delegate: PSMilDownloadUtility.sharedInstance, startImmediately: true)
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
		PSErrorHandler.presentError(error: error as NSError?)
	}
	
	// MARK: - NSURLConnectionDataDelegate
	
	func connection(_ connection: NSURLConnection, didReceive response: URLResponse){
		downloadedData = Data()
	}
	
	func connection(_ connection: NSURLConnection, didReceive data: Data){
		downloadedData?.append(data)
	}
	
	func connectionDidFinishLoading(_ connection: NSURLConnection) {
		let fileName = PSUtilities.fileNameFrom(url: connection.currentRequest.url!)
		let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as String
		let url = NSURL(fileURLWithPath: path)
		let filePath = url.appendingPathComponent(fileName)?.path
		let downloadUrl = NSURL(fileURLWithPath: filePath!)
		do {
			try downloadedData?.write(to: downloadUrl as URL)
			self.completion?(downloadUrl.absoluteString, nil)
		}
		catch {
			let error = NSError.init(domain: "DOMAIN", code: 600, userInfo: nil)
			self.completion?(nil, error)
		}
	}
}
