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
		
		guard document != nil else {
			return nil
		}
		let storyboard = UIStoryboard.init(name: storyboard_id, bundle: nil)
		guard let vc = storyboard.instantiateInitialViewController() as? PSFormContainerViewController else {
			return nil
		}
		vc.document = document
		return vc
	}
}

