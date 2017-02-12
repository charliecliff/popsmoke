//
//  PSWebContainerViewController.swift
//  popsmoke
//
//  Created by Charles Cliff on 2/9/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

fileprivate let container_segue = "container_segue"

class PSWebContainerViewController: UIViewController, PSMilWebDelegate {

	private var pdfURL: URL?
	weak var document: PSDocument?
	weak var webView: PSMilWebViewController?
	@IBOutlet weak var bottomViewConstraint: NSLayoutConstraint?

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == container_segue {
			guard let vc = segue.destination as? PSMilWebViewController else {
				PSErrorHandler.presentErrorWith(title: "Whoops!", message: "We had trouble with our segue!")
				return
			}
			webView = vc
			vc.document = document
			vc.delegate = self
		}
	}
	
	private func setDownloadButton(hidden: Bool, animated: Bool) {
		if hidden {
			bottomViewConstraint?.constant = -64
		} else {
			bottomViewConstraint?.constant = 0
		}
		var duration = 0.0
		if  animated {
			duration = 0.5
		}
		UIView.animate(withDuration: duration) {
			self.view.layoutIfNeeded()
		}
	}
	
	@IBAction func didPressBackButton(_ sender: UIButton) {
		_ = navigationController?.popViewController(animated: true)
	}
	
	@IBAction func didPressDownloadButton(_ sender: UIButton) {
		guard pdfURL != nil else {
			return
		}
		PSMilDownloadUtility.download(url: pdfURL!) { (filePath, error) in
			if error == nil {
				self.document?.filePath = filePath
				_ = self.navigationController?.popViewController(animated: true)
			} else {
				// TODO: Handle this global error
			}
		}
	}
	
	// MARK: - PSMilWebDelegate

	func didLoadURL(url: URL) {
		if PSUtilities.urlStringIsPDF(url: url.absoluteString) {
			pdfURL = url
			setDownloadButton(hidden: false, animated: true)
		} else {
			pdfURL = nil
			setDownloadButton(hidden: true, animated: true)
		}
	}
}
