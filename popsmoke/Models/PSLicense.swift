//
//  PSLicense.swift
//  popsmoke
//
//  Created by Charles Cliff on 2/14/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import CoreFoundation

fileprivate let kLicensePurchasedIndividualLicense = "individual_license"

class PSLicense: NSObject {

	private var hasPurchasedIndividualLicense = false
	
	// MARK: - NSCoding
	
	required init(coder aDecoder: NSCoder) {
		hasPurchasedIndividualLicense = aDecoder.decodeBool(forKey: kLicensePurchasedIndividualLicense)
	}
	
	func encode(with aCoder: NSCoder) {
		aCoder.encode(hasPurchasedIndividualLicense, forKey: kLicensePurchasedIndividualLicense)
	}
}
