//
//  DA31ViewController.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/20/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit
import ILPDFKit
import Eureka

let da31_form_container_segue = "da31_form_container_segue"

class DA31ViewController: UIViewController {

	private var formVC: DA31FormViewController?

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if (segue.identifier == da31_form_container_segue) {
			guard let destination = segue.destination as? DA31FormViewController else {
				return
			}
			formVC = destination
		}
	}
	
	@IBAction func didSelectCompletionButton(_ sender: UIButton) {
		
		guard let form = formVC?.form else {
			return
		}
		let formData = DA31FormFactory.toDictionary(form: form)
		let formFiller = DA31PDFFiller()
		formFiller.fillPDFQithFormData(dictionary: formData)
		
		let errors = form.validate()
		
		let pdfVC = ILPDFViewController()
		pdfVC.document = formFiller.document
		present(pdfVC, animated: true, completion: nil)
	}
}
