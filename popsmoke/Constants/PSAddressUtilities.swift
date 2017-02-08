//
//  PSAddressUtilities.swift
//  popsmoke
//
//  Created by Charles Cliff on 2/1/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import Foundation

enum USState: String {
	case ERR					= "  "
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

	class func states() -> [String] {
		return [USState.ERR.rawValue, USState.Alabama.rawValue, USState.Alaska.rawValue, USState.Arizona.rawValue, USState.Arkansas.rawValue, USState.California.rawValue, USState.Colorado.rawValue, USState.Connecticut.rawValue, USState.Delaware.rawValue, USState.District_of_Columbia.rawValue, USState.Florida.rawValue, USState.Georgia.rawValue, USState.Hawaii.rawValue, USState.Idaho.rawValue, USState.Illinois.rawValue, USState.Indiana.rawValue, USState.Iowa.rawValue, USState.Kentucky.rawValue, USState.Louisiana.rawValue, USState.Maine.rawValue, USState.Montana.rawValue, USState.Nebraska.rawValue, USState.Nevada.rawValue, USState.New_Hampshire.rawValue, USState.New_Jersey.rawValue, USState.New_Mexico.rawValue, USState.New_York.rawValue, USState.North_Carolina.rawValue, USState.North_Dakota.rawValue, USState.Ohio.rawValue, USState.Oklahoma.rawValue, USState.Oregon.rawValue, USState.Maryland.rawValue, USState.Massachusetts.rawValue, USState.Michigan.rawValue, USState.Minnesota.rawValue, USState.Mississippi.rawValue, USState.Missouri.rawValue, USState.Pennsylvania.rawValue, USState.Rhode_Island.rawValue, USState.South_Carolina.rawValue, USState.South_Dakota.rawValue, USState.Tennessee.rawValue, USState.Texas.rawValue, USState.Utah.rawValue, USState.Vermont.rawValue, USState.Virginia.rawValue, USState.Washington.rawValue, USState.West_Virginia.rawValue, USState.Wisconsin.rawValue, USState.Wyoming.rawValue]
	}
}
