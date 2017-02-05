//
//  PSDocumentCollectionViewCell.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/24/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

class PSDocumentCollectionViewCell: UICollectionViewCell {
	
	weak var document: PSDocument?
	var documentType: DocumentType	= DocumentType.error
	var formType: FormType			= FormType.error
	var attachmentType: FormType	= FormType.error
	
	@IBOutlet weak var iconImageView: UIImageView?
	@IBOutlet weak var documentLabel: UILabel?

	func configure(document: PSDocument) {
		
		self.document = document

		if let imageName = document.icon {
			iconImageView?.image = UIImage.init(named: imageName)
		}
		if let title = document.title {
			documentLabel?.text = title
		}
		documentType	= document.documentType
		formType		= document.formType
		attachmentType	= document.formType
		
		set(completed: (self.document?.filePath != nil))
	}
	
	func set(completed: Bool) {
		if completed {
			self.iconImageView?.image = UIImage.init(named: "form_complete")
		} else {
			self.iconImageView?.renderWithColor(color: dark_grey)
		}
	}
}
