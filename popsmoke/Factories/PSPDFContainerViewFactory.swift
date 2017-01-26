//
//  PSPDFContainerViewControllerFactory.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/25/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import ILPDFKit

fileprivate let storyboard_id = "PSPDFContainerViewController"

class PSPDFContainerViewFactory: NSObject {

	class func pdfContainerViewController(withDocument document: PSDocument, withPDF pdf: ILPDFDocument) -> PSPDFContainerViewController? {
		
		let storyboard = UIStoryboard.init(name: storyboard_id, bundle: nil)
		guard let vc = storyboard.instantiateInitialViewController() as? PSPDFContainerViewController else {
			return nil
		}
		vc.document = document
		vc.pdf = pdf
		return vc
	}
}
