//
//  PSDocument.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/25/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

let kDocumentIcon			= "icon"
let kDocumentTitle			= "name"
let kDocumentFilePath		= "path"
let kDocumentType			= "type"
let kDocumentFormType		= "form_type"
let kDocumentAttachmentType	= "attachment_type"
let kDocumentWebURL			= "url"

class PSDocument: NSObject, NSCoding {

	var icon: String?
	var title: String?
	var filePath: String?
	var webAddress: String?
	var documentType: DocumentType		= DocumentType.error
	var formType: FormType				= FormType.error
	var attachmentType: AttachmentType	= AttachmentType.error
	
	init(dictionary : [String : Any?]) {
		super.init()
		
		if let tmp = dictionary[kDocumentTitle] as? String? {
			title = tmp
		}
		if let tmp = dictionary[kDocumentIcon] as? String? {
			icon = tmp
		}
		if let tmp = dictionary[kDocumentWebURL] as? String? {
			webAddress = tmp
		}
		if let tmp = dictionary[kDocumentType] as? String? {
			documentType = DocumentType(rawValue: tmp!)!
		}
		if let tmp = dictionary[kDocumentFormType] as? String? {
			formType = FormType(rawValue: tmp!)!
		}
		if let tmp = dictionary[kDocumentAttachmentType] as? String? {
			attachmentType = AttachmentType(rawValue: tmp!)!
		}

	}
	
	// MARK: - NSCoding

	required init(coder aDecoder: NSCoder) {
		icon = aDecoder.decodeObject(forKey: kDocumentIcon) as? String ?? ""
		title = aDecoder.decodeObject(forKey: kDocumentTitle) as? String ?? ""
		filePath = aDecoder.decodeObject(forKey: kDocumentFilePath) as? String ?? ""
		webAddress = aDecoder.decodeObject(forKey: kDocumentWebURL) as? String ?? ""
		let tmp1 = aDecoder.decodeObject(forKey: kDocumentType) as? String ?? "ERROR"
		documentType = DocumentType(rawValue: tmp1)!
		let tmp2 = aDecoder.decodeObject(forKey: kDocumentFormType) as? String ?? "ERROR"
		formType = FormType(rawValue: tmp2)!
		let tmp3 = aDecoder.decodeObject(forKey: kDocumentAttachmentType) as? String ?? "ERROR"
		attachmentType = AttachmentType(rawValue: tmp3)!
	}
	
	func encode(with aCoder: NSCoder) {
		aCoder.encode(icon, forKey: kDocumentIcon)
		aCoder.encode(title, forKey: kDocumentTitle)
		aCoder.encode(filePath, forKey: kDocumentFilePath)
		aCoder.encode(webAddress, forKey: kDocumentWebURL)
		aCoder.encode(documentType.rawValue, forKey: kDocumentType)
		aCoder.encode(formType.rawValue, forKey: kDocumentFormType)
		aCoder.encode(attachmentType.rawValue, forKey: kDocumentAttachmentType)
	}
}
