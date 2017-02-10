//
//  PSPersonalInfoUtilities.swift
//  popsmoke
//
//  Created by Charles Cliff on 2/1/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import Foundation

enum USArmyRank: String {
	case ERR	= "   "
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

	class func ranks() -> [String] {
		return [USArmyRank.ERR.rawValue, USArmyRank.PVT.rawValue, USArmyRank.PVT2.rawValue, USArmyRank.PFC.rawValue, USArmyRank.SPC.rawValue, USArmyRank.CPL.rawValue, USArmyRank.SGT.rawValue, USArmyRank.SSG.rawValue, USArmyRank.SFC.rawValue, USArmyRank.SG1.rawValue, USArmyRank.SGM.rawValue, USArmyRank.CSM.rawValue, USArmyRank.WO1.rawValue, USArmyRank.CW2.rawValue, USArmyRank.CW3.rawValue, USArmyRank.CW4.rawValue, USArmyRank.CW5.rawValue, USArmyRank.LT2.rawValue, USArmyRank.LT1.rawValue, USArmyRank.CPT.rawValue, USArmyRank.MAJ.rawValue, USArmyRank.LTC.rawValue, USArmyRank.COL.rawValue, USArmyRank.BG.rawValue, USArmyRank.MG.rawValue, USArmyRank.LTG.rawValue, USArmyRank.GEN.rawValue]
	}
}

