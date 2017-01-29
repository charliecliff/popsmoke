//
//  PSPacket.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/25/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

let kDocuments	= "documents"

let kPacketTitle		= "title"
let kPacketID			= "id"
let kPacketFilePath		= "filepath"
let kPacketDocuments	= "documents"

class PSPacket: NSObject, NSCoding {

	var title = "ERROR"
	var filepath: String?
	var packetID: String?
	var documents = [PSDocument]()
	
	override init() {
		super.init()
		title = "Error"
		filepath = "Error"
		packetID = "Error"
		documents = [PSDocument]()
	}
	
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

	// MARK: - NSCoding
	
	required init(coder aDecoder: NSCoder) {
		title = aDecoder.decodeObject(forKey: kPacketTitle) as? String ?? ""
		packetID = aDecoder.decodeObject(forKey: kPacketID) as? String ?? ""
		filepath = aDecoder.decodeObject(forKey: kPacketFilePath) as? String ?? ""
		documents = aDecoder.decodeObject(forKey: kPacketDocuments) as? [PSDocument] ?? [PSDocument]()
	}
	
	func encode(with aCoder: NSCoder) {
		aCoder.encode(title, forKey: kPacketTitle)
		aCoder.encode(packetID, forKey: kPacketID)
		aCoder.encode(filepath, forKey: kPacketFilePath)
		aCoder.encode(documents, forKey: kPacketDocuments)
	}
}
