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

class PSDocument: NSObject {

	var icon: String?
	var title: String?
	var filePath: String?
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
}
