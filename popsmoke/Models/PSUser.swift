//
//  PSUser.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/31/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

fileprivate let kUserID			= "user_id"
fileprivate let kUserFirstName	= "first_name"
fileprivate let kUserLastName	= "last_name"
fileprivate let kUserCreatedAt	= "created"

class PSUser: NSObject, NSCoding {

	var userID: String?
	var firstName: String?
	var middleInitial: String?
	var lastName: String?
	var rank: USArmyRank?
	var createdAt: Date?

	override init() {
		super.init()
		userID		= ""
		firstName	= ""
		lastName	= ""
		createdAt	= Date()
	}
	
	fileprivate class func dateFormatter() -> DateFormatter {
		let formatter = DateFormatter()
		formatter.dateStyle = .long
		formatter.timeStyle = .medium
		return formatter
	}
	
	// MARK: - NSCoding
	
	required init(coder aDecoder: NSCoder) {
		userID = aDecoder.decodeObject(forKey: kUserID) as? String ?? ""
		firstName = aDecoder.decodeObject(forKey: kUserFirstName) as? String ?? ""
		lastName = aDecoder.decodeObject(forKey: kUserLastName) as? String ?? ""
		let dateString = aDecoder.decodeObject(forKey: kUserCreatedAt) as? String ?? ""
		PSUser.dateFormatter().date(from: dateString)
	}
	
	func encode(with aCoder: NSCoder) {
		aCoder.encode(userID, forKey: kUserID)
		aCoder.encode(firstName, forKey: kUserFirstName)
		aCoder.encode(lastName, forKey: kUserLastName)
		let dateString = PSUser.dateFormatter().string(from:createdAt!)
		aCoder.encode(dateString, forKey: kUserCreatedAt)
	}
}
