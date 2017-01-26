//
//  UIViewController+Transition.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/25/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

extension UIViewController {
	
	func segueTo(viewController: UIViewController) {
		if self.navigationController != nil {
			self.navigationController?.pushViewController(viewController, animated: true)
			return
		}
		self.present(viewController, animated: true, completion: nil)
	}
}
