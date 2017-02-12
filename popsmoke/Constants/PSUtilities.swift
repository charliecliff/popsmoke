//
//  PSUtilities.swift
//  popsmoke
//
//  Created by Charles Cliff on 2/8/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

class PSUtilities: NSObject {

	class func randomID() -> String {
		guard let uuid = CFUUIDCreateString(nil, CFUUIDCreate(nil)) else {
			PSErrorHandler.presentErrorWith(title: "Whoops!", message: "We weren't able to create a randomized UID")
			assert(false)
			return "0"
		}
		return "\(uuid)"
	}
	
	class func urlStringIsPDF(url: String) -> Bool {
		let last4 = String(url.characters.suffix(4))
		return (last4 == ".pdf")
	}
	
	class func fileNameFrom(url: URL) -> String {
		let urlPath = url.absoluteString
		let components = urlPath.components(separatedBy: "/")
		return components.last!
	}

}
