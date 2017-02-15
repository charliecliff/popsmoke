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

class PSUser: NSObject, NSCoding {

	var userID: String?
	var firstName: String?
	var middleInitial: String?
	var lastName: String?
	var rank: USArmyRank?
	
	override init() {
		super.init()
		userID		= ""
		firstName	= ""
		lastName	= ""
	}
	
	// MARK: - NSCoding
	
	required init(coder aDecoder: NSCoder) {
		userID = aDecoder.decodeObject(forKey: kUserID) as? String ?? ""
		firstName = aDecoder.decodeObject(forKey: kUserFirstName) as? String ?? ""
		lastName = aDecoder.decodeObject(forKey: kUserLastName) as? String ?? ""
	}
	
	func encode(with aCoder: NSCoder) {
		aCoder.encode(userID, forKey: kUserID)
		aCoder.encode(firstName, forKey: kUserFirstName)
		aCoder.encode(lastName, forKey: kUserLastName)
	}
}
