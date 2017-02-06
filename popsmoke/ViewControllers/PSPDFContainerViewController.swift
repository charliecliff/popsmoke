//
//  PSPDFContainerViewController.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/25/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit
import ILPDFKit

fileprivate let pdf_container_segue = "pdf_container_segue"

class PSPDFContainerViewController: UIViewController {

	weak var document: PSDocument?
	var pdf: ILPDFDocument?
	@IBOutlet public var saveButton: UIButton?
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == pdf_container_segue {
			guard let destinationVC = segue.destination as? ILPDFViewController else {
				return
			}
			if pdf != nil {
				destinationVC.document = pdf
			}
		}
	}
	
	@IBAction func didSelectBackButton(_ sender: UIButton) {
		navigationController!.popViewController(animated: true)
	}
	
	@IBAction func didSelectSaveButton(_ sender: UIButton) {
		guard let  destinationPath = PSPacketUtilities.newPDFFilePath() else {
			// TODO: Handle the Saving Errors
			return
		}
		var error : NSError?
		pdf?.save(toPath: destinationPath, error: &error)
		if error != nil {
			// TODO: Handle the Saving Errors
		}
		document?.filePath = destinationPath
		navigationController!.popToRootViewController(animated: true)
	}
}
