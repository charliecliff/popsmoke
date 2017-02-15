//
//  PSProfile.swift
//  popsmoke
//
//  Created by Charles Cliff on 2/13/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

enum LicenseType: String {
	case none		= "NONE"
	case individual	= "INDIVIDUAL"
}

class PSProfile: NSObject {

	// Options
	var licenseType									= LicenseType.none
	private var hasEnabledPushNotifications			= false
	private var hasEnabledAutofill					= false
	private var hasEnabledPersonalInfoPersistence	= false
	private var hasEnabledDocumentPersistence		= false
	
	// Informatiom
	var user: PSUser?
	var address: PSAddress?
	
	// MARK: - Getters

	func pushNotificationsEnabled() -> Bool {
		if ((licenseType != .none) && (hasEnabledPushNotifications)){
			return true
		}
		return false
	}
	
	func autofillEnabled() -> Bool {
		if ((licenseType != .none) && (hasEnabledAutofill)){
			return true
		}
		return false
	}
	
	func personalInfoPersistenceEnabled() -> Bool {
		if ((licenseType != .none) && (hasEnabledPersonalInfoPersistence)){
			return true
		}
		return false
	}
	
	// MARK: - Setters
	
	// MARK: - NSCoding
	
	required init(coder aDecoder: NSCoder) {
//		userID = aDecoder.decodeObject(forKey: kUserID) as? String ?? ""
//		firstName = aDecoder.decodeObject(forKey: kUserFirstName) as? String ?? ""
//		lastName = aDecoder.decodeObject(forKey: kUserLastName) as? String ?? ""
	}
	
	func encode(with aCoder: NSCoder) {
//		aCoder.encode(userID, forKey: kUserID)
//		aCoder.encode(firstName, forKey: kUserFirstName)
//		aCoder.encode(lastName, forKey: kUserLastName)
	}
}
