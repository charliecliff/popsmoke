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
	
	class func newUserForSocialMediaDictionary(userDictionary: [String: String]) -> PSUser? {
		let newUser = PSUser()
		newUser.userID    = userDictionary[kKeyUserID]
		newUser.firstName = userDictionary[kKeyFirstName]
		newUser.lastName  = userDictionary[kKeyLastName]
		return newUser
	}
}
