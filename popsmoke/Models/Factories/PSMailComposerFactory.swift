//
//  PSMailComposerFactory.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/27/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit
import MessageUI

class PSMailComposerFactory: NSObject {

	class func mailComposerFor(packet: PSPacket) -> MFMailComposeViewController {
		if( !MFMailComposeViewController.canSendMail() ) {
			//TODO: Handle the errors in a global error alert
			print("Cannot send email.")
		}
		let mailComposer = MFMailComposeViewController()
		mailComposer.setSubject("Have you heard a swift?")
		mailComposer.setMessageBody("This is what they sound like.", isHTML: false)
		for document in packet.documents {
			switch document.documentType {
			case .form:
				let url = URL.init(fileURLWithPath: document.filePath!)
				let fileData = try! Data.init(contentsOf: url)
				mailComposer.addAttachmentData(fileData, mimeType: "application/pdf", fileName: "example")
			case .attachment:
				let fileData = UIImage(contentsOfFile: document.filePath!)
				mailComposer.addAttachmentData(UIImagePNGRepresentation(fileData!)!, mimeType: "image/png", fileName:  "example_png")
			default:
				continue
			}
		}
		return mailComposer
	}
}
