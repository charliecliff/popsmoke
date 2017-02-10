//
//  PSWebContainerViewController.swift
//  popsmoke
//
//  Created by Charles Cliff on 2/9/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

fileprivate let container_segue = "container_segue"

class PSWebContainerViewController: UIViewController {

	weak var document: PSDocument?

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == container_segue {
			guard let vc = segue.destination as? PSMilWebViewController else {
				PSErrorHandler.presentErrorWith(title: "Whoops!", message: "We had trouble with our segue!")
				return
			}
			vc.document = document
		}
	}
	
	@IBAction func didPressBackButton(_ sender: UIButton) {
		_ = navigationController?.popViewController(animated: true)
	}
}
