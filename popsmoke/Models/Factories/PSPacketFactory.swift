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
			//TODO: Handle the errors in a global error alert
			return nil
		}
		let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as String
		let url1 = NSURL(fileURLWithPath: path)
		let destinationPath = url1.appendingPathComponent("\(uuid)")?.path
		return destinationPath
	}
	
	class func newPacketID() -> String? {
		guard let uuid = CFUUIDCreateString(nil, CFUUIDCreate(nil)) else {
			//TODO: Handle the errors in a global error alert
			return nil
		}
		return "\(uuid)"
	}

	class func createDA31() -> PSPacket? {
		guard let path = Bundle.main.path(forResource: "DA31_Packet", ofType:"plist") else {
			//TODO: Handle the errors in a global error alert
			return nil
		}
		guard let packetDictionary = NSDictionary(contentsOfFile:path) as? [String : Any?] else {
			//TODO: Handle the errors in a global error alert
			return nil
		}
		let packet = PSPacket.init(dictionary: packetDictionary)
		if let newPacketID = PSPacketFactory.newPacketID() {
			packet.packetID = newPacketID
		}
		return packet
	}
}


