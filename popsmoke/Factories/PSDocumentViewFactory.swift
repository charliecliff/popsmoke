//
//  PSDocumentViewFactory.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/25/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

class PSDocumentViewFactory: NSObject {

	class func documentView(forDocument document: PSDocument?) -> UIViewController? {
		
		guard document != nil else {
			return nil
		}
		switch document!.documentType {
		case DocumentType.form:
			guard let vc = PSFormContainerViewFactory.formContainerView(withDocument: document) else {
				return nil
			}
			return vc
		case DocumentType.attachment:
			let storyboard = UIStoryboard.init(name: "PSPhotoViewController", bundle: nil)
			guard let vc = storyboard.instantiateInitialViewController() as? PSPhotoViewController else {
				return nil
			}
			return vc
		default:
			return nil
		}
	}
}
