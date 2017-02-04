//
//  PSPersonalInfoUtilities.swift
//  popsmoke
//
//  Created by Charles Cliff on 2/1/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import Foundation

enum USArmyRank: String {
	case PVT	= "PVT"
	case PVT2	= "PV2"
	case PFC	= "PFC"
	case SPC	= "SPC"
	case CPL	= "CPL"
	case SGT	= "SGT"
	case SSG	= "SSG"
	case SFC	= "SFC"
	case SG1	= "1SG"
	case SGM	= "SGM"
	case CSM	= "CSM"
	case WO1	= "WO1"
	case CW2	= "CW2"
	case CW3	= "CW3"
	case CW4	= "CW4"
	case CW5	= "CW5"
	case LT2	= "2LT"
	case LT1	= "1LT"
	case CPT	= "CPT"
	case MAJ	= "MAJ"
	case LTC	= "LTC"
	case COL	= "COL"
	case BG		= "BG"
	case MG		= "MG"
	case LTG	= "LTG"
	case GEN	= "GEN"
}

class PSPersonalInfoUtilities: NSObject {

	class func ranks() -> [USArmyRank] {
		return [.PVT, .PVT2, .PFC, .SPC, .CPL, .SGT, .SSG, .SFC, .SG1, .SGM, .CSM, .WO1, .CW2, .CW3, .CW4, .CW5, .LT2, .LT1, .CPT, .MAJ, .LTC, .COL, .BG, .MG, .LTG, .GEN]
	}
}

