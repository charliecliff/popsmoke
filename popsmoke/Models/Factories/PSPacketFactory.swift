//
//  PSPacketFactory.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/29/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

class PSPacketFactory: NSObject {

	@available(*, deprecated)
	class func newFilePath() -> String? {
		
		guard let uuid = CFUUIDCreateString(nil, CFUUIDCreate(nil)) else {
			PSErrorHandler.presentErrorWith(title: "Whoops!", message: "We weren't able to create a randomized UID")
			return nil
		}
		let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as String
		let url1 = NSURL(fileURLWithPath: path)
		let destinationPath = url1.appendingPathComponent("\(uuid)")?.path
		return destinationPath
	}
	
	class func newPacketID() -> String? {
		guard let uuid = CFUUIDCreateString(nil, CFUUIDCreate(nil)) else {
			PSErrorHandler.presentErrorWith(title: "Whoops!", message: "We weren't able to create a randomized UID")
			return nil
		}
		return "\(uuid)"
	}

	class func createDA31() throws -> PSPacket {
		guard let path = Bundle.main.path(forResource: "DA31_Packet", ofType:"plist") else {
			throw PacketError.fileError
		}
		guard let packetDictionary = NSDictionary(contentsOfFile:path) as? [String : Any?] else {
			throw PacketError.createError
		}
		let packet = PSPacket.init(dictionary: packetDictionary)
		if let newPacketID = PSPacketFactory.newPacketID() {
			packet.packetID = newPacketID
		}
		return packet
	}
}


