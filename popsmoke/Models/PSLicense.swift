//
//  PSLicense.swift
//  popsmoke
//
//  Created by Charles Cliff on 2/14/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import CoreFoundation

enum LicenseType: String {
	case none		= "NONE"
	case individual	= "INDIVIDUAL"
}

fileprivate let kPurchasedIndividualLicense = "individual_license"

class PSLicense: NSObject, NSCoding {

	private var hasPurchasedIndividualLicense = false
	
	override init() {
		super.init()
	}
	
	// MARK: - Setters
	
	func didPurchaseIndividualLicense() {
		hasPurchasedIndividualLicense = true
	}
	
	// MARK: - State Machine
	
	func type() -> LicenseType {
		if hasPurchasedIndividualLicense {
			return LicenseType.individual
		}
		return LicenseType.none
	}
	
	// MARK: - NSCoding
	
	required init(coder aDecoder: NSCoder) {
		hasPurchasedIndividualLicense = aDecoder.decodeBool(forKey: kPurchasedIndividualLicense)
	}
	
	func encode(with aCoder: NSCoder) {
		aCoder.encode(hasPurchasedIndividualLicense, forKey: kPurchasedIndividualLicense)
	}
}
