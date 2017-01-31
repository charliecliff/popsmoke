//
//  PSUserFactory.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/31/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

class PSUserFactory: NSObject {

	class func userIDFromDictionary(userDictionary: [String: String]) -> String {
		return userDictionary[kKeyUserID]!
	}
	
	class func userForDictionary(userDictionary: [String: String]) -> PSUser? {
		let newUser = PSUser()
//		newUser.firstName = userDictionary[kKeyFirstName]
//		newUser.lastName  = userDictionary[kKeyLastName]
//		newUser.userid    = userDictionary[kKeyUserID]
//		newUser.curatedTripIDs      = [String]()
//		newUser.recommendedTripIDs  = [String]()
//		newUser.promotedTripIDs     = [String]()
		return newUser
	}
}
