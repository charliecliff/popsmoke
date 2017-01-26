//
//  PSPDFContainerViewController.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/25/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit
import ILPDFKit

class PSPDFContainerViewController: UIViewController {

	private let pdf_container_segue = "pdf_container_segue"
	weak var document: PSDocument?
	var pdf: ILPDFDocument?
	@IBOutlet public var saveButton: UIButton?
	@IBOutlet public var editButton: UIButton?
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.isNavigationBarHidden = true
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		self.navigationController?.isNavigationBarHidden = false
	}
	
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
	
	@IBAction func didSelectEditButton(_ sender: UIButton) {
		
		
	}
	
	@IBAction func didSelectSaveButton(_ sender: UIButton) {
		
		// FIXME: This is Test Code to test the Persistence of PDFs
		guard let doumentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as String? else {
			return
		}
		guard let uuid = CFUUIDCreateString(nil, CFUUIDCreate(nil)) else {
			return
		}
		guard let  destinationPath = doumentDirectoryPath.appending("/\(uuid).pdf") as String? else {
			return
		}
		
		pdf?.save(toPath:destinationPath)
		
		if self.navigationController != nil {
			self.navigationController?.popToRootViewController(animated: true)
			return
		}
		self.dismiss(animated: true, completion: nil)
	}
}
