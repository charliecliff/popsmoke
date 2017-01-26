//
//  PSPacket.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/25/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

let kDocuments	= "documents"

class PSPacket: NSObject {

	var title = "ERROR"
	var documents = [PSDocument]()
	
	init(dictionary : [String : Any?]) {
		super.init()
		guard let inputDocuments = dictionary[kDocuments] as? [Any?] else {
			return
		}
		for documentData in inputDocuments {
			guard let tmp  = documentData as? [String : Any?] else {
				continue
			}
			let document = PSDocument.init(dictionary: tmp)
			documents.append(document)
		}
	}
	
	func isCompleted() -> Bool {
		for document in documents {
			if (document.filePath == nil) {
				return false
			}
		}
		return true
	}
}
