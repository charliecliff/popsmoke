//
//  PSFormViewControllerFactory.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/25/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import Eureka

class PSFormViewControllerFactory: NSObject {
	
	class func viewControllerForForm(type: FormType) -> FormViewController {
		
		switch type {
		case .da31:
			return DA31FormViewController()
		default:
			return FormViewController()
		}
	}

}
