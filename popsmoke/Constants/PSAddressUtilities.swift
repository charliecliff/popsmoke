//
//  PSAddressUtilities.swift
//  popsmoke
//
//  Created by Charles Cliff on 2/1/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import Foundation

enum USState: String {
	case Alabama				= "AL"
	case Alaska					= "AK"
	case Arizona				= "AZ"
	case Arkansas				= "AR"
	case California				= "CA"
	case Colorado				= "CO"
	case Connecticut			= "CT"
	case Delaware				= "DE"
	case District_of_Columbia	= "DC"
	case Florida				= "FL"
	case Georgia				= "GA"
	case Hawaii					= "HI"
	case Idaho					= "ID"
	case Illinois				= "IL"
	case Indiana				= "IN"
	case Iowa					= "IA"
	case Kansas					= "KS"
	case Kentucky				= "KY"
	case Louisiana				= "LA"
	case Maine					= "ME"
	case Montana				= "MT"
	case Nebraska				= "NE"
	case Nevada					= "NV"
	case New_Hampshire			= "NH"
	case New_Jersey				= "NJ"
	case New_Mexico				= "NM"
	case New_York				= "NY"
	case North_Carolina			= "NC"
	case North_Dakota			= "ND"
	case Ohio					= "OH"
	case Oklahoma				= "OK"
	case Oregon					= "OR"
	case Maryland				= "MD"
	case Massachusetts			= "MA"
	case Michigan				= "MI"
	case Minnesota				= "MN"
	case Mississippi			= "MS"
	case Missouri				= "MO"
	case Pennsylvania			= "PA"
	case Rhode_Island			= "RI"
	case South_Carolina			= "SC"
	case South_Dakota			= "SD"
	case Tennessee				= "TN"
	case Texas					= "TX"
	case Utah					= "UT"
	case Vermont				= "VT"
	case Virginia				= "VA"
	case Washington				= "WA"
	case West_Virginia			= "WV"
	case Wisconsin				= "WI"
	case Wyoming				= "WY"
}

class PSAddressUtilities: NSObject {

	class func states() -> [USState] {
		return [.Alabama, .Alaska, .Arizona, .Arkansas, .California, .Colorado, .Connecticut, .Delaware, .District_of_Columbia, .Florida, .Georgia, .Hawaii, .Idaho, .Illinois, .Indiana, .Iowa, .Kentucky, .Louisiana, .Maine, .Montana, .Nebraska, .Nevada, .New_Hampshire, .New_Jersey, .New_Mexico, .New_York, .North_Carolina, .North_Dakota, .Ohio, .Oklahoma, .Oregon, .Maryland, .Massachusetts, .Michigan, .Minnesota, .Mississippi, .Missouri, .Pennsylvania, .Rhode_Island, .South_Carolina, .South_Dakota, .Tennessee, .Texas, .Utah, .Vermont, .Virginia, .Washington, .West_Virginia, .Wisconsin, .Wyoming]
	}
}
