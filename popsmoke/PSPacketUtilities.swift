//
//  PSPacketUtilities.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/24/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import Foundation

enum PacketType: String {
	case error	= "ERROR"
	case leave	= "Leave"
}

enum DocumentType: String {
	case error		= "ERROR"
	case form		= "form"
	case attachment	= "attachment"
}

enum FormType: String {
	case error	= "ERROR"
	case da31	= "da31"
	case trips	= "trips"
}

enum AttachmentType: String {
	case error				= "ERROR"
	case drivers_license	= "drivers_license"
	case insurance			= "insurance"
}

class PSPacketUtilities: NSObject {

}
