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

class PSFormContainerViewController: UIViewController {

	weak var document: PSDocument?
	private var formViewController: FormViewController?
	@IBOutlet public var containerView: UIView?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		guard document != nil else {
			//TODO: Handle the errors in a global error alert
			return
		}
		formViewController = PSFormViewControllerFactory.viewControllerForForm(type: document!.formType)
		add(formViewController: formViewController!)
	}
	
	func add(formViewController: FormViewController) {
		guard containerView != nil else {
			//TODO: Handle the errors in a global error alert
			return
		}
		
		formViewController.view.backgroundColor = .clear
		formViewController.tableView?.backgroundColor = .clear
		formViewController.tableView?.separatorStyle = .none
		formViewController.tableView?.showsVerticalScrollIndicator = false
		
		addChildViewController(formViewController)
		formViewController.view.translatesAutoresizingMaskIntoConstraints = false
		containerView!.addSubview(formViewController.view)
		NSLayoutConstraint.activate([
			formViewController.view.leadingAnchor.constraint(equalTo: containerView!.leadingAnchor),
			formViewController.view.trailingAnchor.constraint(equalTo: containerView!.trailingAnchor),
			formViewController.view.topAnchor.constraint(equalTo: containerView!.topAnchor),
			formViewController.view.bottomAnchor.constraint(equalTo: containerView!.bottomAnchor)
			])
		formViewController.didMove(toParentViewController: self)
	}

	@IBAction func didBackButton(_ sender: UIButton) {
		_ = navigationController?.popViewController(animated: true)
	}
	
	@IBAction func didSelectCompletionButton(_ sender: UIButton) {
		
		guard let form = formViewController?.form else {
			//TODO: Handle the errors in a global error alert
			return
		}
		/**		let errors = form.validate() // Validate
		if errors.count > 0 {
		// TODO: Display Warning Message
		return
		} */
		let formData = DA31FormFactory.toDictionary(form: form) // Generate PDF Form
		guard let pdf = DA31PDFFiller.fillPDFWithFormData(dictionary: formData) else {
			//TODO: Handle the errors in a global error alert
			return
		}
		guard let pdfVC = PSPDFContainerViewFactory.pdfContainerViewController(withDocument: document!, withPDF: pdf) else {
			//TODO: Handle the errors in a global error alert
			return
		}
		segueTo(viewController: pdfVC)
	}
}
