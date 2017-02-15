//
//  PSFormContainerViewFactory.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/25/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

fileprivate let storyboard_id = "PSFormContainer"

class PSFormContainerViewFactory: NSObject {

	class func formContainerView(withDocument document: PSDocument?) -> PSFormContainerViewController? {
		let storyboard = UIStoryboard.init(name: storyboard_id, bundle: nil)
		guard let vc = storyboard.instantiateInitialViewController() as? PSFormContainerViewController else {
			return nil
		}
		guard document != nil else {
			return nil
		}
		vc.document = document
		return vc
	}
	
	class func formContainerViewForPersonalInfo() -> PSFormContainerViewController? {
		let storyboard = UIStoryboard.init(name: storyboard_id, bundle: nil)
		guard let vc = storyboard.instantiateInitialViewController() as? PSFormContainerViewController else {
			return nil
		}
		let formVC = PSFormViewControllerFactory.viewControllerForForm(type: .personalInfo)
		vc.formViewController = formVC
		return vc
	}
}

